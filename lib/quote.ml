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

(* let of_json json = *)
(*   let open Yojson.Safe.Util in *)
(*   let quote = to_list json in *)
(*   match quote with *)
(*   | [ms;bs;bc;b;be;asz;ac;a;ae;d] -> *)
(*     { ms_of_day     = to_int ms *)
(*     ; bid_size      = to_int bs  *)
(*     ; bid_condition = to_int bc *)
(*     ; bid           = to_float b *)
(*     ; bid_exchange  = to_int be *)
(*     ; ask_size      = to_int asz *)
(*     ; ask_condition = to_int ac *)
(*     ; ask           = to_float a *)
(*     ; ask_exchange  = to_int ae *)
(*     ; date          = to_int d *)
(*     }  *)
(*   | _ -> failwith "parse error" *)

let pp ppf q =
  Fmt.pf ppf "ms=%d bid=%0.2f ask=%0.2f" q.ms_of_day q.bid q.ask 

