page 57100 "FOSA Cue"
{
    PageType = CardPart;
    SourceTable = "Vendor Cue";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            cuegroup(Group1)


            {
                Caption = ' ';
                // CuegroupLayout = Wide;

                field("All A/c "; Rec."Registered Fosa")
                {
                    Caption = 'All FOSA A/c';
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Vendor List-FOSA";
                }

                field("Active Fosa"; Rec."Active Fosa")
                {
                    Caption = 'Active A/c';
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Vendor List-FOSA";

                }

                field("Dormant"; Rec."Dormant Fosa")
                {
                    Caption = 'Dormant A/c';
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Vendor List-FOSA";
                }


                field("Frozen Members"; Rec."Frozen Fosa")
                {
                    Caption = 'Frozen A/c';
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Vendor List-FOSA";
                }

                field("Closed Fosa"; Rec."Closed Fosa")
                {
                    Caption = 'Closed A/c';
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Vendor List-FOSA";
                }

                field("Deceased Fosa"; Rec."Deceased Fosa")

                {
                    Caption = 'Deceased A/c';
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Vendor List-FOSA";
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

