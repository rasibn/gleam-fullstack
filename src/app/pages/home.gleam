import app/components/todos.{svg_icon_checked, svg_icon_delete}
import app/components/utils.{override_with}
import app/models/item.{type Item, Completed, Uncompleted}
import gleam/http
import gleam/list
import lustre/attribute as a
import lustre/element.{type Element, text}
import lustre/element/html as h

pub fn root(items: List(Item)) -> Element(t) {
  h.div([a.class("app")], [
    h.h1([a.class("app-title")], [text("Todo App")]),
    h.div([a.class("todos")], [
      add_todo_input(),
      h.div([a.class("todos__inner")], [
        h.div([a.class("todos__list")], items |> list.map(item)),
      ]),
      h.div([a.class("todos__empty")], []),
    ]),
  ])
}

fn add_todo_input() -> Element(t) {
  h.form(
    [a.class("add-todo-input"), a.method("POST"), a.action("/items/create")],
    [
      h.input([
        a.name("todo_title"),
        a.class("add-todo-input__input"),
        a.placeholder("What needs to be done?"),
        a.autofocus(True),
      ]),
    ],
  )
}

pub fn item(item: Item) -> Element(t) {
  let completed_class: String = {
    case item.status {
      Completed -> "todo--completed"
      Uncompleted -> ""
    }
  }

  h.div([a.class("todo" <> completed_class)], [
    h.div([a.class("todo__inner")], [
      h.form(
        [
          a.method("POST"),
          a.action(
            "/items/" <> item.id <> "/completion" <> override_with(http.Patch),
          ),
        ],
        [h.button([a.class("todo__button")], [svg_icon_checked()])],
      ),
      h.span([a.class("todo__title")], [text(item.title)]),
    ]),
    h.form(
      [
        a.method("POST"),
        a.action("/items/" <> item.id <> override_with(http.Delete)),
      ],
      [h.button([a.class("todo__delete")], [svg_icon_delete()])],
    ),
  ])
}
