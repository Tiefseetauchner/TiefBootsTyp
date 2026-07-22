#import "state-helpers.typ": *

#let get-handler-function-name(id) = {
  "customBTypCB" + str(id)
}

#let get-handler(function, event: "click") = {
  (
    function-name: get-handler-function-name(custom-btyp-js-handler-fn-counter.get().last()),
    function: function,
    event: event,
  )
}

#let register-handler(handler) = {
  context custom-btyp-js-handler-fn-counter.step()
  custom-btyp-js-state.update(prev => {
    prev.handlers.push(handler)

    prev
  })
}

#let get-element-id(id) = {
  "customBTypElemId" + str(id)
}

#let get-listener(handler, element-id) = {
  (
    id: element-id,
    handler-function-name: handler.function-name,
    handler-event: handler.event,
  )
}

#let register-listener(listener) = {
  custom-btyp-js-state.update(prev => {
    prev.listeners.push(listener)

    prev
  })
}
