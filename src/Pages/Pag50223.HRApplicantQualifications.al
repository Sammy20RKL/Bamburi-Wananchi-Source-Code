#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50223 "HR Applicant Qualifications"
{
    Caption = 'Applicant Qualifications';
    PageType = List;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HR Applicant Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Score ID"; Rec."Score ID")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
    }
}

