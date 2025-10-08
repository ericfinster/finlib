
type t =
  | Buy
  | Sell

let pp ppf = function
  | Buy -> Fmt.pf ppf "Buy" 
  | Sell -> Fmt.pf ppf "Sell" 

let inverse = function
  | Buy -> Sell
  | Sell -> Buy 
  
  
