#import "state-helpers.typ": *

#let get-handler-function-name(id) = {
  "customBTypCB" + str(id)
}

#let handler(function, event: "click") = {
  (
    function: function,
    event: event,
  )
}

#let register-handler(handler) = {
  custom-btyp-js-state.update(prev => {
    let id = repr(handler)

    if id not in prev.handlers {
      let index = prev.handlers.len() + 1
      prev.handlers.insert(id, (function-name: get-handler-function-name(index), ..handler))
    }

    prev
  })
}

#let get-handler(handler) = custom-btyp-js-state.get().handlers.at(repr(handler), default: none)

#let listener(handler) = {
  let retrHandler = get-handler(handler)

  (
    handler-function-name: retrHandler.function-name,
    handler-event: retrHandler.event,
  )
}

#let register-listener(listener, element-id) = {
  custom-btyp-js-state.update(prev => {
    let id = repr((element-id, listener))

    if id not in prev.listeners {
      let index = prev.listeners.len() + 1
      prev.listeners.insert(id, (id: element-id, ..listener))
    }

    prev.elem-ids.push(element-id)

    prev
  })
}
