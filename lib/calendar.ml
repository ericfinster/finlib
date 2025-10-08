(*****************************************************************************)
(*                                                                           *)
(*                           Calendar functions                              *)
(*                                                                           *)
(*****************************************************************************)

open Core 
    
module Tm = Time_float 

(* Market Holidays *) 

type holiday_type =
  | Closed
  | HalfDay 

(* There seems to be valid data for Columbus day, but not veteran's day. *) 

let holidays2023 = 
  [ ("New Year's Day"               , Date.of_string "20230102" , Closed)
  ; ("Martin Luther King Jr. Day"   , Date.of_string "20230116" , Closed)
  ; ("Presidents' Day"              , Date.of_string "20230220" , Closed)
  ; ("Good Friday"                  , Date.of_string "20230407" , Closed)
  ; ("Memorial Day"                 , Date.of_string "20230529" , Closed)
  ; ("Juneteenth Holiday"           , Date.of_string "20230619" , Closed)
  ; ("Independence Day Early Close" , Date.of_string "20230703" , HalfDay)
  ; ("Independence Day"             , Date.of_string "20230704" , Closed)
  ; ("Labor Day"                    , Date.of_string "20230904" , Closed)
  (* ; ("Columbus Day"              , "20231009" , Closed) *)
  ; ("Veteran's Day"                , Date.of_string "20231111" , Closed)
  ; ("Thanksgiving Day"             , Date.of_string "20231123" , Closed)
  ; ("Thanksgiving Early Close"     , Date.of_string "20231124" , HalfDay)
  ; ("Christmas Early Close"        , Date.of_string "20231224" , HalfDay)
  ; ("Christmas Day"                , Date.of_string "20231225" , Closed)
  ]

let holidays2024 =
  [ ("New Year's Day"               , Date.of_string "20240101" , Closed)
  ; ("Martin Luther King Jr. Day"   , Date.of_string "20240115" , Closed)
  ; ("Presidents' Day"              , Date.of_string "20240219" , Closed)
  ; ("Good Friday"                  , Date.of_string "20240329" , Closed)
  ; ("Memorial Day"                 , Date.of_string "20240527" , Closed)
  ; ("Juneteenth Holiday"           , Date.of_string "20240619" , Closed)
  ; ("Independence Day Early Close" , Date.of_string "20240703" , HalfDay)
  ; ("Independence Day"             , Date.of_string "20240704" , Closed)
  ; ("Labor Day"                    , Date.of_string "20240902" , Closed)
  (* ; ("Columbus Day"              , "20241014" , Closed) *)
  ; ("Veteran's Day"                , Date.of_string "20241111" , Closed)
  ; ("Thanksgiving Day"             , Date.of_string "20241128" , Closed)
  ; ("Thanksgiving Early Close"     , Date.of_string "20241129" , HalfDay)
  ; ("Christmas Early Close"        , Date.of_string "20241224" , HalfDay)
  ; ("Christmas Day"                , Date.of_string "20241225" , Closed)
  ]

let is_holiday d =
  List.exists holidays2023 ~f:(fun (_,d',_) -> Date.equal d d') ||
  List.exists holidays2024 ~f:(fun (_,d',_) -> Date.equal d d') 

let market_open () = Tm.Ofday.of_string "09:30"
let market_close () = Tm.Ofday.of_string "16:00"
let market_zone () = Tm.Zone.of_utc_offset ~hours:(-5)

let market_close_on_date date =
    Tm.of_date_ofday
      (Core.Date.of_string date)
      (market_close ()) 
      ~zone:(market_zone ())

let market_date_and_time date time =
  Tm.of_date_ofday
    ~zone:(market_zone ()) 
    (Core.Date.of_string date)
    (Tm.Ofday.of_string time)

let my_zone () = Tm.Zone.of_utc_offset ~hours:(1) 

let todays_date () = Core.Date.today ~zone:(my_zone ())  
let today's_open () = Tm.of_date_ofday ~zone:(market_zone ())
    (todays_date ()) (market_open ())
let today's_close () = Tm.of_date_ofday ~zone:(market_zone ())
    (todays_date ()) (market_close ()) 

let is_market_open () =
  let is_open_today =
    Date.is_business_day (todays_date ()) 
      ~is_holiday:is_holiday in
  let time_now = Tm.now () in
  Tm.is_later time_now ~than:(today's_open ()) &&
  Tm.is_earlier time_now ~than:(today's_close ()) &&
  is_open_today

let rec trading_history n date =
  if (n <= 0) then [] else
    let yesterday = Date.previous_weekday date in 
    if Date.is_business_day date ~is_holiday:is_holiday then
      date::(trading_history (n-1) yesterday)
    else trading_history n yesterday


