#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50221 "HR E-Mail Parameters"
{
    PageType = Card;
    SourceTable = "HR E-Mail Parameters";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Associate With"; Rec."Associate With")
                {
                    ApplicationArea = Basic;
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    ApplicationArea = Basic;
                }
                field("Sender Address"; Rec."Sender Address")
                {
                    ApplicationArea = Basic;
                }
                field(Recipients; Rec.Recipients)
                {
                    ApplicationArea = Basic;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = Basic;
                }
                field(Body; Rec.Body)
                {
                    ApplicationArea = Basic;
                }
                field("Body 2"; Rec."Body 2")
                {
                    ApplicationArea = Basic;
                }
                field("Body 3"; Rec."Body 3")
                {
                    ApplicationArea = Basic;
                }
                field(HTMLFormatted; Rec.HTMLFormatted)
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

