open Core

type t =
  { root : Symbol.t
  ; expiration : Date.t
  ; strike : Price.t
  ; right : Option_right.t
  }           

let pp ppf c =
  Fmt.pf ppf "%s %a %a %a"
    c.root
    Date.pp c.expiration
    Price.pp c.strike
    Option_right.pp c.right
