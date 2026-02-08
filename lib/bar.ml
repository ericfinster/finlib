
(* Stamp is in *seconds* from epoch*) 
type t =
  { stamp  : int
  ; opn    : Price.t
  ; close  : Price.t
  ; high   : Price.t
  ; low    : Price.t
  ; volume : Volume.t
  } [@@deriving yojson]

let to_list t =
  [ t.opn ; t.close ; t.low ; t.high ]
  
let combine b0 b1 =
  let high = Price.max b0.high b1.high in
  let low = Price.min b0.low b1.low in
  let close = b1.close in
  { b0 with
    high
  ; low
  ; close
  ; volume = Volume.(b0.volume + b1.volume)
  }
  
let pp ppf t =
  Format.fprintf ppf
    "Bar open=%.2f close=%.2f high=%.2f low=%.2f volume=%d"
    (t.opn :> float) (t.close :> float)
    (t.high :> float) (t.low :> float) 
    (t.volume :> int) 

