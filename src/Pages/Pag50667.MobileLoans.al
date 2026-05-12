#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50667 "Mobile Loans"
{
    PageType = List;
    SourceTable = "Mobile Loans";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Batch No"; Rec."Batch No")
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
                field("Sent To Server"; Rec."Sent To Server")
                {
                    ApplicationArea = Basic;
                }
                field("Date Sent To Server"; Rec."Date Sent To Server")
                {
                    ApplicationArea = Basic;
                }
                field("Time Sent To Server"; Rec."Time Sent To Server")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field("Corporate No"; Rec."Corporate No")
                {
                    ApplicationArea = Basic;
                }
                field("Delivery Center"; Rec."Delivery Center")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = Basic;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                }
                field("MPESA Doc No."; Rec."MPESA Doc No.")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Ist Notification"; Rec."Ist Notification")
                {
                    ApplicationArea = Basic;
                }
                field("2nd Notification"; Rec."2nd Notification")
                {
                    ApplicationArea = Basic;
                }
                field("3rd Notification"; Rec."3rd Notification")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Date"; Rec."Penalty Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Penalized; Rec.Penalized)
                {
                    ApplicationArea = Basic;
                }
                field("4th Notification"; Rec."4th Notification")
                {
                    ApplicationArea = Basic;
                }
                field("5th Notification"; Rec."5th Notification")
                {
                    ApplicationArea = Basic;
                }
                field("6th Notification"; Rec."6th Notification")
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

