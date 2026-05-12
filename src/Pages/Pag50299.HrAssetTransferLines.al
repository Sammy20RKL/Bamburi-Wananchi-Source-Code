#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50299 "Hr Asset Transfer Lines"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HR Asset Transfer Lines";

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
                field("Asset No."; Rec."Asset No.")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Bar Code"; Rec."Asset Bar Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FA Location"; Rec."FA Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Asset Serial No"; Rec."Asset Serial No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsible Employee Code"; Rec."Responsible Employee Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Responsible Employee Code"; Rec."New Responsible Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field("New Employee Name"; Rec."New Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 2 Name"; Rec."Dimension 2 Name")
                {
                    ApplicationArea = Basic;
                }
                field("New Global Dimension 2 Code"; Rec."New Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("New  Dimension 2 Name"; Rec."New  Dimension 2 Name")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 3 Name"; Rec."Dimension 3 Name")
                {
                    ApplicationArea = Basic;
                }
                field("New Global Dimension 3 Code"; Rec."New Global Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field("New  Dimension 3 Name"; Rec."New  Dimension 3 Name")
                {
                    ApplicationArea = Basic;
                }
                field("Is Asset Expected Back?"; Rec."Is Asset Expected Back?")
                {
                    ApplicationArea = Basic;
                }
                field("New Asset Location"; Rec."New Asset Location")
                {
                    ApplicationArea = Basic;
                }
                field("Reason for Transfer"; Rec."Reason for Transfer")
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

