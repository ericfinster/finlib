

type t =
  | Call
  | Put
  [@@deriving sexp, hash, compare, equal]

let pp ppf = function
  | Call -> Fmt.pf ppf "Call"
  | Put -> Fmt.pf ppf "Put" 
  
