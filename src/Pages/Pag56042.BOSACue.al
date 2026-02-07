#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56042 "BOSA Cue"
{
    PageType = CardPart;
    SourceTable = "Members Cues";
    /* UsageCategory = Lists;
    ApplicationArea = Basic; */
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup(Group1)
            {
                Caption = 'BOSA Member Accounts ';
                // CuegroupLayout = Wide;
                field("All Members"; Rec."All Members")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                    //AutoFormatExpression = '#,##0;(#,##0);#';
                }

                field("Active Members"; Rec."Active Members")
                {

                    ApplicationArea = Basic;
                    Image = none;
                    Style = StandardAccent;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }

                field("NonActive Mbrs"; Rec."NonActive Mbrs")
                {

                    ApplicationArea = Basic;
                    Image = none;
                    Caption = 'Dormant Members';
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
                field(Deceased; Rec.Deceased)
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Attention;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
                field("Awaiting Exit"; Rec."Awaiting Exit")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Unfavorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }

                field(Exited; Rec.Exited)
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = StrongAccent;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
            }
            cuegroup(Gender)
            {

                field(Female; Rec.Female)
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
                field(Male; Rec.Male)
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";

                }

            }

        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get(UserId) then begin
            Rec.Init;
            Rec."User ID" := UserId;
            Rec.Insert;
        end;
    end;
}

