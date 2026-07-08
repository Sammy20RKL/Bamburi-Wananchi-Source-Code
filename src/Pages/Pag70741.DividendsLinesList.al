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
                    Caption = 'X-Mas Loan Principle';
                    // Editable = false;
                }
                field("X-Mas Loan Interest"; Rec."X-Mas Loan Interest")
                {
                    ApplicationArea = all;
                    Caption = 'X-Mas Loan Interest';
                    // Editable = false;
                }
                field("Emer Loan Principle"; Rec."Emer Loan Principle")
                {
                    applicationArea = all;
                }
                field("Emer Loan Interest"; Rec."Emer Loan Interest")
                {
                    applicationArea = all;
                }
                field("Hallo Loan Principle"; Rec."Hallo Loan Principle")
                {
                    applicationArea = all;
                }
                field("Hallo Loan Interest"; Rec."Hallo Loan Interest")
                {
                    applicationArea = all;
                }
                field("Norm2 Loan Principle"; Rec."Norm2 Loan Principle")
                {
                    applicationArea = all;
                }
                field("Norm2 Loan Interest"; Rec."Norm2 Loan Interest")
                {
                    applicationArea = all;
                }
                field("Norm1 Loan Principle"; Rec."Norm1 Loan Principle")
                {
                    applicationArea = all;
                }
                field("Norm1 Loan Interest"; Rec."Norm1 Loan Interest")
                {
                    applicationArea = all;
                }
                field("School Loan Principle"; Rec."School Loan Principle")
                {
                    applicationArea = all;
                }
                field("School Loan Interest"; Rec."School Loan Interest")
                {
                    applicationArea = all;
                }
                field("Mbuyu Loan Principle"; Rec."Mbuyu Loan Principle")
                {
                    applicationArea = all;
                }
                field("Mbuyu Loan Interest"; Rec."Mbuyu Loan Interest")
                {
                    applicationArea = all;
                }
                field("Kivukio Loan Principle"; Rec."Kivukio Loan Principle")
                {
                    applicationArea = all;
                }
                field("Kivukio Loan Interest"; Rec."Kivukio Loan Interest")
                {
                    applicationArea = all;
                }
                field("Instant Loan Principle"; Rec."Instant Loan Principle")
                {
                    applicationArea = all;
                }
                field("Instant Loan Interest"; Rec."Instant Loan Interest")
                {
                    applicationArea = all;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("Holiday Savings"; Rec."Holiday Savings")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("Unclaimed Dividends"; Rec."Unclaimed Dividends")
                {
                    ApplicationArea = all;
                }
                field("T-Shirts"; Rec."T-Shirts")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("Net After Deduction"; Rec."Net After Deduction")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
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