tableextension 50041 "PurchaseHeaderExt" extends "Purchase Header"
{
    fields
    {
        field(2000; DocApprovalType; Enum DocApprovalType)
        {
            Caption = 'DocApprovalType';
            DataClassification = ToBeClassified;
        }
        field(20001; "Project Code"; Code[20]) { }
    }
}
