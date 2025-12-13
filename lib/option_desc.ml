
type t =
  { expiration : Core.Date.t
  ; strike : Price.t 
  ; right : Option_right.t
  } [@@deriving hash, equal, sexp, compare] 

let pp ppf c =
  Fmt.pf ppf "%a %a %a"
    Core.Date.pp c.expiration
    Price.pp c.strike
    Option_right.pp c.right


