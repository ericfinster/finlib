open Core
    
type t =
  { stamp : Time_float_unix.t
  ; op : Price.t
  ; hi : Price.t
  ; lo : Price.t
  ; cl : Price.t
  ; volume : Volume.t
  ; count : int
  } [@@deriving sexp]

let combine b0 b1 =
  let hi = Price.max b0.hi b1.hi in
  let lo = Price.min b0.lo b1.lo in
  let cl = b1.cl in
  { b0 with
    hi
  ; lo
  ; cl
  ; volume = Volume.(b0.volume + b1.volume)
  ; count = Int.(b0.count + b1.count)
  }
    
(* Can be better ... *) 
let pp ppf bar = Fmt.(
    pf ppf "Bar<%s> op=%.2f hi=%.2f lo=%.2f cl=%.2f"
      (* (bar.stamp |> Time_float_unix.to_sec_string ~zone:(Calendar.market_zone ())) *)
      (Time_float_unix.to_string bar.stamp) 
      (bar.op :> float) (bar.hi :> float) (bar.lo :> float) (bar.cl :> float)
  )

