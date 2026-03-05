(*****************************************************************************)
(* instrument.ml - common instruments                                        *)
(*****************************************************************************)

open Base 
    
type t =
  | Spx
  | Es of int
  | Strat of string * Option_strategy.t 
  [@@deriving hash,sexp,compare,equal,yojson] 

let pp ppf = function
  | Spx -> Fmt.pf ppf "Spx"
  | Es d -> Fmt.pf ppf "Es (%d)" d
  | Strat (date,os) -> Fmt.pf ppf "%s - %a" date Option_strategy.pp os 
  
