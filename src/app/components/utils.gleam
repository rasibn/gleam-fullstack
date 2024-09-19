import gleam/http
import gleam/string

pub fn override_with(method: http.Method) -> String {
  let str = "?_method="
  case method {
    http.Get -> str <> "GET"
    http.Post -> str <> "POST"
    http.Head -> str <> "HEAD"
    http.Put -> str <> "PUT"
    http.Delete -> str <> "DELETE"
    http.Trace -> str <> "TRACE"
    http.Connect -> str <> "CONNECT"
    http.Options -> str <> "OPTIONS"
    http.Patch -> str <> "PATCH"
    http.Other(method) -> str <> method |> string.uppercase
  }
}
