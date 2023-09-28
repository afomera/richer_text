module RicherText
  class HTMLVisitor
    include ActionView::Helpers::TagHelper

    def visit(node)
      node.accept(self)
    end

    def visit_attachment_figure(node)
      "<figure sgid=#{node.attrs["sgid"]}>
        #{node_previewable?(node) ? "<img src=#{node.url} />" : "<a href=#{node.url} target='_blank'>"}
        <figcaption class='attachment__caption'>#{visit_children(node).join}</figcaption>
        #{node_previewable?(node) ? "" : "</a>"}
      </figure>"
    end

    def visit_attachment_gallery(node)
      "<div class='attachment-gallery'>#{visit_children(node).join}</div>"
    end

    def visit_blockquote(node)
      "<blockquote>#{visit_children(node).join}</blockquote>"
    end

    def visit_bullet_list(node)
      "<ul>#{visit_children(node).join}</ul>"
    end

    def visit_callout(node)
      "<div class='callout' data-color='#{node.color}'>#{visit_children(node).join}</div>"
    end

    def visit_children(node)
      node.children.map { |child| visit(child) }
    end

    def visit_code_block(node)
      "<pre><code>#{visit_children(node).join("\n")}</code></pre>"
    end

    def visit_doc(node)
      "<div class='richer-text'>#{visit_children(node).join("\n")}</div>".html_safe
    end

    def visit_mention(node, marks)
      if marks.any?
        content_tag(marks[0].tag, visit_mention(node, marks[1..]), marks[0].attrs)
      else
        tag.span(
          tag.img(src: node.avatar_url, class: "richer-text--mention-img") +
          tag.span(node.name, class: "richer-text--mention-label"),
          class: "richer-text--mention")
      end
    end

    def visit_paragraph(node)
      "<p style='#{node.style}'>#{visit_children(node).join}</p>"
    end

    def visit_richer_text_embed(node)
      node.html
    end

    def visit_list_item(node)
      "<li>#{visit_children(node).join}</li>"
    end

    def visit_ordered_list(node)
      "<ol>#{visit_children(node).join}</ol>"
    end

    def visit_heading(node)
      "<h#{node.level}>#{visit_children(node).join}</h#{node.level}>"
    end

    def visit_hard_break(_node)
      "<br>"
    end

    def visit_horizontal_rule(_node)
      "<div><hr></div>"
    end

    def visit_image(node)
      "<img src='#{node.src}' width='#{node.width}' />"
    end

    def visit_text(node, marks)
      if marks.empty?
        node.text
      else
        content_tag(marks[0].tag, visit_text(node, marks[1..]), parse_mark_attrs(marks[0]))
      end
    end

    def visit_table(node)
      "<table>#{visit_children(node).join}</table>"
    end

    def visit_table_row(node)
      "<tr>#{visit_children(node).join}</tr>"
    end

    def visit_table_cell(node)
      "<td>#{visit_children(node).join}</td>"
    end

    def visit_table_header(node)
      "<th>#{visit_children(node).join}</th>"
    end

    private

    def previewable_regex
      /^image(\/(gif|png|jpe?g)|$)/
    end

    def node_previewable?(node)
      node.attrs["contentType"].match(previewable_regex)
    end

    def parse_mark_attrs(mark)
      attrs = mark.attrs
      tag = mark.tag

      if attrs.dig("color").present? && tag == "mark"
        attrs.merge(style: "background-color: #{attrs["color"]};")
      elsif attrs.dig("color").present? && tag == "span"
        attrs.merge(style: "color: #{attrs["color"]};")
      else
        attrs
      end
    end
  end
end
