open Core

module T = Time_float 
  
type t =
  { stamp : T.t
  ; op : Price.t
  ; hi : Price.t
  ; lo : Price.t
  ; cl : Price.t
  ; volume : Volume.t
  ; count : int
  }

 (* [@@deriving sexp] *)

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
      (* (bar.stamp |> T.to_sec_string ~zone:(Calendar.market_zone ())) *)
      (T.to_string_utc bar.stamp) 
      (bar.op :> float) (bar.hi :> float) (bar.lo :> float) (bar.cl :> float)
  )


module Size = struct
  
  type t =
    | One_sec     | Five_sec   | Fifteen_sec | Thirty_sec
    | One_min     | Two_min    | Three_min   | Five_min
    | Fifteen_min | Thirty_min | One_hour    | One_day

  let to_span = function
    | One_sec -> T.Span.second
    | Five_sec -> T.Span.of_sec 5.
    | Fifteen_sec -> T.Span.of_sec 15.
    | Thirty_sec -> T.Span.of_sec 30.
    | One_min -> T.Span.minute
    | Two_min -> T.Span.of_min 2.
    | Three_min -> T.Span.of_min 3.
    | Five_min -> T.Span.of_min 5.
    | Fifteen_min -> T.Span.of_min 15.
    | Thirty_min -> T.Span.of_min 30.
    | One_hour -> T.Span.hour
    | One_day -> T.Span.day

  let to_ms s =
    to_span s
    |> T.Span.to_ms
    |> Float.to_int 

end
