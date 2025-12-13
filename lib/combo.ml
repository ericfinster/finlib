
type t = (Action.t * Option_desc.t) list 

let inverse t =
  Core.List.map t ~f:(fun (act,opt) -> (Action.inverse act , opt))

let iron_butterfly ~expiration ~center ~width () : t =
  [ Sell , { expiration ; strike = center ; right = Call }
    ; Sell , { expiration ; strike = center ; right = Put }
    ; Buy , { expiration ; strike = center +. width ; right = Call }
    ; Buy , { expiration ; strike = center -. width ; right = Put }
    ]

let bear_vertical_call ~expiration ~lower_strike ~width () : t =
  [ Sell , { expiration ; strike = lower_strike ; right = Call }
    ; Buy , { expiration ; strike = lower_strike +. width ; right = Call }
    ]

let bull_vertical_call ~expiration ~lower_strike ~width () : t =
  inverse @@ bear_vertical_call ~expiration ~lower_strike ~width () 

let bull_vertical_put ~expiration ~lower_strike ~width () : t =
  [ Sell , { expiration ; strike = lower_strike ; right = Put }
    ; Buy , { expiration ; strike = lower_strike +. width ; right = Put }
    ]

let bear_vertical_put ~expiration ~lower_strike ~width () : t =
  inverse @@ bull_vertical_put ~expiration ~lower_strike ~width () 

