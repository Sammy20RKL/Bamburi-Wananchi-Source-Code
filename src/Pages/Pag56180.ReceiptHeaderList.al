#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56180 "Receipt Header List"
{
    ApplicationArea = Basic;
    CardPageID = "Receipt Header Card";
    DeleteAllowed = true;
    PageType = List;
    SourceTable = "Receipt Header";
    SourceTableView = where(Status = filter(New));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Received(LCY)"; Rec."Amount Received(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID", UserId);
        Rec.SetRange("Receipt Category", Rec."receipt category"::Normal);
    end;
}

