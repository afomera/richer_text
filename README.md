# RicherText

RicherText aims to provide a richer text editing experience than what comes out of the box with ActionText in Rails. **It is however a seperate thing from ActionText** and is **not** backwards compatible.

RicherText uses Lit and TipTap under the hood to create an editor. Additionally there's currently a hard requirement for ActiveStorage as well.

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

To use RicherText, once you've completed the installation process is a matter of doing the following:

**Add has_richer_text to a model**

Take a Post model where you'd like to add RicherText to write, and edit the body attribute:

```ruby
class Post < ApplicationRecord
  has_richer_text :body, store_as: :json
end
```

We recommend storing your Richer Text records as JSON for full compatibility with the TipTap schema under the hood.

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

Portions of the code related to the `has_richer_text` attribute, and parsing of the HTML content for the RicherText::RichText model are licensed under the Rails source code license, as it falls under the substantial portion of Software:

Copyright (c) 37signals LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
