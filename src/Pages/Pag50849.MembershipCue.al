#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50849 "Membership Cue"
{
    PageType = CardPart;
    SourceTable = 51936;

    layout
    {
        area(content)
        {
            cuegroup(Members)
            {
                field("Active Members"; Rec."Active Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Dormant Members"; Rec."Dormant Members")
                {
                    ApplicationArea = Basic;
                    Image = PEople;
                }
                field("Non-Active Members"; Rec."Non-Active Members")
                {
                    ApplicationArea = Basic;
                    Image = PEople;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Deceased Members"; Rec."Deceased Members")
                {
                    ApplicationArea = Basic;
                    Image = People;
                }
                field("Withdrawn Members"; Rec."Withdrawn Members")
                {
                    ApplicationArea = Basic;
                    Image = People;
                }
            }
            cuegroup("Account Categories")
            {
                field("Female Members"; Rec."Female Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Male Members"; Rec."Male Members")
                {
                    ApplicationArea = Basic;
                    Image = Library;
                    Style = Ambiguous;
                    StyleExpr = true;
                }
            }
            cuegroup(Loans)
            {
                Caption = 'Back Office Loans';
                field("Normal Loan"; Rec."Normal Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Normal Loans';
                    Image = "None";
                }
                field(EMERGENCY; Rec.EMERGENCY)
                {
                    ApplicationArea = Basic;
                    Caption = 'Emergency Loans';
                    Image = Chart;
                }
                field(SCHOOL; Rec.SCHOOL)
                {
                    ApplicationArea = Basic;
                    Caption = 'School Fees Loans';
                    Image = Chart;
                }
            }
            cuegroup("Front Office Loans")
            {
                Caption = 'Front Office Loans';
                field(ADVANCE1A; Rec.ADVANCE1A)
                {
                    ApplicationArea = Basic;
                    Caption = 'Advance 1A';
                }
                field(ADVANCE1B; Rec.ADVANCE1B)
                {
                    ApplicationArea = Basic;
                    Caption = 'Advance 1B';
                }
                field(ADVANCE1C; Rec.ADVANCE1C)
                {
                    ApplicationArea = Basic;
                    Caption = 'Advance 1C';
                }
                field(SALARYADVANCE; Rec.SALARYADVANCE)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary in Advance';
                }
                field(FOSALOAN; Rec.FOSALOAN)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fosa Loan';
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

