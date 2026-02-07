#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50387 "Loans Guarantee Details"
{
    PageType = ListPart;
    RefreshOnActivate = false;
    SourceTable = "Loans Guarantee Details";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Shares; Rec.Shares)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits';
                    Visible = true;
                }
                field("Amont Guaranteed"; Rec."Amont Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = Basic;
                }

                field("Committed Shares"; Rec."Committed Shares")
                {
                    ApplicationArea = Basic;
                }
                // field("TotalLoan Guaranteed"; Rec."TotalLoan Guaranteed")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Guarantorship Liability';
                // }
                field(CStatus; CStatus)
                {
                    ApplicationArea = Basic;
                    Caption = 'Status';
                    Editable = false;
                }
                field("free Share"; Rec."free Share")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Date; Rec.Date)
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

    trigger OnOpenPage()
    begin
        /*//**Prevent modification of approved entries
        LoanApps.RESET;
        LoanApps.SETRANGE(LoanApps."Loan  No.","Loan No");
        IF LoanApps.FIND('-') THEN BEGIN
         IF LoanApps."Loan Status"=LoanApps."Loan Status"::Approved THEN BEGIN
          CurrPage.EDITABLE:=FALSE;
         END ELSE
          CurrPage.EDITABLE:=TRUE;
        END;
        */

    end;

    var
        Cust: Record Customer;
        EmployeeCode: Code[20];
        CStatus: Option Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member","New (Pending Confirmation)","Defaulter Recovery";
        LoanApps: Record "Loans Register";
        StatusPermissions: Record "Status Change Permision";
}

