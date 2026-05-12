#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50014 "Guarantor Sub Subform"
{
    PageType = ListPart;
    SourceTable = "Guarantorship Substitution L";

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
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Current Commitment"; Rec."Current Commitment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic;
                }
                field("Substitute Member"; Rec."Substitute Member")
                {
                    ApplicationArea = Basic;
                    //check if the member is already Guaranteeing this loan
                    trigger OnValidate()
                    var
                        loanGuarantors: Record "Loans Guarantee Details";
                    begin
                        loanGuarantors.Reset();
                        loanGuarantors.SetRange(loanGuarantors."Loan No", Rec."Loan No.");
                        loanGuarantors.SetRange(loanGuarantors."Member No", Rec."Substitute Member");
                        if loanGuarantors.Find('-') then begin
                            if Rec."self  substitute" = false then
                                Error('This member is already a Guarantor in this Loan');
                        end;
                    end;
                }
                field("Substitute Member Name"; Rec."Substitute Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub Amount Guaranteed"; Rec."Sub Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("self  substitute"; Rec."self  substitute")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        if GSubHeader.Get(Rec."Document No") then begin
            if GSubHeader.Status = GSubHeader.Status::Open then begin
                SubPageEditable := true
            end else
                if GSubHeader.Status <> GSubHeader.Status::Open then begin
                    SubPageEditable := false;
                end;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        if GSubHeader.Get(Rec."Document No") then begin
            if GSubHeader.Status = GSubHeader.Status::Open then begin
                SubPageEditable := true
            end else
                if GSubHeader.Status <> GSubHeader.Status::Open then begin
                    SubPageEditable := false;
                end;
        end;
    end;

    var
        SubPageEditable: Boolean;
        GSubHeader: Record 51563;
}

