#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50323 "Payroll Transaction List."
{
    CardPageID = "payroll Transaction Code.";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payroll Transaction Code.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Is Formulae"; Rec."Is Formulae")
                {
                    ApplicationArea = Basic;
                }
                field(Formulae; Rec.Formulae)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Debit Account';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Debit Account Name';
                }
                // field("Credit Account"; "Credit Account")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Credit Account';
                // }
                // field("Credit Account Name"; "Credit Account Name")
                // {
                //     ApplicationArea = Basic;
                // }
                field("IsCo-Op/LnRep"; Rec."IsCo-Op/LnRep")
                {
                    ApplicationArea = Basic;
                    Caption = 'Is Sacco Deduction';
                }
                field("Loan Product"; Rec."Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group") { ApplicationArea = Basic; }
            }
        }
    }

    actions
    {
    }
}
