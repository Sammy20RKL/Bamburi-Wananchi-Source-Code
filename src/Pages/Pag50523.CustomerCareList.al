#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50523 "Customer Care List"
{
    CardPageID = "Customer Care Card";
    Editable = false;
    PageType = List;
    SourceTable = Customer;

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No"; Rec."Personal No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No.';
                }
                field("FOSA Account No."; Rec."FOSA Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
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
        /*IF ("Assigned System ID"<>'')  THEN BEGIN //AND ("Assigned System ID"<>USERID)
          IF UserSetup.GET(USERID) THEN
        BEGIN
        IF UserSetup."View Special Accounts"=FALSE THEN
           ERROR ('You do not have permission to view this account Details, Contact your system administrator! ')
        END;
        
          END;*/

    end;

    var
        UserSetup: Record "User Setup";
}

