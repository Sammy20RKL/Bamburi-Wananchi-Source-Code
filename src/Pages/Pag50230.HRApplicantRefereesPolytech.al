#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50230 "HR Applicant Referees Polytech"
{
    PageType = List;
    SourceTable = "HR Applicant Referees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; Rec."E-Mail")
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

