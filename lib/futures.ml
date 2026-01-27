(*
 *  futures.ml - some simple futures calculations
 *)

open Base
    
let fair_price ~cost_of_carry ~time_to_expiry spot =
  let open Float in
  spot * exp (cost_of_carry * time_to_expiry)

let implied_cost_of_carry ~time_to_expiry ~future_price spot =
  let open Float in
  log (future_price / spot) / time_to_expiry


