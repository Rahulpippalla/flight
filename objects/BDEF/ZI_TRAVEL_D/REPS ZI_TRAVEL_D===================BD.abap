interface;
use draft;
define behavior for ZI_Travel_D alias Travel
use etag
{
  use create;
  use update;
  use delete;

  use action acceptTravel;
  use action rejectTravel;
  use action deductDiscount;

  use action Edit;
  use action Activate;
  use action Discard;
  use action Prepare;
  use action Resume;

  use association _Booking { create; with draft; }
}

define behavior for ZI_Booking_D alias Booking
use etag
{
  use update;
  use delete;

  use association _BookingSupplement { create; with draft; }
  use association _Travel { with draft; }
}

define behavior for ZI_BookingSupplement_D alias BookingSupplement
use etag
{
  use update;
  use delete;

  use association _Travel { with draft; }
  use association _Booking { with draft; }
}