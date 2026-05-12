#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50997 "Loan Stages"
{
    PageType = List;
    SourceTable = "Loan Stages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Stage"; Rec."Loan Stage")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Stage Description"; Rec."Loan Stage Description")
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

