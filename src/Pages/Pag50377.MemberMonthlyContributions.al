#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50377 "Member Monthly Contributions"
{
    PageType = List;
    SourceTable = "Member Monthly Contributions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Off"; Rec."Amount Off")
                {
                    ApplicationArea = Basic;
                }
                field("Amount ON"; Rec."Amount ON")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Priority"; Rec."Check Off Priority")
                {
                    ApplicationArea = Basic;
                }
                field("Last Advice Date"; Rec."Last Advice Date")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance 2"; Rec."Balance 2")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

