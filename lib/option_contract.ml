open Core

type t =
  { root : Symbol.t
  ; expiration : Date.t
  ; strike : Price.t
  ; right : Option_right.t
  }           

