#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50664 "Loan Application Witness"
{
    PageType = List;
    SourceTable = "Loan App Witness";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Witness No"; Rec."Witness No")
                {
                    ApplicationArea = Basic;
                }
                field("Witness Name"; Rec."Witness Name")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
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

