#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56014 "Cash Payment List posted"
{
    // CardPageID = "Cash Payment Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Payments Header";
    SourceTableView = where("Payment Type" = const("Petty Cash"));//,
                                                                  // Posted = const(Yes));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount(LCY)"; Rec."Net Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."payment type"::"Cash Purchase";
        if FundsSetup.Get then begin
            FundsSetup.TestField(FundsSetup."Cash Account");
            Rec."Paying Bank Account" := FundsSetup."Cash Account";
            Rec.Validate("Paying Bank Account");
        end;
    end;

    trigger OnOpenPage()
    begin
        // Rec.SetRange(UserId, UserId);
    end;

    var
        FundsSetup: Record 51030;
}

