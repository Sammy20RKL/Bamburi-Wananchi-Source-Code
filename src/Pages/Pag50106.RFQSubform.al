#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50106 "RFQ Subform"
{
    PageType = ListPart;
    SourceTable = "Purchase Quote Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Expense Code"; Rec."Expense Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("PRF No"; Rec."PRF No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Specification")
            {
                ApplicationArea = Basic;
                Caption = 'Set Specification';

                trigger OnAction()
                var
                    PParams: Record 51106;
                begin
                    PParams.Reset;
                    PParams.SetRange(PParams."Document Type", Rec."Document Type");
                    PParams.SetRange(PParams."Document No.", Rec."Document No.");
                    PParams.SetRange(PParams."Line No.", Rec."Line No.");
                    Page.Run(51516780, PParams);
                end;
            }
        }
    }
}

