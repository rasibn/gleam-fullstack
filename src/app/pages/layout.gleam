import lustre/attribute as attr
import lustre/element.{type Element}
import lustre/element/html.{body, head, html, link, meta, title}

pub fn layout(elements: List(Element(t))) -> Element(t) {
  html([], [
    head([], [
      title([], "hello.rasib.me"),
      meta([
        attr.name("viewport"),
        attr.attribute("content", "width=device-width,initial-scale=1"),
      ]),
      link([attr.rel("stylesheet"), attr.href("/static/app.css")]),
    ]),
    body([], elements),
  ])
}
