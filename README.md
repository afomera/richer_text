# RicherText

RicherText aims to provide a richer text editing experience than what comes out of the box with ActionText in Rails. **It is however a seperate thing from ActionText** and is **not** backwards compatible.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "richer_text"
```

And then execute:

```bash
$ bundle
```

Once you've installed the gem the next step is to run the Generator and install all required libraries.

```bash
$ rails richer_text:install
```

> [!IMPORTANT]  
> If you wish to use highlight.js outside of RicherText you'll need to add some code to your javascript entry point.

```js
const hljs = require("highlight.js");

document.addEventListener("turbo:load", (event) => {
  document.querySelectorAll("pre").forEach((block) => {
    hljs.highlightElement(block);
  });
});
```

## Usage

> [!WARNING]  
> You probably shouldn't use this gem / npm package (yet!) for anything serious. It's still undergoing development. But please do try it on a non-production app!

To use RicherText, once you've completed the installation process is a matter of doing the following:

**Add has_richer_text to a model**

Take a Post model where you'd like to add RicherText to write, and edit the body attribute:

```ruby
class Post < ApplicationRecord
  has_richer_text :body
end
```

**Add the form helper to the form**

Inside of your form partial:

```erb
  <%= form.label :body %>
  <%= form.richer_text_area :body %>
```

Optionally you can pass arguments to the RicherText editor...

```erb
  <%= form.label :body %>
  <%= form.richer_text_area :body, callouts: true, placeholder: "Write something..." %>
```

**Render the richer text content**

```erb
  <%= @post.body %>
```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
