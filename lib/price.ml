open Core

include Float

let pp ppf p = Fmt.(pf ppf "%.2f" p)
