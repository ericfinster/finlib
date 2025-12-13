open Core 
open Action 

type t = Option_desc.t list 

let bull_call_verticals chain ~width =
  List.filter_map chain
    ~f:(fun opt ->
        let companion =
          { opt with
            Option_desc.strike = opt.Option_desc.strike +. width } in 
        match (opt.right , List.find chain ~f:(Option_desc.equal companion)) with
        | (Call , Some opt_c) -> Some [ Buy , opt ; Sell , opt_c ]
        | _ -> None)

let bull_put_verticals chain ~width =
  List.filter_map chain
    ~f:(fun opt ->
        let companion =
          { opt with
            Option_desc.strike = opt.Option_desc.strike +. width } in 
        match (opt.right , List.find chain ~f:(Option_desc.equal companion)) with
        | (Put , Some opt_c) -> Some [ Buy , opt ; Sell , opt_c ]
        | _ -> None)

let bear_call_verticals chain ~width =
  List.map (bull_call_verticals chain ~width)
    ~f:Combo.inverse

let bear_put_verticals chain ~width =
  List.map (bull_put_verticals chain ~width)
    ~f:Combo.inverse 



