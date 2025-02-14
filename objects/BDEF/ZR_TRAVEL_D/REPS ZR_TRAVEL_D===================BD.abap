managed;
strict(2);
with draft;

define behavior for ZR_Travel_D alias Travel
implementation in class zbp_travel_d unique
persistent table zatravel_d
draft table zdtravel_d
lock master
total etag LastChangedAt
authorization master ( global, instance )
etag master LocalLastChangedAt
{
  create ( precheck );
  update ( precheck );
  delete;
  association _Booking { create ( features : instance, authorization: update ) ; with draft; }

  field ( numbering : managed, readonly ) TravelUUID;
  field ( readonly ) TravelID, OverallStatus, TotalPrice, LocalCreatedAt, LocalCreatedBy, LocalLastChangedAt, LocalLastChangedBy;
  field ( mandatory ) CustomerID, AgencyID, BeginDate, EndDate;
  field ( features : instance ) BookingFee;

  action ( features : instance, authorization: update ) acceptTravel result [1] $self;
  action ( features : instance, authorization: update ) rejectTravel result [1] $self;
  action ( features : instance, authorization: update ) deductDiscount parameter za_travel_discount result [1] $self;
  internal action reCalcTotalPrice;

  determination setTravelNumber on save { create; }
  determination setStatusToOpen on modify { create; }
  determination calculateTotalPrice on modify { create; field BookingFee, CurrencyCode; }

  validation validateCustomer on save { create; field CustomerID; }
  validation validateAgency on save { create; field AgencyID; }
  validation validateDates on save { create; field BeginDate, EndDate; }

  draft action Resume with additional implementation;
  draft action Edit;
  draft action Activate;
  draft action Discard;

  draft determine action Prepare
  {
    validation validateAgency;
    validation validateCustomer;
    validation validateDates;
    validation Booking ~ validateCustomer;
    validation Booking ~ validateConnection;
    validation Bookingsupplement ~ validateSupplement; }

  mapping for zatravel_d
  { AgencyID = agency_id;
    BeginDate = begin_date;
    BookingFee = booking_fee;
    CurrencyCode = currency_code;
    CustomerID = customer_id;
    Description = description;
    EndDate = end_date;
    LastChangedAt = last_changed_at;
    LocalCreatedAt = local_created_at;
    LocalCreatedBy = local_created_by;
    LocalLastChangedAt = local_last_changed_at;
    LocalLastChangedBy = local_last_changed_by;
    OverallStatus = overall_status;
    TotalPrice = total_price;
    TravelID = travel_id;
    TravelUUID = travel_uuid; }
}

define behavior for ZRBooking_D alias Booking
implementation in class zbp_booking_d unique
persistent table zabooking_d
draft table zdbooking_d
lock dependent by _Travel
authorization dependent by _Travel
etag master LocalLastChangedAt
{
  update;
  delete;
  association _BookingSupplement { create ( authorization: update ) ; with draft; }

  association _Travel  { with draft; }

  field ( numbering : managed, readonly ) BookingUUID;
  field ( readonly ) TravelUUID, BookingID, BookingDate, LocalLastChangedAt;
  field ( mandatory ) CustomerID, AirlineID, ConnectionID, FlightDate;


  determination setBookingNumber on save { create; }
  determination setBookingDate on save { create; }
  determination calculateTotalPrice on modify { create; field FlightPrice, CurrencyCode; }

  validation validateCustomer on save { create; field CustomerID; }
  validation validateConnection on save { create; field AirlineID, ConnectionID, FlightDate; }

  mapping for zabooking_d
  { AirlineID = carrier_id;
    BookingDate = booking_date;
    BookingID = booking_id;
    BookingStatus = booking_status;
    BookingUUID = booking_uuid;
    ConnectionID = connection_id;
    CurrencyCode = currency_code;
    CustomerID = customer_id;
    FlightDate = flight_date;
    FlightPrice = flight_price;
    LocalLastChangedAt = local_last_changed_at;
    TravelUUID = parent_uuid; }

}

define behavior for ZR_BookingSupplement_D alias BookingSupplement
implementation in class zbp_bookingsupplement_d unique
persistent table zabksuppl_d
draft table zdbksuppl_d
lock dependent by _Travel
authorization dependent by _Travel
etag master LocalLastChangedAt
{
  update;
  delete;

  association _Travel { with draft; }
  association _Booking { with draft; }

  field ( numbering : managed, readonly ) BookSupplUUID;
  field ( readonly ) TravelUUID, BookingUUID, BookingSupplementID, LocalLastChangedAt;
  field ( mandatory ) SupplementID;

  determination setBookSupplNumber on save { create; }
  determination calculateTotalPrice on modify { create; field CurrencyCode, BookSupplPrice; }

  validation validateSupplement on save { create; field SupplementID; }

  mapping for zabksuppl_d
  { BookSupplPrice = price;
    BookSupplUUID = booksuppl_uuid;
    BookingSupplementID = booking_supplement_id;
    BookingUUID = parent_uuid;
    CurrencyCode = currency_code;
    LocalLastChangedAt = local_last_changed_at;
    SupplementID = supplement_id;
    TravelUUID = root_uuid; }

}