projection;
strict(2);

define behavior for ZC_Travel_Processor_M alias TravelProcessor
use etag

{
  field ( readonly ) TotalPrice;

  use create;
  use update;
  use delete;

  use action copyTravel;

  use association _BOOKING { create; }

}

define behavior for ZC_Booking_Processor_M alias BookingProcessor
use etag
{
  use update;
//  use delete; // workaround for missing determination on delete

  use association _BOOKSUPPLEMENT { create; }
  use association _Travel { }
}


define behavior for ZC_BookSuppl_Processor_M alias BookSupplProcessor
use etag
{
  use update;
//  use delete; // workaround for missing determination on delete
  use association _Travel  { }
  use association _Booking { }
}