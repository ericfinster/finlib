open Core

include Int

let pp ppf t = Fmt.pf ppf "%a" Fmt.int t 
