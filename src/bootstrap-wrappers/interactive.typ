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
      and listener.at("function", default: none) != none
      and listener.at("event", default: none) != none
  )
}

#let get-handlers-from-callbacks(cb) = {
  if cb == none {
    return
  }

  if type(cb) == str {
    return (handler(cb),)
  } else if type(cb) == array {
    let handlers = (
      ..for elem in cb {
        (..get-handlers-from-callbacks(elem),)
      },
    )
    return handlers
  } else {
    return (cb,)
  }
}

#let listeners-from-callbacks(cb) = {
  if cb == none {
    return
  }

  if is-registered-handler(cb) {
    return (listener(cb),)
  } else if type(cb) == array {
    return (
      ..for listener in cb {
        (..listeners-from-callbacks(listener),)
      },
    )
  }

  assert(false, message: "cb was neither a registered handler nor an array of registered handlers.")
}

#let get-element-id() = {
  "customBTypElemId" + str(custom-btyp-js-state.get().elem-ids.len())
}

#let get-last-element-id() = {
  custom-btyp-js-state.get().elem-ids.last()
}

#let button(variant: none, class-names: none, href: none, callbacks: none, ..args, content) = {
  assert(
    variant == none or button-variants.contains(variant),
    message: "Only the following variants exist for button: " + button-variants.join(", "),
  )
  assert(callbacks == none or href == none, message: "Cannot set both callbacks and href")

  let btn-classes = (..spread-or-single(class-names), "btn", concat-class-name("btn", default(variant, "subtle")))

  let passed-id = args.named().at("id", default: none)

  context {
    let elem-id = none
    if callbacks != none {
      assert(passed-id == none, message: "Cannot pass id to element if listener is passed")
      elem-id = get-element-id()

      let handlers = get-handlers-from-callbacks(callbacks)
      for handler in handlers {
        register-handler(handler)
      }

      context {
        let listeners = listeners-from-callbacks(handlers)
        for listener in listeners {
          register-listener(listener, elem-id)
        }
      }
    }

    let rendered-button = h.button(
      class-names: btn-classes.join(" "),
      type: args.named().at("type", default: "button"),
      ..if elem-id != none { (id: elem-id) },
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
