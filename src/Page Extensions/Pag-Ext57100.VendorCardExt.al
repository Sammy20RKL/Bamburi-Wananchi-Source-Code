pageextension 57100 VendorCardExt extends "Vendor Card"
{

    layout
    {
        modify(MobilePhoneNo)
        {
            visible = true;
        }
        addafter("Phone No.")
        {

            field("Mobile Phone No"; Rec."Mobile Phone No")
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        // Error('Not Allowed');
    end;

    trigger OnOpenPage()
    begin
        // if (UserId <> 'Swizzsoft') then
        //     Error('Not Allowed');
    end;
}
