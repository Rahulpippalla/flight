managed implementation in class zbp_i_supplement unique;
strict(2);
with draft;

define behavior for ZI_Supplement alias Supplement
early numbering
persistent table zsupplement
draft table zsuppl_d
lock master
total etag LastChangedAt
etag master LocalLastChangedAt
authorization master ( global )
{
  create;
  update;
  delete;

  field ( readonly ) SupplementID;
  field ( mandatory: create, readonly : update ) SupplementCategory;
  field ( mandatory ) Price, CurrencyCode;

  draft action Resume;
  draft action Edit;
  draft action Activate;
  draft action Discard;


  validation validatePrice on save { create; update; }

  draft determine action Prepare
  { validation validatePrice; }

  association _SupplementText { create; with draft; }

  mapping for ZSUPPLEMENT {
    SupplementID       = supplement_id;
    SupplementCategory = supplement_category;
    Price              = price;
    CurrencyCode       = currency_code;
    LocalCreatedBy     = local_created_by;
    LocalCreatedAt     = local_created_at;
    LocalLastChangedBy = local_last_changed_by;
    LocalLastChangedAt = local_last_changed_at;
    LastChangedAt      = last_changed_at;
  }
}

define behavior for ZI_SupplementText alias SupplementText
persistent table zsuppl_text
draft table zsuppl_txt_d
lock dependent by _Supplement
etag master LocalLastChangedAt
authorization dependent by _Supplement
{

  association _Supplement { with draft; }

  update;
  delete;

  field ( readonly ) SupplementID;
  field ( mandatory : create, readonly : update ) LanguageCode;

  mapping for ZSUPPL_TEXT {
    SupplementID       = supplement_id;
    LanguageCode       = language_code;
    Description        = description;
    LocalLastChangedAt = local_last_changed_at;
  }
}