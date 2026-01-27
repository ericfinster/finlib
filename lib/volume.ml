open Base 

include Int

let to_yojson v = `Int v 
let of_yojson = function
  | `Int v -> Result.return v
  | _ -> Result.fail "of_yojson for volume"

let pp ppf t = Fmt.pf ppf "%a" Fmt.int t 
