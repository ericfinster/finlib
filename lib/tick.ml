

type t =
  | Bid of Price.t
  | Ask of Price.t
  | Last of Price.t
  | Close of Price.t 
  [@@deriving yojson]

let pp ppf = function
  | Bid p -> Fmt.pf ppf "Bid %0.2f" p  
  | Ask p -> Fmt.pf ppf "Ask %0.2f" p 
  | Last p -> Fmt.pf ppf "Last %0.2f" p
  | Close p -> Fmt.pf ppf "Close %0.2f" p 
