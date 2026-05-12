#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50558 "Loan Collateral Register List"
{
    CardPageID = "Loan Collateral Register Card";
    Editable = false;
    PageType = List;
    SourceTable = "Loan Collateral Register";

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
                field("Registered Owner"; Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type"; Rec."Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description"; Rec."Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = Basic;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
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

