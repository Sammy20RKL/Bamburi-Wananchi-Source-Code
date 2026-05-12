#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50476 "Credit Processor Role"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Cue Sacco Roles";

    layout
    {
        area(content)
        {
            cuegroup("Loan Activities")
            {
                Caption = 'Loan Activities';
                field("Application Loans"; Rec."Application Loans")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Employee Common Activities";
                }
                field("Appraisal Loans"; Rec."Appraisal Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Loans"; Rec."Approved Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Rejected Loans"; Rec."Rejected Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Pending Loan Batches"; Rec."Pending Loan Batches")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Loan Batches"; Rec."Approved Loan Batches")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Loans Calculator")
            {
                ApplicationArea = Basic;
                RunObject = Page "Receipt Line";
            }
            action("Members  List")
            {
                ApplicationArea = Basic;
                // RunObject = Page "Staff Leave Claim Lines";
            }
            action("Bosa Loans")
            {
                ApplicationArea = Basic;
                RunObject = Page "HR Job Responsibilities";
            }
        }
    }
}