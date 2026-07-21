#import "../helpers/html-helpers.typ" as h
#import "../helpers/bootstrap-helpers.typ": *
#import "../helpers/type-helpers.typ": *

#let container(class-names: none, breakpoint: none, content) = {
  let container-class-name = concat-class-name("container", breakpoint)

  h.div(class-names: (container-class-name, ..spread-or-single(class-names)))[
    #content
  ]
}

#let row(class-names: none, g: none, ..args, content) = {
  h.div(class-names: ("row", ..spread-or-single(class-names)))[
    #content
  ]
}

#let col(class-names: none, ..args, content) = {
  let col-class-names = get-breakpointed-size-class-name("col", ..args)

  h.div(class-names: (..col-class-names, ..spread-or-single(class-names)))[
    #content
  ]
}
