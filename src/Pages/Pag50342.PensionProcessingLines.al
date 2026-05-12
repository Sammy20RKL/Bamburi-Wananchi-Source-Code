#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50342 "Pension Processing Lines"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = 51351;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Pension No"; Rec."Pension No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Reff."; Rec."Branch Reff.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Original Account No."; Rec."Original Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Not Found"; Rec."Account Not Found")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("BOSA Schedule"; Rec."BOSA Schedule")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Multiple Salary"; Rec."Multiple Salary")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }
                field("Bosa No"; Rec."Bosa No")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Header No."; Rec."Salary Header No.")
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

        //SETRANGE(USER,USERID);
    end;
}

