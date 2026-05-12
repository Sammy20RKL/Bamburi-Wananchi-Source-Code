#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50289 "HR Medical Claims List"
{
    CardPageID = "HR Medical Claim Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Medical Claims";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claim No"; Rec."Claim No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = Basic;
                }
                field(Dependants; Rec.Dependants)
                {
                    ApplicationArea = Basic;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = Basic;
                }
                field("Document Ref"; Rec."Document Ref")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Service"; Rec."Date of Service")
                {
                    ApplicationArea = Basic;
                }
                field("Attended By"; Rec."Attended By")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Charged"; Rec."Amount Charged")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Dependants: Record "HR Employee Kin";
}

