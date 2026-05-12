#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50452 "EFT Details"
{
    PageType = ListPart;
    SourceTable = "EFT Details";
    SourceTableView = sorting("Header No", No);

    layout
    {
        area(content)
        {
            repeater(Control17)
            {
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Type';
                }
                field(Charges; Charges)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Destination Account No"; Rec."Destination Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank No"; Rec."Bank No")
                {
                    ApplicationArea = Basic;
                }
                field("Payee Bank Name"; Rec."Payee Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DCHAR := 0;
        DCHAR := StrLen(Rec."Destination Account No");

        NotAvailable := true;
        AvailableBal := 0;


        //Available Bal
        if Accounts.Get(Rec."Account No") then begin
            Accounts.CalcFields(Accounts.Balance, Accounts."Uncleared Cheques", Accounts."ATM Transactions");
            if AccountTypes.Get(Accounts."Account Type") then begin
                AvailableBal := Accounts.Balance - (Accounts."Uncleared Cheques" + Accounts."ATM Transactions" + Charges + AccountTypes."Minimum Balance");

                if Rec.Amount <= AvailableBal then
                    NotAvailable := false;

            end;
        end;
    end;

    var
        DCHAR: Integer;
        NotAvailable: Boolean;
        AvailableBal: Decimal;
        Charges: Decimal;
        Accounts: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
}

