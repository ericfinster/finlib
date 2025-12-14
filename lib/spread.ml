
type t = (Action.t * Strike_and_right.t) list 

let inverse t =
  Core.List.map t ~f:(fun (act,opt) -> (Action.inverse act , opt))

let iron_butterfly ~center ~width () : t =
  [ Sell , { strike = center ; right = Call }
  ; Sell , { strike = center ; right = Put }
  ; Buy , { strike = center +. width ; right = Call }
  ; Buy , { strike = center -. width ; right = Put }
  ]

let iron_condor ~center ~inner_width ~wing_width () : t =
  let lower_strike = center -. (inner_width /. 2.) in
  let upper_strike = center +. (inner_width /. 2.) in 
  [ Sell , { strike = lower_strike ; right = Put }
  ; Sell , { strike = upper_strike ; right = Call }
  ; Buy , { strike = upper_strike +. wing_width ; right = Call }
  ; Buy , { strike = lower_strike -. wing_width ; right = Put }
  ]

let call_spread ~strike ~width () : t =
  [ Buy , { strike = strike ; right = Call }
  ; Sell , { strike = strike +. width ; right = Call }
  ]

let put_spread ~strike ~width () : t =
  [ Buy , { strike = strike ; right = Put }
  ; Sell , { strike = strike +. width ; right = Put }
  ]

