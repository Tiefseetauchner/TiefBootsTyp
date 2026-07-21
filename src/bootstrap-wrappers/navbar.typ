#import "../helpers/html-helpers.typ" as h
#import "../helpers/bootstrap-helpers.typ": *
#import "../helpers/type-helpers.typ": *
#import "layout.typ": container
#import "interactive.typ": button

#let navbar(class-names: none, expand: none, container-breakpoint: none, content) = {
  let navbar-expand-breakpoint = concat-class-name("navbar-expand", default(expand, "lg"))

  h.div(class-names: ("navbar", ..spread-or-single(class-names)))[
    #container(breakpoint: default(container-breakpoint, "fluid"))[
      #content
    ]
  ]
}

#let navbar-brand(class-names: none, href: "/", content) = {
  h.a(href: href, class-names: ("navbar-brand", ..spread-or-single(class-names)))[#content]
}

#let navbar-toggler(class-names: none) = {
  button(
    class-names: (..spread-or-single(class-names), "navbar-toggler"),
    type: "button",
    data-bs-toggle: "collapse",
    data-bs-target: "#navbarSupportedContent",
    aria-controls: "navbarSupportedContent",
    aria-expanded: "false",
    aria-label: "Toggle navigation",
  )[
    #h.span(class-names: "navbar-toggler-icon")[]
  ]
}

#let nav-list(class-names: none, content) = {
  h.ul(class-names: (
    "navbar-nav",
    "me-auto",
    "mb-2",
    "mb-lg-0",
    ..spread-or-single(class-names),
  ))[#content]
}


#let navbar-collapse(class-names: none, content) = {
  h.div(class-names: ("collapse", "navbar-collapse", ..spread-or-single(class-names)), id: "navbarSupportedContent")[
    #content
  ]
}

#let nav-link(active: false, href, content) = {
  h.li(class-names: "nav-item")[
    #h.a(class-names: ("nav-link", if active { "active" }), href: href, ..if active {
      (aria-current: "page")
    })[#content]
  ]
}

#let responsive-navbar(
  class-names: none,
  expand: none,
  container-breakpoint: none,
  before-content,
  collapsible-content,
) = {
  let navbar-expand-breakpoint = concat-class-name("navbar-expand", default(expand, "lg"))

  navbar(class-names: (..spread-or-single(class-names), navbar-expand-breakpoint))[
    #before-content
    #navbar-toggler()
    #navbar-collapse()[
      #nav-list[
        #collapsible-content
      ]
    ]
  ]
}
