open Base 
    
type t =
  { strike : Price.t 
  ; right : Option_right.t
  } [@@deriving hash,compare,sexp,equal] 

let is_call t =
  match t.right with
  | Call -> true
  | Put -> false

let is_put t =
  match t.right with
  | Call -> false
  | Put -> true 

let is_within ~range ~from_strike t =
  match range with
  | `Value v -> Float.(abs (t.strike -. from_strike) < v)
  | `Percent p -> Float.(abs (1. -. (t.strike /. from_strike)) < p)
    
let pp ppf c =
  Fmt.pf ppf "%a %.0f"
    Option_right.pp c.right
    c.strike


