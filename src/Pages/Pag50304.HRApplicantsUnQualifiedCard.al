#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50304 "HR Applicants UnQualified Card"
{
    PageType = Card;
    SourceTable = "HR Job Applications";
    SourceTableView = where("Qualification Status" = filter(UnQualified));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field("Job Applied For"; Rec."Job Applied For")
                {
                    ApplicationArea = Basic;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                }
                field("Date of Interview"; Rec."Date of Interview")
                {
                    ApplicationArea = Basic;
                }
                field("From Time"; Rec."From Time")
                {
                    ApplicationArea = Basic;
                }
                field("To Time"; Rec."To Time")
                {
                    ApplicationArea = Basic;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = Basic;
                }
                field("Interview Type"; Rec."Interview Type")
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

