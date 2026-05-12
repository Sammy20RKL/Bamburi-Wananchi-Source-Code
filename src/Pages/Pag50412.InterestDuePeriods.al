#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50412 "Interest Due Periods"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Interest Due Period";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interest Due Date"; Rec."Interest Due Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Date Locked"; Rec."Date Locked")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closed by User"; Rec."Closed by User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closing Date Time"; Rec."Closing Date Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Calcuation Date"; Rec."Interest Calcuation Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            separator(Action15)
            {
            }
            action("Create Period")
            {
                ApplicationArea = Basic;
                Image = AccountingPeriods;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //InterestPeriod.RESET;
                    //InterestPeriod.SETRANGE(BOSARcpt."Transaction No.","Transaction No.");
                    //IF InterestPeriod.FIND('-') THEN
                    Report.Run(51516501)
                end;
            }
        }
    }

    var
        InvtPeriod: Record "Inventory Period";
        date: DateFormula;
        InterestPeriod: Record "Interest Due Period";
}

