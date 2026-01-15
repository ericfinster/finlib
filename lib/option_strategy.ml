
type t =
  | SimpleCall of Price.t
  | SimplePut of Price.t
  | CallSpread of Spread.Call_spread.t
  | PutSpread of Spread.Put_spread.t
  [@@deriving equal,compare,yojson] 

let of_strike_and_right s =
  let open Strike_and_right in
  match s.right with
  | Call -> SimpleCall s.strike
  | Put -> SimplePut s.strike

let pp ppf = function
  | SimpleCall strike -> Fmt.pf ppf "%0.2f Call" strike
  | SimplePut strike -> Fmt.pf ppf "%0.2f Put" strike
  | CallSpread spread -> Fmt.pf ppf "%a" Spread.Call_spread.pp spread
  | PutSpread spread -> Fmt.pf ppf "%a" Spread.Put_spread.pp spread 

let strike_of = function
  | SimpleCall strike -> strike
  | SimplePut strike -> strike
  | CallSpread spread -> spread.strike
  | PutSpread spread -> spread.strike 

let compare_by_strike p q =
  Float.(compare (strike_of p) (strike_of q))

