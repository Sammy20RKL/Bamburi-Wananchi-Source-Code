#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50423 "Sacco Employers card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Sacco Employers";

    layout
    {
        area(content)
        {
            field("Code"; Rec.Code)
            {
                ApplicationArea = Basic;

            }
            field(Description; Rec.Description)
            {
                ApplicationArea = Basic;
            }
            field("Repayment Method"; Rec."Repayment Method")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Check Off"; Rec."Check Off")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("No. of Members"; Rec."No. of Members")
            {
                ApplicationArea = Basic;
            }
            field(Male; Rec.Male)
            {
                ApplicationArea = Basic;
            }
            field(Female; Rec.Female)
            {
                ApplicationArea = Basic;
            }
            field("Vote Code"; Rec."Vote Code")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Can Guarantee Loan"; Rec."Can Guarantee Loan")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Active Members"; Rec."Active Members")
            {
                ApplicationArea = Basic;
            }
            field("Dormant Members"; Rec."Dormant Members")
            {
                ApplicationArea = Basic;
            }
            field(Withdrawn; Rec.Withdrawn)
            {
                ApplicationArea = Basic;
            }
            field(Deceased; Rec.Deceased)
            {
                ApplicationArea = Basic;
            }
            field("Join Date2"; Rec."Join Date2")
            {
                Caption = 'Join Date';
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }
}

