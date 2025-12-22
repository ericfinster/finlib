

type t =
  | Call
  | Put
  [@@deriving sexp, hash, compare, equal, yojson]

let pp ppf = function
  | Call -> Fmt.pf ppf "Call"
  | Put -> Fmt.pf ppf "Put" 
  
