#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50604 "Agent Applications Card"
{
    PageType = Card;
    SourceTable = "Agent Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Float Account"; Rec.Account)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field("Document Serial No"; Rec."Document Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Agent ID No"; Rec."Customer ID No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Time Approved"; Rec."Time Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Rejected"; Rec."Date Rejected")
                {
                    ApplicationArea = Basic;
                }
                field("Time Rejected"; Rec."Time Rejected")
                {
                    ApplicationArea = Basic;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = Basic;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = Basic;
                }
                field("Sent To Server"; Rec."Sent To Server")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("1st Approval By"; Rec."1st Approval By")
                {
                    ApplicationArea = Basic;
                }
                field("Date 1st Approval"; Rec."Date 1st Approval")
                {
                    ApplicationArea = Basic;
                }
                field("Time First Approval"; Rec."Time First Approval")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Limit Code"; Rec."Withdrawal Limit Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Withdrawal Limit Amount"; Rec."Withdrawal Limit Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Name of the Proposed Agent"; Rec."Name of the Proposed Agent")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Comm Account"; Rec."Comm Account")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Type of Business"; Rec."Type of Business")
                {
                    ApplicationArea = Basic;
                }
                field("Place of Business"; Rec."Place of Business")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Business/Work Experience"; Rec."Business/Work Experience")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Registered at"; Rec."Branch Registered at")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Branch; Rec.Branch)
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

