import gleam/json
import gleam/list
import gleam/option.{type Option, Some}
import gleam/string
import wisp

pub type ItemStatus {
  Completed
  Uncompleted
}

pub type Item {
  Item(id: String, title: String, status: ItemStatus)
}

pub fn create(id: Option(String), title: String, completed: Bool) -> Item {
  let id = option.unwrap(id, wisp.random_string(64))
  case completed {
    True -> Item(id, title, status: Completed)
    False -> Item(id, title, status: Uncompleted)
  }
}

pub fn status_to_bool(status: ItemStatus) -> Bool {
  case status {
    Completed -> True
    Uncompleted -> False
  }
}

pub fn toggle(item: Item) -> Item {
  let new_status = case item.status {
    Completed -> Uncompleted
    Uncompleted -> Completed
  }
  Item(..item, status: new_status)
}

pub type ItemJson {
  ItemJson(id: String, title: String, completed: Bool)
}

pub fn to_json(item: Item) -> String {
  json.object([
    #("id", json.string(item.id)),
    #("title", json.string(item.title)),
    #("completed", json.bool(status_to_bool(item.status))),
  ])
  |> json.to_string
}

pub fn list_from_json(items: List(ItemJson)) -> List(Item) {
  items
  |> list.map(fn(item) {
    let ItemJson(id, title, completed) = item
    create(Some(id), title, completed)
  })
}

pub fn list_to_json(items: List(Item)) -> String {
  "["
  <> items
  |> list.map(to_json)
  |> string.join(",")
  <> "]"
}
