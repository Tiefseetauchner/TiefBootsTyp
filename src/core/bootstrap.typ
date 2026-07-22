#import "../helpers/state-helpers.typ": custom-btyp-js-state

#let bootstrap-versions = (
  "5.3.8": (
    css: (
      href: "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css",
      integrity: "sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65",
    ),
    js: (
      src: "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js",
      integrity: "sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V",
    ),
  ),
)

#let popperjs-versions = (
  "2.11.6": (
    js: (
      src: "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js",
      integrity: "sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3",
    ),
  ),
)

#let get-document-info() = (
  title: document.title,
  locale: text.lang + if text.region != none { "-" + text.region },
)

#let bootstrap(
  body,
  additional-head-tags: none,
  bootstrap-version: bootstrap-versions.at("5.3.8"),
  enable-popperjs: true,
  popperjs-version: popperjs-versions.at("2.11.6"),
) = {
  let head = context {
    let document-info = get-document-info()

    html.meta(charset: "utf-8")
    html.meta(name: "viewport", content: "width=device-width, initial-scale=1")
    html.title(document-info.title)

    additional-head-tags

    html.link(
      rel: "stylesheet",
      ..bootstrap-version.css,
      crossorigin: "anonymous",
    )
  }

  let after-page = context {
    html.script(
      crossorigin: "anonymous",
      ..bootstrap-version.js,
    )
    html.script(
      crossorigin: "anonymous",
      ..popperjs-version.js,
    )

    let final-state = custom-btyp-js-state.final()
    let final-script = "// Generated code for TiefBootsTyp"
    final-script += "\n// Handler Function registration"
    for handler in final-state.handlers {
      final-script += "\n\nfunction " + handler.function-name + "(e) {" + handler.function + "}"
    }
    final-script += "\n\n// Registration  of Handler Functions in EventListeners"
    for listener in final-state.listeners {
      final-script += (
        "\n\ndocument.getElementById(\""
          + listener.id
          + "\").addEventListener(\""
          + listener.handler-event
          + "\", "
          + listener.handler-function-name
          + ");"
      )
    }
    html.script(
      final-script,
    )
  }

  context html.html(lang: get-document-info().locale, head + body + after-page)
}
