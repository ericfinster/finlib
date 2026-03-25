

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

type monitor =
  { mutable bid : Price.t  
  ; mutable ask : Price.t 
  ; mutable last : Price.t 
  ; mutable close : Price.t 
  } [@@deriving yojson]

let create () =
  { bid = Float.nan
  ; ask = Float.nan
  ; last = Float.nan
  ; close = Float.nan
  } 

let update_monitor ~tick t =
  match tick with
  | Bid p -> t.bid <- p
  | Ask p -> t.ask <- p
  | Last p -> t.last <- p
  | Close p -> t.close <- p 

let mid t = t.bid +. ((t.ask -. t.bid) /. 2.)

let last_or_close t =
  if Float.is_nan t.last
  then t.close
  else t.last

