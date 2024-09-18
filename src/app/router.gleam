import app/web.{type Context}
import gleam/string_builder
import wisp.{type Request, type Response}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  use _req <- web.middleware(req, ctx)
  let body = string_builder.from_string("<h1>Hello, World!</h1>")
  wisp.html_response(body, 200)
}
