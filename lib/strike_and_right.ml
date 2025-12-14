
type t =
  { strike : Price.t 
  ; right : Option_right.t
  } [@@deriving equal] 

let is_call t =
  match t.right with
  | Call -> true
  | Put -> false

let is_put t =
  match t.right with
  | Call -> false
  | Put -> true 
    
let pp ppf c =
  Fmt.pf ppf "%a %a"
    Price.pp c.strike
    Option_right.pp c.right


