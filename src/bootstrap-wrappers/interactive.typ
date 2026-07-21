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

#let button(variant: none, class-names: none, href: none, handlers: none, ..args, content) = {
  assert(
    variant == none or button-variants.contains(variant),
    message: "Only the following variants exist for button: " + button-variants.join(", "),
  )
  assert(handlers == none or href == none, message: "Cannot set both handlers and href")

  context {
    btn-ids-state.update(p => "")
  }

  let btn-classes = (..spread-or-single(class-names), "btn", concat-class-name("btn", default(variant, "subtle")))

  if handlers != none {
    let handler-is-reusable(handler) = type(handler) == dictionary and handler.at("cb-fn-name", default: none) != none

    if type(handlers) == array {
      for handler in handlers {
        context {
          if handler-is-reusable(handler) {
            let registered = register-existing-handler(handler.cb-fn-name, handler.event)
            btn-ids-state.update(prev => prev += " " + registered.id)
            registered.state
          } else {
            context {
              let registered = register-single-use-handler(handler)
              btn-ids-state.update(prev => prev += " " + registered.id)
              registered.state
            }
          }
        }
      }
    } else {
      let handler = handlers
      context {
        if handler-is-reusable(handler) {
          let registered = register-existing-handler(handler.cb-fn-name, handler.event)
          btn-ids-state.update(prev => prev += " " + registered.id)
          registered.state
        } else {
          let registered = register-single-use-handler(handler)
          btn-ids-state.update(prev => prev += " " + registered.id)
          registered.state
        }
      }
    }
  }

  context {
    [id: #type(btn-ids-state.get()),]
    let rendered-button = h.button(
      class-names: btn-classes,
      type: args.named().at("type", default: "button"),
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
