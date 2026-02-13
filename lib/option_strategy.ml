(*****************************************************************************
 *  Common Option Strategies 
 *****************************************************************************)

type t =
  | SimpleCall of Price.t
  | SimplePut of Price.t
  | CallSpread of Spread.Call_spread.t
  | PutSpread of Spread.Put_spread.t
  | IronButterfly of Spread.Iron_butterfly.t
  | IronCondor of Spread.Iron_condor.t
  [@@deriving equal,compare,yojson,hash] 

let of_strike_and_right s =
  let open Strike_and_right in
  match s.right with
  | Call -> SimpleCall s.strike
  | Put -> SimplePut s.strike

let pp ppf = function
  | SimpleCall strike -> Fmt.pf ppf "%0.2f Call" strike
  | SimplePut strike -> Fmt.pf ppf "%0.2f Put" strike
  | CallSpread spread -> Spread.Call_spread.pp ppf spread
  | PutSpread spread -> Spread.Put_spread.pp ppf spread
  | IronButterfly spread -> Spread.Iron_butterfly.pp ppf spread
  | IronCondor spread -> Spread.Iron_condor.pp ppf spread 

let pp_short ppf = function
  | SimpleCall strike -> Fmt.pf ppf "%0.2f C" strike
  | SimplePut strike -> Fmt.pf ppf "%0.2f P" strike
  | CallSpread spread -> Spread.Call_spread.pp_short ppf spread
  | PutSpread spread -> Spread.Put_spread.pp_short ppf spread 
  | IronButterfly spread -> Spread.Iron_butterfly.pp ppf spread
  | IronCondor spread -> Spread.Iron_condor.pp ppf spread 

let strike_of = function
  | SimpleCall strike -> strike
  | SimplePut strike -> strike
  | CallSpread spread -> spread.strike
  | PutSpread spread -> spread.strike
  | IronButterfly spread -> spread.center
  | IronCondor spread -> spread.center 

let compare_by_strike p q =
  Float.(compare (strike_of p) (strike_of q))

let is_call_spread = function
  | CallSpread _ -> true
  | _ -> false

let is_put_spread = function
  | PutSpread _ -> true
  | _ -> false

(*****************************************************************************
 *  Generating Strategies
 *****************************************************************************)

let strike_range strike range = 
  let center = Price.snap_to_five strike 
    |> Float.to_int
  in Base.List.range
    ~stride:5
    (center - range)
    (center + range) 

let calls_within strike range =
  strike_range strike range
  |> Base.List.map
    ~f:(fun s -> SimpleCall (Float.of_int s))

let puts_within strike range =
  strike_range strike range
  |> Base.List.map
    ~f:(fun s -> SimplePut (Float.of_int s))

let call_spreads_within ~width strike range =
  strike_range strike range
  |> Base.List.map
    ~f:(fun s ->
        let strk = Float.of_int s in 
        CallSpread
          (Spread.Call_spread.create ()
             ~strike:strk ~width))

let put_spreads_within ~width strike range =
  strike_range strike range
  |> Base.List.map
    ~f:(fun s ->
        let strk = Float.of_int s in 
        PutSpread
          (Spread.Put_spread.create ()
             ~strike:strk ~width))

let iron_flies_in_range ~width strike range =
  strike_range strike range
  |> Base.List.map
    ~f:(fun s ->
        let strk = Float.of_int s in 
        IronButterfly
          (Spread.Iron_butterfly.create ()
             ~center:strk ~width))

let iron_condors_in_range ~body_width ~wing_width strike range =
  strike_range strike range
  |> Base.List.map
    ~f:(fun s ->
        let strk = Float.of_int s in 
        IronCondor
          (Spread.Iron_condor.create ()
             ~center:strk ~body_width ~wing_width))
