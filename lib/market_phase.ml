
type t =
  | Overnight_session
  | Daily_reset
  | Cash_session
  | After_market 
  | Weekend
  | Nightly_pause
  [@@ deriving equal,yojson] 

let pp ppf = function
  | Overnight_session -> Fmt.pf ppf "Overnight_session"
  | Daily_reset -> Fmt.pf ppf "Daily_reset" 
  | Cash_session -> Fmt.pf ppf "Cash_session"
  | After_market -> Fmt.pf ppf "After_market"
  | Weekend -> Fmt.pf ppf "Weekend"
  | Nightly_pause -> Fmt.pf ppf "Nightly_pause" 
  
