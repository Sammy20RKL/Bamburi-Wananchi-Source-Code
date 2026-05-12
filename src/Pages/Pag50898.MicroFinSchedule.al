#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50898 "Micro_Fin_Schedule"
{
    CardPageID = Micro_Fin_Transactions;
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = 51896;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount Received"; Rec."Amount Received")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Entrance Fee';
                }
                field("Deposits Contribution"; Rec."Deposits Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits';
                }
                field("Shares Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                    Caption = 'Shares';
                }
                field("Loans No."; Rec."Loans No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan No.';
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Principle Amount"; Rec."Principle Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Principle Amount"; Rec."Expected Principle Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Interest"; Rec."Expected Interest")
                {
                    ApplicationArea = Basic;
                }
                field(Savings; Rec.Savings)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cumulative Savings';
                }
                field(OutBal; Rec.OutBal)
                {
                    ApplicationArea = Basic;
                    Caption = 'OutBal';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Excess Amount"; Rec."Excess Amount")
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

