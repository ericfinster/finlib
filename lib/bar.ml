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


module Size = struct
  
  type t =
    | One_sec     | Five_sec   | Fifteen_sec | Thirty_sec
    | One_min     | Two_min    | Three_min   | Five_min
    | Fifteen_min | Thirty_min | One_hour    | One_day

  let to_span = function
    | One_sec -> Time_float_unix.Span.second
    | Five_sec -> Time_float_unix.Span.of_sec 5.
    | Fifteen_sec -> Time_float_unix.Span.of_sec 15.
    | Thirty_sec -> Time_float_unix.Span.of_sec 30.
    | One_min -> Time_float_unix.Span.minute
    | Two_min -> Time_float_unix.Span.of_min 2.
    | Three_min -> Time_float_unix.Span.of_min 3.
    | Five_min -> Time_float_unix.Span.of_min 5.
    | Fifteen_min -> Time_float_unix.Span.of_min 15.
    | Thirty_min -> Time_float_unix.Span.of_min 30.
    | One_hour -> Time_float_unix.Span.hour
    | One_day -> Time_float_unix.Span.day

  let to_ms s =
    to_span s
    |> Time_float_unix.Span.to_ms
    |> Float.to_int 

  let eric = ()
             
end
