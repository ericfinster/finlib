open Core 

type 'a t =
  { expiration : Date.t
  ; strike : Price.t
  ; right : Option_right.t
  }           

let pp ppf c =
  Fmt.pf ppf "%a %a %a"
    Date.pp c.expiration
    Price.pp c.strike
    Option_right.pp c.right




