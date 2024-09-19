import app/components/todos.{svg_icon_checked, svg_icon_delete}
import app/components/utils.{override_with}
import app/models/item.{type Item, Completed, Uncompleted}
import gleam/http
import gleam/list
import lustre/attribute as attr
import lustre/attribute.{class}
import lustre/element.{type Element, text}
import lustre/element/html.{button, div, form, h1, input, span}

pub fn root(items: List(Item)) -> Element(t) {
  div([class("app")], [
    h1([class("app-title")], [text("Todo App")]),
    div([class("todos")], [
      add_todo_input(),
      div([class("todos__inner")], [
        div([class("todos__list")], items |> list.map(item)),
      ]),
      div([class("todos__empty")], []),
    ]),
  ])
}

fn add_todo_input() -> Element(t) {
  form(
    [class("add-todo-input"), attr.method("POST"), attr.action("/items/create")],
    [
      input([
        attr.name("todo_title"),
        attr.class("add-todo-input__input"),
        attr.placeholder("What needs to be done?"),
        attr.autofocus(True),
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

  div([class("todo" <> completed_class)], [
    div([class("todo__inner")], [
      form(
        [
          attr.method("POST"),
          attr.action(
            "/items/" <> item.id <> "/completion" <> override_with(http.Patch),
          ),
        ],
        [button([class("todo__button")], [svg_icon_checked()])],
      ),
      span([class("todo__title")], [text(item.title)]),
    ]),
    form(
      [
        attr.method("POST"),
        attr.action("/items/" <> item.id <> override_with(http.Delete)),
      ],
      [button([class("todo__delete")], [svg_icon_delete()])],
    ),
  ])
}
