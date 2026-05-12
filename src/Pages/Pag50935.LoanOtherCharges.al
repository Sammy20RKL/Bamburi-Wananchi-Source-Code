#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50935 "Loan Other Charges"
{
    PageType = List;
    SourceTable = "Loan Other Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
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

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan No.");
        if ObjLoans.FindSet then begin

            if Rec."Loan Type" = '' then
                Rec."Loan Type" := ObjLoans."Loan Product Type";
            Rec.Modify(true);
            if ObjLoans."Loan Product Type" = '' then
                Error('Please select the loan type');
        end;
    end;

    var
        ObjLoans: Record 51371;
}

