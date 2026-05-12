#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 56021 "Member Due Diligence Measure"
{
    PageType = ListPart;
    SourceTable = "Member Due Diligence Measures";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Due Diligence Measure"; Rec."Due Diligence Measure")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Due Diligence Done"; Rec."Due Diligence Done")
                {
                    ApplicationArea = Basic;
                }
                field("Due Diligence Type"; Rec."Due Diligence Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Diligence Type field.';
                }
                field("Risk Rating Scale"; Rec."Risk Rating Scale")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Risk Rating Scale field.';
                }
                field("Due Diligence Done By"; Rec."Due Diligence Done By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

