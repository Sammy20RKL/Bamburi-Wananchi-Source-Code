#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50368 "Members Statistics"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Width = 50;
                }
                field("Holiday Contribution"; Rec."Holiday Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Welfare Contr"; Rec."Welfare Contr")
                {
                    ApplicationArea = Basic;
                    Caption = 'Welfare Contribution';
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital Balance';
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits Contribution Balance';
                }
                field("Benevolent Fund"; Rec."Benevolent Fund")
                {
                    ApplicationArea = Basic;
                    Caption = 'Benevolent Fund Balance';
                    Editable = false;
                }
                field("Additional Shares"; Rec."Additional Shares")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration Fee Paid"; Rec."Registration Fee Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Fund"; Rec."Insurance Fund")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Amount"; Rec."Dividend Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Loan Balance';
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Un-allocated Funds"; Rec."Un-allocated Funds")
                {
                    ApplicationArea = Basic;
                    StyleExpr = FieldStyle;
                }
                field("Loans Recoverd from Guarantors"; Rec."Loans Recoverd from Guarantors")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1102755002; "Loans Sub-Page List")
            {
                SubPageLink = "BOSA No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loan Disburesment Slip")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                // RunObject = Report 51516412;

                trigger OnAction()
                begin
                    //51516412
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange("Client Code", Rec."No.");
        if ObjLoans.Find('-') then
            OutstandingInterest := SFactory.FnGetInterestDueTodate(ObjLoans) - ObjLoans."Interest Paid";
    end;

    trigger OnAfterGetRecord()
    begin
        /*IF ("Assigned System ID"<>'') AND ("Assigned System ID"<>USERID) THEN BEGIN
          ERROR('You do not have permission to view this account Details');
          END;*/

        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                // if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;

        end;

        SetFieldStyle;

    end;

    var
        UserSetup: Record "User Setup";
        FieldStyle: Text;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "Swizzsoft Factory.";
        ObjLoans: Record "Loans Register";

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        Rec.CalcFields("Un-allocated Funds");
        if Rec."Un-allocated Funds" <> 0 then
            FieldStyle := 'Attention';
    end;
}

