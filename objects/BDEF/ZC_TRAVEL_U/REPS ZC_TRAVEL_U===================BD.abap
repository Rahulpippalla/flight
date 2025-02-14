projection;
strict;

define behavior for ZC_Travel_U alias travel

use etag

{
  use create;
  use update;
  use delete;
  use action set_status_booked;
  use association _BOOKING { create; }
}

define behavior for ZC_Booking_U alias booking
use etag
{
  use update;
  use delete;
  use association _BOOKSUPPLEMENT { create; }
  use association _Travel;
}

define behavior for ZC_BookingSupplement_U alias bookingsupplement
use etag
{
  use update;
  use delete;

  use association _Travel;
  use association _Booking;
}