#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50859 "Fixed Deposit Placement"
{
    CardPageID = "Fixed Deposit Placement Card";
    Editable = false;
    PageType = List;
    SourceTable = 51945;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Account No"; Rec."Fixed Deposit Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
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

