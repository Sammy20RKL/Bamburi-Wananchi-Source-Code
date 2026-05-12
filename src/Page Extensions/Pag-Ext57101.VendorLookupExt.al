pageextension 57101 VendorLookupExt extends "Vendor Lookup"
{
    layout
    {
        addbefore(Name)
        {
            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = Basic;
            }
            field("BOSA Account No"; Rec."BOSA Account No")
            {
                ApplicationArea = Basic;
            }
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify(Address)
        {
            Visible = false;
        }
        modify(City)
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }

    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // Error('Not allowed');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Error('Not allowed');
    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;
}
