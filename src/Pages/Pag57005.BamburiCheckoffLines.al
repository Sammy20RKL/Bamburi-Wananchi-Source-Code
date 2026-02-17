
page 57005 "Bamburi CheckoffLines"
{
    ApplicationArea = All;
    Caption = 'Bamburi CheckoffLines';
    PageType = ListPart;
    SourceTable = "Bamburi CheckoffLines";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Receipt Line No"; Rec."Receipt Line No")
                {
                    Visible = false;
                }
                field("Entry No"; Rec."Entry No")
                {
                    Editable = false;
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Found"; Rec."Member Found")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital"; Rec."Share Capital") { ApplicationArea = Basic; }
                field("Deposit Contribution"; Rec."Deposit Contribution") { ApplicationArea = Basic; }
                field(Benevolent; Rec.Benevolent) { ApplicationArea = Basic; Visible = false; }
                field(Insurance; Rec.Insurance) { ApplicationArea = Basic; }
                field(Registration; Rec.Registration) { ApplicationArea = Basic; }
                field(Holiday; Rec.Holiday) { ApplicationArea = Basic; }
                field("Emergency Loan Amount"; Rec."Emergency Loan Amount") { ApplicationArea = Basic; }
                field("Emergency Loan  Principle"; Rec."Emergency Loan  Principle") { ApplicationArea = Basic; }
                field("Emergency Loan Interest"; Rec."Emergency Loan Interest") { ApplicationArea = Basic; }
                field("Kivukio Loan Amount"; Rec."Kivukio Loan Amount") { ApplicationArea = Basic; }
                field("Kivukio Loan Principle"; Rec."Kivukio Loan Principle") { ApplicationArea = Basic; }
                field("Kivukio Loan Interest"; Rec."Kivukio Loan Interest") { ApplicationArea = Basic; }
                field("Mwokozi Loan Amount"; Rec."Mwokozi Loan Amount") { ApplicationArea = Basic; }
                field("Mwokozi Loan Principle"; Rec."Mwokozi Loan Principle") { ApplicationArea = Basic; }
                field("Mwokozi Loan Interest"; Rec."Mwokozi Loan Interest") { ApplicationArea = Basic; }
                field("School Fees Amount"; Rec."School Fees Amount") { ApplicationArea = Basic; }
                field("School Fees Principle"; Rec."School Fees Principle") { ApplicationArea = Basic; }
                field("School Fees Interest"; Rec."School Fees Interest") { ApplicationArea = Basic; }
                field("New Product Loan Amount"; Rec."New Product Loan Amount") { ApplicationArea = Basic; }
                field("New Product Loan Principle"; Rec."New Product Loan Principle") { ApplicationArea = Basic; }
                field("New Product Loan Interest"; Rec."New Product Loan Interest") { ApplicationArea = Basic; }
                field("HALLO HALLO Loan Amount"; Rec."HALLO HALLO Loan Amount") { ApplicationArea = Basic; }
                field("HALLO HALLO Loan Principle"; Rec."HALLO HALLO Loan Principle") { ApplicationArea = Basic; }
                field("HALLO HALLO Loan Interest"; Rec."HALLO HALLO Loan Interest") { ApplicationArea = Basic; }
                field("Instant Loan Amount"; Rec."Instant Loan Amount") { ApplicationArea = Basic; }
                field("Instant Loan Principle"; Rec."Instant Loan Principle") { ApplicationArea = Basic; }
                field("Instant Loan Interest"; Rec."Instant Loan Interest") { ApplicationArea = Basic; }
                field("Normal Loan 1 Amount"; Rec."Normal Loan 1 Amount") { ApplicationArea = Basic; }
                field("Normal Loan 1 Principle"; Rec."Normal Loan 1 Principle") { ApplicationArea = Basic; }
                field("Normal Loan 1 Interest"; Rec."Normal Loan 1 Interest") { ApplicationArea = Basic; }
                field("Normal Loan 2 Amount"; Rec."Normal Loan 2 Amount") { ApplicationArea = Basic; }
                field("Normal Loan 2 Principle"; Rec."Normal Loan 2 Principle") { ApplicationArea = Basic; }
                field("Normal Loan 2 Interest"; Rec."Normal Loan 2 Interest") { ApplicationArea = Basic; }
                //field("Normal Loan 3 Amount"; Rec."Normal Loan 3 Amount") { ApplicationArea = Basic; }
                //field("Normal Loan 3 Principle"; Rec."Normal Loan 3 Principle") { ApplicationArea = Basic; }
                //field("Normal Loan 3 Interest"; Rec."Normal Loan 3 Interest") { ApplicationArea = Basic; }
                field("Mbuyu Loan Amount"; Rec."Mbuyu Loan Amount") { ApplicationArea = Basic; }
                field("Mbuyu Loan Principle"; Rec."Mbuyu Loan Principle") { ApplicationArea = Basic; }
                field("Mbuyu Loan Interest"; Rec."Mbuyu Loan Interest") { ApplicationArea = Basic; }
                // field("Normal loan 4 Amount"; Rec."Normal loan 4 Amount") { ApplicationArea = Basic; }
                // field("Normal loan 4 Principle"; Rec."Normal loan 4 Principle") { ApplicationArea = Basic; }
                // field("Normal loan 4 Interest"; Rec."Normal loan 4 Interest") { ApplicationArea = Basic; }

                field("Total Loans"; Rec."Total Loans") { ApplicationArea = Basic; }
                field("Grand Total"; Rec."Grand Total") { ApplicationArea = Basic; }

            }
        }
    }
}
