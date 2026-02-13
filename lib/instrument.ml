(*****************************************************************************)
(* instrument.ml - common instruments                                        *)
(*****************************************************************************)

open Base 
    
type t =
  | Spx
  | Es
  | Strat of string * Option_strategy.t 
  [@@deriving hash,yojson] 

