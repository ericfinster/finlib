
type t =
  | Buy
  | Sell
  [@@deriving yojson]

let pp ppf = function
  | Buy -> Fmt.pf ppf "Buy" 
  | Sell -> Fmt.pf ppf "Sell" 

let inverse = function
  | Buy -> Sell
  | Sell -> Buy 
  
let is_buy = function
  | Buy -> true
  | Sell -> false

let is_sell a = not @@ is_buy a 
  
