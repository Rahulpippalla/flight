  METHOD calculate_flight_price.
  " Rahul - change 1 - rahul pippalla
    rv_price = zcl_flight_legacy=>calculate_flight_price(
                 iv_seats_occupied_percent = iv_seats_occupied_percent
                 iv_flight_distance        = iv_flight_distance
               ).
  " Pippalla rahul
  ENDMETHOD.