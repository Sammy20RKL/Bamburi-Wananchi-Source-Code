#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50961 "Member Cell Groups List"
{
    // CardPageID = "Member Cell Group Card";
    Editable = false;
    PageType = List;
    SourceTable = 51915;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cell Group Code"; Rec."Cell Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("Cell Group Name"; Rec."Cell Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Formed"; Rec."Date Formed")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader"; Rec."Group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader Name"; Rec."Group Leader Name")
                {
                    ApplicationArea = Basic;
                }
                field("Assistant group Leader"; Rec."Assistant group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Assistant Group Name"; Rec."Assistant Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Place"; Rec."Meeting Place")
                {
                    ApplicationArea = Basic;
                }
                field("No of Members"; Rec."No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Officer"; Rec."Credit Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Field Officer"; Rec."Field Officer")
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

