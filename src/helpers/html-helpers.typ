#let merge-class-names(args) = {
  if args == none {
    return ""
  } else if type(args) == str {
    return args
  } else if type(args) == array {
    return args.join(" ")
  }

  assert(false, message: "found type " + str(type(args)))
}

#let named-html-elem(name, class-names, ..attrs, content) = html.elem(name, attrs: (
  class: merge-class-names(class-names),
  ..attrs.named(),
))[
  #content
]

#let div(class-names: none, ..attrs, content) = named-html-elem(
  "div",
  class-names,
  ..attrs.named(),
)[#content]

#let a(class-names: none, ..attrs, content) = named-html-elem(
  "a",
  class-names,
  ..attrs.named(),
)[#content]

#let button(class-names: none, ..attrs, content) = named-html-elem(
  "button",
  class-names,
  ..attrs.named(),
)[#content]

#let span(class-names: none, ..attrs, content) = named-html-elem(
  "span",
  class-names,
  ..attrs.named(),
)[#content]

#let ul(class-names: none, ..attrs, content) = named-html-elem(
  "ul",
  class-names,
  ..attrs.named(),
)[#content]

#let li(class-names: none, ..attrs, content) = named-html-elem(
  "li",
  class-names,
  ..attrs.named(),
)[#content]
