#import "state-helpers.typ": *

#let create-handler(function, event: "click") = {
  (
    state: custom-btyp-js-state.update(prev => (
      id: prev.id + 1,
      script: prev.script + "\n\nfunction customBtypJsCb" + str(prev.id + 1) + "(e) {\n" + function + "\n}",
    )),
    cb-fn-name: "customBtypJsCb" + str(custom-btyp-js-state.get().id + 1),
    event: event,
  )
}

#let register-existing-handler(cb-fn-name, event) = {
  (
    state: custom-btyp-js-state.update(prev => (
      id: prev.id + 1,
      script: prev.script
        + "\n\ndocument.getElementById(\"custom-btyp-js-id-"
        + str(prev.id + 1)
        + "\").addEventListener(\""
        + event
        + "\", (e) => "
        + cb-fn-name
        + "(e));",
    )),
    id: "custom-btyp-js-id-" + str(custom-btyp-js-state.get().id + 1),
  )
}

#let register-single-use-handler(function) = {
  (
    state: custom-btyp-js-state.update(prev => (
      id: prev.id + 1,
      script: prev.script
        + "\n\ndocument.getElementById(\"custom-btyp-js-id-"
        + str(prev.id + 1)
        + "\").addEventListener(\"click\", (e) => customBtypJsCb"
        + str(prev.id + 1)
        + "(e));\n\nfunction customBtypJsCb"
        + str(prev.id + 1)
        + "(e) {\n"
        + function
        + "\n}",
    )),
    id: "custom-btyp-js-id-" + str(custom-btyp-js-state.get().id + 1),
  )
}
