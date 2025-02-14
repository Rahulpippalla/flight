projection;
strict(2);

define behavior for ZC_Travel_Approver_M alias Approver
use etag
{
  field ( readonly ) BeginDate, EndDate, TotalPrice, CustomerID;

  use update;

  use action acceptTravel;
  use action rejectTravel;
}