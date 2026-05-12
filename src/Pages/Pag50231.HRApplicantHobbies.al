#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50231 "HR Applicant Hobbies"
{
    PageType = List;
    SourceTable = "HR Applicant Hobbies";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Hobby; Rec.Hobby)
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

