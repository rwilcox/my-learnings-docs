---
path: /learnings/gatsbyjs
title: 'Learnings: Gatsby.js'
---
# Table Of Contents

<!-- toc -->

- [And layouts](#and-layouts)
- [With Markdown / remark >](#with-markdown--remark-)

<!-- tocstop -->

# And layouts

Modify `src/layout/` to modify header, CSS stuff that's inserted into every rendered page.

When rendered statically this layout is included in the rendering (aka .html file) of every page on your site.

# With Markdown / remark <<Learning_Gatsby_Rendered_Markdown>>

This Gatsby site is made by rendering mostly markdown files into the site by way of [the remark transformation](https://www.npmjs.com/package/gatsby-transformer-remark).

This generates both a rendered React component for the file / path **AND** also generates the HTML statically.

Given the following structure:

    /src/pages/markdown_documents/learning_gatsby.md

And a path for that document at `/learning/gatsby`, the rendered path will be `curl http://localhost:9000/learnings/gatsby/index.html`

