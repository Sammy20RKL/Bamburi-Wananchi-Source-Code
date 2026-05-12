#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50642 "Data Sheet FactBox"
{
    PageType = CardPart;
    SourceTable = "Data Sheet Header";

    layout
    {
        area(content)
        {
            field("Code"; Rec.Code)
            {
                ApplicationArea = Basic;
            }
            field("Total Members"; Rec."Total Members")
            {
                ApplicationArea = Basic;
            }
            field("Total Schedule Amount P"; Rec."Total Schedule Amount P")
            {
                ApplicationArea = Basic;
                Caption = 'Total Loan Principal';
            }
            field("Total Schedule Amount I"; Rec."Total Schedule Amount I")
            {
                ApplicationArea = Basic;
                Caption = 'Total Loan Interest';
            }
            field("Total Entrance Fees"; Rec."Total Entrance Fees")
            {
                ApplicationArea = Basic;
            }
            field("Total Share Capital"; Rec."Total Share Capital")
            {
                ApplicationArea = Basic;
            }
            field("Total Schedule Amount D"; Rec."Total Schedule Amount D")
            {
                ApplicationArea = Basic;
                Caption = 'Total Deposit Contribution';
            }
            field("Total Kanisa Savings"; Rec."Total Kanisa Savings")
            {
                ApplicationArea = Basic;
            }
            field("Total Schedule Amount"; Rec."Total Schedule Amount")
            {
                ApplicationArea = Basic;
                Style = Attention;
                StyleExpr = true;
            }
        }
    }

    actions
    {
    }
}

