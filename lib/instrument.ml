(*****************************************************************************)
(* instrument.ml - common instruments                                        *)
(*****************************************************************************)

open Base 
    
type instrument =
  | Spx
  | Es
  | Strat of string * Option_strategy.t 
  [@@deriving hash] 

