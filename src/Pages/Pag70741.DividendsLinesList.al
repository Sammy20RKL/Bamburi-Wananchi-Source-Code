#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
page 70741 "Dividend Lines List"
{

    PageType = ListPart;
    InsertAllowed = true;
    DeleteAllowed = true;
    RefreshOnActivate = true;
    ApplicationArea = ALL;
    SourceTable = "Dividends Lines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."Line No") { ApplicationArea = all; }
                field("No"; Rec."No")
                {
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }



                field("Blocked"; Rec."Blocked")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field("Qualifying Shares"; Rec."Qualifying Shares")
                {
                    ApplicationArea = all;
                }


                field("Qualifying Amount"; Rec."Qualifying Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Qualifying Deposits';
                }
                field("Gross Dividends"; Rec."Gross Dividends")
                {
                    ApplicationArea = all;
                }
                field("Dividends on Shares"; Rec."Dividends on Shares")
                { }
                field("Interest on Deposits"; Rec."Interest on Deposits")
                {
                    ApplicationArea = all;

                }

                field("Earned Amount"; Rec."Earned Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Total Earnings';
                }
                field("Withholding Tax(Share&Depo)"; Rec."Withholding Tax(Share&Depo)")
                {
                    ApplicationArea = All;
                    Caption = 'Withholding Tax ';
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    ApplicationArea = All;
                    // Editable = false;
                    Caption = 'Net Before Deductions';
                }
                field("X-Mas Loan"; Rec."X-Mas Loan")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("To Others"; Rec."To Others") { ApplicationArea = all; }
                field("Net After Deduction"; Rec."Net After Deduction")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    // Editable = false;
                }



            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
}