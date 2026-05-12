#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56177 "Bosa Receipt line-Checkoff"
{
    PageType = ListPart;
    SourceTable = "ReceiptsProcessing_L-Checkoff";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Line No"; Rec."Receipt Line No")
                {
                    ApplicationArea = Basic;
                }
                field("Trans Type"; Rec."Trans Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Staff Not Found"; Rec."Staff Not Found")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member Found"; Rec."Member Found")
                {
                    ApplicationArea = Basic;
                }
                field("Search Index"; Rec."Search Index")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("FOSA Account"; Rec."FOSA Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Xmas Account"; Rec."Xmas Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Xmas Contribution"; Rec."Xmas Contribution")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

