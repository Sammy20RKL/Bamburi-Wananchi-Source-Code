#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
page 70741 "Dividend Lines List"
{

    PageType = List;
    SourceTable = "Dividends Lines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Blocked"; Rec."Blocked")
                {
                    ApplicationArea = All;
                }
                field("Loan Recovered Deposits"; Rec."Loan Recovered Deposits")
                {
                    ApplicationArea = All;
                }
                field("Loan Recovered Dividend"; Rec."Loan Recovered Dividend")
                {
                    ApplicationArea = All;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = All;
                }
                field("Member Blocked"; Rec."Member Blocked")
                {
                    ApplicationArea = All;
                }
                field("Earned Amount"; Rec."Earned Amount")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax(Share&Depo)"; Rec."Withholding Tax(Share&Depo)")
                {
                    ApplicationArea = All;
                    Caption = 'Withholding Tax ';
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    ApplicationArea = All;
                }
                field("Qualifying Amount"; Rec."Qualifying Amount")
                {
                    ApplicationArea = All;
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