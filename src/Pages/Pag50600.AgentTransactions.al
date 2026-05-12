#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50600 "Agent Transactions"
{
    PageType = List;
    SourceTable = "Agent Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = Basic;
                }
                field(Messages; Rec.Messages)
                {
                    ApplicationArea = Basic;
                }
                field("Needs Change"; Rec."Needs Change")
                {
                    ApplicationArea = Basic;
                }
                field("Old Account No"; Rec."Old Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Changed; Rec.Changed)
                {
                    ApplicationArea = Basic;
                }
                field("Date Changed"; Rec."Date Changed")
                {
                    ApplicationArea = Basic;
                }
                field("Time Changed"; Rec."Time Changed")
                {
                    ApplicationArea = Basic;
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = Basic;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
                field("Original Account No"; Rec."Original Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Filter"; Rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Filter"; Rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Account No 2"; Rec."Account No 2")
                {
                    ApplicationArea = Basic;
                }
                field(CCODE; Rec.CCODE)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Location"; Rec."Transaction Location")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction By"; Rec."Transaction By")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("Id No"; Rec."Id No")
                {
                    ApplicationArea = Basic;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
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

