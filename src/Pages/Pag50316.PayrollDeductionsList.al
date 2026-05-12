#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50316 "Payroll Deductions List."
{
    CardPageID = "HR Leave Types Card";
    PageType = List;
    SourceTable = "Payroll Transaction Code.";
    SourceTableView = where("Transaction Type" = const(Deduction));

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
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."transaction type"::Deduction;
    end;
}

