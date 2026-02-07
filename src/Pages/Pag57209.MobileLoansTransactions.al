
page 57209 "Mobile Loans Transactions"
{
    ApplicationArea = All;
    Caption = 'Mobile Loans';
    PageType = List;
    SourceTable = "Mobile Loans";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                }
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Member No"; Rec."Member No")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Batch No"; Rec."Batch No")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Date Entered"; Rec."Date Entered")
                {
                }
                field("Outstanding Balance"; Rec."Outstanding Balance") { }
                field("Outstanding Interest"; Rec."Outstanding Interest") { }
                field("Ist Notification"; Rec."Ist Notification")
                {
                }
                field("2nd Notification"; Rec."2nd Notification")
                {
                }
                field("3rd Notification"; Rec."3rd Notification")
                {
                }
                field("4th Notification"; Rec."4th Notification")
                {
                }
                field("5th Notification"; Rec."5th Notification")
                {
                }
                field("6th Notification"; Rec."6th Notification")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Corporate No"; Rec."Corporate No")
                {
                }
                field("Date Sent To Server"; Rec."Date Sent To Server")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                }
                field("MPESA Doc No."; Rec."MPESA Doc No.")
                {
                }
                field(Penalized; Rec.Penalized)
                {
                }
                field("Penalty Date"; Rec."Penalty Date")
                {
                }
                field("Delivery Center"; Rec."Delivery Center")
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
                field(Purpose; Rec.Purpose)
                {
                }
                field("Sent To Server"; Rec."Sent To Server")
                {
                }
                field("Time Entered"; Rec."Time Entered")
                {
                }
                field("Time Sent To Server"; Rec."Time Sent To Server")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Entered By"; Rec."Entered By")
                {
                }
                field("Telephone No"; Rec."Telephone No")
                {
                }
            }
        }
    }
}
