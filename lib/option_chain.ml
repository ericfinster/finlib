open Core 

type 'a t =
  { root : Symbol.t
  ; expiration : Date.t
  ; strikes : Price.t list 
  ; right : Option_right.t
  ; contract : 'a 
  }           

  

