#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50383 "Receipt Allocation-BOSA"
{
    PageType = List;
    SourceTable = "Receipt Allocation";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    // LookupPageID = "Fosa Account List";
                    Visible = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if (Rec."Transaction Type" <> Rec."transaction type"::"Mwanangu Savings") and (Rec."Transaction Type" <> Rec."transaction type"::" ") then begin
                            Rec."Account Type" := Rec."account type"::Customer
                        end else
                            Rec."Account Type" := Rec."account type"::Vendor;
                    end;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount Balance"; Rec."Amount Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Balance"; Rec."Interest Balance")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*sto.RESET;
        sto.SETRANGE(sto."No.","Document No");
        IF sto.FIND('-') THEN BEGIN
        IF sto.Status=sto.Status::Approved THEN BEGIN
        CurrPage.EDITABLE:=FALSE;
        END ELSE
        CurrPage.EDITABLE:=TRUE;
        END;
        */

    end;

    var
        sto: Record "Standing Orders";
        Loan: Record "Loans Register";
        ReceiptAllocation: Record "Receipt Allocation";
        ReceiptH: Record "Receipts & Payments";
}

