#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56159 "EFT List"
{
    ApplicationArea = Basic;
    CardPageID = "EFT Header Card";
    Editable = false;
    PageType = List;
    SourceTable = "EFT Header Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = Basic;
                }
                field("Date Transferred"; Rec."Date Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Time Transferred"; Rec."Time Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Transferred By"; Rec."Transferred By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Payee Bank Name"; Rec."Payee Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank  No"; Rec."Bank  No")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Processing No."; Rec."Salary Processing No.")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Options"; Rec."Salary Options")
                {
                    ApplicationArea = Basic;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                }
                field(RTGS; Rec.RTGS)
                {
                    ApplicationArea = Basic;
                }
                field("Document No. Filter"; Rec."Document No. Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Date Filter"; Rec."Date Filter")
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

