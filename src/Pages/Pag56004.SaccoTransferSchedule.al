#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56004 "Sacco Transfer Schedule"
{
    PageType = ListPart;
    SourceTable = "Sacco Transfers Schedule";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Loan"; Rec."Destination Loan")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Total Payment Loan"; Rec."Cummulative Total Payment Loan")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SaccoHeader.Reset;
        SaccoHeader.SetRange(SaccoHeader.No, Rec."No.");
        if SaccoHeader.FindSet then begin
            if SaccoHeader.Status = SaccoHeader.Status::Open then begin
                CurrPage.Editable := true
            end else
                CurrPage.Editable := false;
        end;
    end;

    trigger OnOpenPage()
    begin
        SaccoHeader.Reset;
        SaccoHeader.SetRange(SaccoHeader.No, Rec."No.");
        if SaccoHeader.FindSet then begin
            if SaccoHeader.Status = SaccoHeader.Status::Open then begin
                CurrPage.Editable := true
            end else
                if (SaccoHeader.Status = SaccoHeader.Status::pending) or (SaccoHeader.Status = SaccoHeader.Status::pending) then begin
                    CurrPage.Editable := false;
                end;
        end;
    end;

    var
        SaccoHeader: Record "Sacco Transfers";
}

