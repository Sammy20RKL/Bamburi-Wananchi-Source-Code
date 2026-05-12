#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50229 "HR Shortlisting Lines"
{
    Caption = 'Shorlisted Candidates';
    Editable = false;
    PageType = List;
    SourceTable = "HR Shortlisted Applicants";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualified';

                    trigger OnValidate()
                    begin
                        Rec."Manual Change" := true;
                        Rec.Modify;
                    end;
                }
                field("Job Application No"; Rec."Job Application No")
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
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Stage Score"; Rec."Stage Score")
                {
                    ApplicationArea = Basic;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic;
                }
                field(Employ; Rec.Employ)
                {
                    ApplicationArea = Basic;
                    Caption = 'Employed';
                }
                field("Reporting Date"; Rec."Reporting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Manual Change"; Rec."Manual Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'Manual Change';
                }
            }
        }
    }

    actions
    {
    }

    var
        MyCount: Integer;


    procedure GetApplicantNo() AppicantNo: Code[20]
    begin
        //AppicantNo:=Applicant;
    end;
}

