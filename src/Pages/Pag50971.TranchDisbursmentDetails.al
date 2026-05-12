#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50971 "Tranch Disbursment Details"
{
    PageType = ListPart;
    SourceTable = "Tranch Disburesment Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                // field(Description; Description)
                // {
                //     ApplicationArea = Basic;
                // }
                field("Transaction Date"; Rec."Transaction Date")
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
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan No");
        if ObjLoans.FindSet then begin
            Rec."Client Code" := ObjLoans."Client Code";
            Rec."Client Name" := ObjLoans."Client Name";
            Rec."Loan Product Type" := ObjLoans."Loan Product Type";
        end;
    end;

    var
        ObjLoans: Record 51371;
}

