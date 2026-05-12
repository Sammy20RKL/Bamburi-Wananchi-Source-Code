#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50422 "Employer list"
{
    CardPageID = "Sacco Employers card";
    PageType = List;
    SourceTable = "Sacco Employers";

    layout
    {
        area(content)
        {
            repeater(Group)
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
                }
                field("Check Off"; Rec."Check Off")
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

