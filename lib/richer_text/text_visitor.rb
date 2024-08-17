module RicherText
  class TextVisitor
    def visit(node)
      node.accept(self)
    end

    def visit_attachment_figure(node)
      visit_children(node)
    end

    def visit_attachment_gallery(node)
      visit_children(node)
    end

    def visit_blockquote(node)
      visit_children(node)
    end

    def visit_bullet_list(node)
      visit_children(node)
    end

    def visit_callout(node)
      visit_children(node)
    end

    def visit_children(node)
      node.children.map { |child| visit(child) }.join(" ")
    end

    def visit_code_block(node)
    end

    def visit_doc(node)
      visit_children(node)
    end

    def visit_iframely_embed(node)
    end

    def visit_mention(node, _marks)
      node.name
    end

    def visit_paragraph(node)
      visit_children(node)
    end

    def visit_richer_text_embed(node)
    end

    def visit_list_item(node)
      visit_children(node)
    end

    def visit_ordered_list(node)
      visit_children(node)
    end

    def visit_heading(node)
      visit_children(node)
    end

    def visit_hard_break(_node)
    end

    def visit_horizontal_rule(_node)
    end

    def visit_image(_node)
    end

    def visit_text(node, _marks)
      node.text
    end

    def visit_table(node)
      visit_children(node)
    end

    def visit_table_row(node)
      visit_children(node)
    end

    def visit_table_cell(node)
      visit_children(node)
    end

    def visit_table_header(node)
      visit_children(node)
    end
  end
end
