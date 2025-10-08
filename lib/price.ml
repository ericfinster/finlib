open Base 

include Float

let pp ppf p = Fmt.(pf ppf "%.2f" p)

let snap_to_five p =
  let pint = Float.iround_nearest_exn p in
  let piround =
    match Int.(%) pint 5 with
    | 0 -> pint
    | 1 -> Int.(-) pint 1
    | 2 -> Int.(-) pint 2
    | 3 -> Int.(+) pint 2
    | 4 -> Int.(+) pint 1
    | _ -> assert false
  in 
  Float.of_int piround 

(* let snap_to_two_point_five spot = *)
(*   let i = Float.iround_nearest_exn (spot *. 10.) in *)
(*   let m = i % 25 in *)
(*   let r = if (m < 13) then i - m else i + (25 - m) in *)
(*   Float.of_int r /. 10.  *)

(* let strikes_from_spot spot num = *)
(*   let snapped_spot = snap_to_five spot in *)
(*   let first_strike = snapped_spot -. Float.of_int (num * 5)in *)
(*   Core.List.init (num * 2) *)
(*     ~f:(fun i -> first_strike +. Float.of_int (5 * i)) *)
