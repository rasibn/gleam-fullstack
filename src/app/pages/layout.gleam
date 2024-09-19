import lustre/attribute as a
import lustre/element.{type Element}
import lustre/element/html as h

pub fn layout(elements: List(Element(t))) -> Element(t) {
  h.html([], [
    h.head([], [
      h.title([], "hello.rasib.me"),
      h.meta([
        a.name("viewport"),
        a.attribute("content", "width=device-width,initial-scale=1"),
      ]),
      h.link([a.rel("stylesheet"), a.href("/static/app.css")]),
    ]),
    h.body([], elements),
  ])
}
