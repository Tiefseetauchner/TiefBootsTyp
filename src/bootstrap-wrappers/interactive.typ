#import "../helpers/html-helpers.typ" as h
#import "../helpers/bootstrap-helpers.typ": *
#import "../helpers/handler-helpers.typ": *
#import "../helpers/type-helpers.typ": *
#import "../helpers/state-helpers.typ": *

#let button-variants = (
  "primary",
  "secondary",
  "success",
  "danger",
  "warning",
  "info",
  "light",
  "dark",
  "link",
)

#let is-registered-handler(listener) = {
  (
    type(listener) == dictionary
      and listener.at("function-name", default: none) != none
      and listener.at("function", default: none) != none
      and listener.at("event", default: none) != none
  )
}

#let register-interactive-listeners(listeners, element-id) = {
  if listeners == none {
    return
  }

  if type(listeners) == str {
    let handler = get-handler(listeners)
    register-handler(handler)
    let registrable-listener = get-listener(handler, element-id)
    register-listener(registrable-listener)
  }

  if is-registered-handler(listeners) {
    let registrable-listener = get-listener(listeners, element-id)
    register-listener(registrable-listener)
  }

  if type(listeners) == array {
    for listener in listeners {
      register-interactive-listeners(listener, element-id)
    }
  }
}

#let button(variant: none, class-names: none, href: none, listeners: none, ..args, content) = context {
  assert(
    variant == none or button-variants.contains(variant),
    message: "Only the following variants exist for button: " + button-variants.join(", "),
  )
  assert(listeners == none or href == none, message: "Cannot set both listeners and href")

  let btn-classes = (..spread-or-single(class-names), "btn", concat-class-name("btn", default(variant, "subtle")))

  let passed-id = args.named().at("id", default: none)

  if listeners != none {
    assert(passed-id == none, message: "Cannot pass id to element if listener is passed")

    custom-btyp-elem-counter.step()
    let elem-count = custom-btyp-elem-counter.get().last()
    let element-id = get-element-id(elem-count)
    passed-id = element-id

    register-interactive-listeners(listeners, element-id)
  }

  context {
    let rendered-button = h.button(
      class-names: btn-classes.join(" "),
      type: args.named().at("type", default: "button"),
      ..if passed-id != none { (id: passed-id) },
      ..args,
    )[
      #content
    ]

    if href != none {
      h.a(href: href)[
        #rendered-button
      ]
    } else {
      rendered-button
    }
  }
}
