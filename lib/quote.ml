(* open Core *)

type t =
  { bid : Price.t 
  ; ask : Price.t
  ; last : Price.t
  ; close : Price.t 
  } 

let pp ppf q = Fmt.pf ppf "Bid=%0.2f Ask=%0.2f" q.bid q.ask 

