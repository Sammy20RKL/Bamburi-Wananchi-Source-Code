#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56913 "Portal Feedback"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = Questionnaire;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Entry; Rec.Entry)
                {
                    ApplicationArea = Basic;
                }
                field(ServedBy; Rec.ServedBy)
                {
                    ApplicationArea = Basic;
                }
                field(ReasonForVisit; Rec.ReasonForVisit)
                {
                    ApplicationArea = Basic;
                }
                field(Member; Rec.Member)
                {
                    ApplicationArea = Basic;
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = Basic;
                }
                field(MostImpressedwith; Rec.MostImpressedwith)
                {
                    ApplicationArea = Basic;
                }
                field(LeastImpressedWIth; Rec.LeastImpressedWIth)
                {
                    ApplicationArea = Basic;
                }
                field(Suggestions; Rec.Suggestions)
                {
                    ApplicationArea = Basic;
                }
                field(Accounts; Rec.Accounts)
                {
                    ApplicationArea = Basic;
                }
                field(Customercare; Rec.Customercare)
                {
                    ApplicationArea = Basic;
                }
                field(OfficeAtmosphere; Rec.OfficeAtmosphere)
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

