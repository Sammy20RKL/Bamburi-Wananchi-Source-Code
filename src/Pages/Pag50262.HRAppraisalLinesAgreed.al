#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50262 "HR Appraisal Lines-Agreed"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "HR Appraisal Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(Sections; Rec.Sections)
                {
                    ApplicationArea = Basic;
                }
                field("Perfomance Goals and Targets"; Rec."Perfomance Goals and Targets")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                    Width = 300;
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Peer Rating"; Rec."Peer Rating")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Supervisor Rating"; Rec."Supervisor Rating")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub-ordinates Rating"; Rec."Sub-ordinates Rating")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outside Agencies Rating"; Rec."Outside Agencies Rating")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Agreed Rating"; Rec."Agreed Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Agreed Rating x Weighting"; Rec."Agreed Rating x Weighting")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee Comments"; Rec."Employee Comments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Peer Comments"; Rec."Peer Comments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Supervisor Comments"; Rec."Supervisor Comments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Subordinates Comments"; Rec."Subordinates Comments")
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

