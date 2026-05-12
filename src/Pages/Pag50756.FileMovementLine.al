#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50756 "File Movement Line"
{
    PageType = ListPart;
    SourceTable = "File Movement Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = Basic;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Destination File Location"; Rec."Destination File Location")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Purpose/Description"; Rec."Purpose/Description")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
            }
        }
    }

    actions
    {
    }
}

