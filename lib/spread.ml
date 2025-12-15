
module S = Strike_and_right
  
type t = (Action.t * Strike_and_right.t) list 

let inverse t =
  Core.List.map t ~f:(fun (act,opt) -> (Action.inverse act , opt))

module Call_spread = struct

  type t =
    { strike : Price.t
    ; width : Price.t
    } [@@ deriving hash,sexp,compare,equal] 

  let pp ppf t =
    Fmt.pf ppf "Call Spread %a/%a"
      Price.pp t.strike
      Price.pp (t.strike +. t.width) 
  
  let create ~strike ~width () =
    { strike = strike
    ; width
    }

  let legs t = 
    [ Action.Buy , { S.strike = t.strike ; right = Call }
    ; Sell , { S.strike = t.strike +. t.width ; right = Call }
    ]
  
end

module Put_spread = struct

  type t =
    { strike : Price.t
    ; width : Price.t
    } [@@ deriving hash,sexp,compare,equal] 

  let pp ppf t =
    Fmt.pf ppf "Put Spread %a/%a"
      Price.pp t.strike
      Price.pp (t.strike -. t.width) 
  
  let create ~strike ~width () =
    { strike = strike
    ; width
    }

  let legs t = 
    [ Action.Buy , { S.strike = t.strike ; right = Put }
    ; Sell , { S.strike = t.strike -. t.width ; right = Put }
    ]
  
end

module Iron_butterfly = struct

  type t =
    { center : Price.t
    ; width : Price.t
    } [@@ deriving hash,sexp,compare,equal] 

  let pp ppf t =
    Fmt.pf ppf "Iron Butterfly %a/%a"
      Price.pp t.center
      Price.pp (t.width) 
  
  let create ~center ~width () =
    { center ; width } 

  let legs t = 
    [ Action.Sell , { S.strike = t.center ; right = Call }
    ; Sell , { S.strike = t.center ; right = Put }
    ; Buy , { S.strike = t.center +. t.width ; right = Call }
    ; Buy , { S.strike = t.center -. t.width ; right = Put }
    ]
    
end


module Iron_condor = struct

  type t =
    { center : Price.t
    ; body_width : Price.t
    ; wing_width : Price.t 
    } [@@ deriving hash,sexp,compare,equal] 

  let pp ppf t =
    Fmt.pf ppf "Iron Condor %a/%a/%a"
      Price.pp t.center
      Price.pp (t.body_width) 
      Price.pp (t.wing_width) 
  
  let create ~center ~body_width ~wing_width () =
    { center ; body_width ; wing_width } 

  let legs t = 
    [ Action.Sell , { S.strike = t.center +. t.body_width ; right = Call }
    ; Sell , { S.strike = t.center +. t.body_width ; right = Put }
    ; Buy , { S.strike = t.center +. t.body_width +. t.wing_width ; right = Call }
    ; Buy , { S.strike = t.center -. t.body_width -. t.wing_width ; right = Put }
    ]
    
end


