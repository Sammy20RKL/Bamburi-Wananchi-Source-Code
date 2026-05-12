#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50388 "Loan Collateral Security"
{
    PageType = ListPart;
    SourceTable = "Loan Collateral Details";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Registe Doc"; Rec."Collateral Registe Doc")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner"; Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Security Details"; Rec."Security Details")
                {
                    ApplicationArea = Basic;
                }
                field("Motor Vehicle Registration No"; Rec."Motor Vehicle Registration No")
                {
                    ApplicationArea = Basic;
                }
                field("Title Deed No."; Rec."Title Deed No.")
                {
                    ApplicationArea = Basic;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = Basic;
                }
                field("Comitted Collateral Value"; Rec."Comitted Collateral Value")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic;
                }
                field("Guarantee Value"; Rec."Guarantee Value")
                {
                    ApplicationArea = Basic;
                }
                field("View Document"; Rec."View Document")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Multiplier"; Rec."Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Collateral Fee"; Rec."Loan Collateral Fee")
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

