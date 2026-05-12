#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50193 "HR Lookup Values List"
{
    ApplicationArea = Basic;
    CardPageID = "HR Lookup Values Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Lookup Values";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Lookup Values Factbox")
            {
                SubPageLink = Type = field(Type);
            }
        }
    }

    actions
    {
    }
}

