(* open Core *)

(* This is the thetadata desciption.  Probably want something more generic *)
type t =
  { ms_of_day : int
  ; bid_size : int
  ; bid_condition : int
  ; bid : float
  ; bid_exchange : int
  ; ask_size : int
  ; ask_condition : int
  ; ask : float
  ; ask_exchange : int
  ; date : int
  } 

let pp ppf q = Fmt.pf ppf "Bid=%0.2f Ask=%0.2f" q.bid q.ask 

