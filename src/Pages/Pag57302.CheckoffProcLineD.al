#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 57302 "Checkoff Proc Line-D"
{
    PageType = ListPart;
    SourceTable = "CheckoffLinesDistributed Nav";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Header No"; Rec."Receipt Header No")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("DEVELOPMENT LOAN Amount_25"; Rec."DEVELOPMENT LOAN Amount")
                {
                    ApplicationArea = Basic;
                }
                field("DEVELOPMENT LOAN Principal_ 25"; Rec."DEVELOPMENT LOAN Principal")
                {
                    ApplicationArea = Basic;
                }
                field("DEVELOPMENT LOAN Int_25"; Rec."DEVELOPMENT LOAN Int")
                {
                    ApplicationArea = Basic;
                }
                field("DEVELOPMENT LOAN No_25"; Rec."DEVELOPMENT LOAN No")
                {
                    ApplicationArea = Basic;
                }
                field("DEVELOPMENT LOAN 1 Amount_23"; Rec."DEVELOPMENT LOAN 1 Amount")
                {
                    ApplicationArea = Basic;
                }
                field("<DEVELOPMENT LOAN 1 Principal_23"; Rec."DEVELOPMENT LOAN 1 Principal")
                {
                    ApplicationArea = Basic;
                }
                field("<DEVELOPMENT LOAN 1  Int_23"; Rec."DEVELOPMENT LOAN 1  Int")
                {
                    ApplicationArea = Basic;
                }
                field("<DEVELOPMENT LOAN 1  No_23"; Rec."DEVELOPMENT LOAN 1  No")
                {
                    ApplicationArea = Basic;
                }
                field("<EMERGENCY LOAN Amount_12"; Rec."EMERGENCY LOAN Amount")
                {
                    ApplicationArea = Basic;
                }
                field("<EMERGENCY LOAN Principal_12"; Rec."EMERGENCY LOAN Principal")
                {
                    ApplicationArea = Basic;
                }
                field("<EMERGENCY LOAN Int_12"; Rec."EMERGENCY LOAN Int")
                {
                    ApplicationArea = Basic;
                }
                field("<EMERGENCY LOAN No-12"; Rec."EMERGENCY LOAN No")
                {
                    ApplicationArea = Basic;
                }
                field("<SCHOOL FEES LOAN Amount_17"; Rec."SCHOOL FEES LOAN Amount")
                {
                    ApplicationArea = Basic;
                }
                field("<SCHOOL FEES LOAN Principal_17"; Rec."SCHOOL FEES LOAN Principal")
                {
                    ApplicationArea = Basic;
                }
                field("<SCHOOL FEES LOAN Int_17"; Rec."SCHOOL FEES LOAN Int")
                {
                    ApplicationArea = Basic;
                }
                field("<SCHOOL FEES LOAN No_17"; Rec."SCHOOL FEES LOAN No")
                {
                    ApplicationArea = Basic;
                }
                field("<Super Emergency Amount_13"; Rec."Super Emergency Amount")
                {
                    ApplicationArea = Basic;
                }
                field("<Super Emergency Principal_13"; Rec."Super Emergency Principal")
                {
                    ApplicationArea = Basic;
                }
                field("<Super Emergency Int_13"; Rec."Super Emergency Int")
                {
                    ApplicationArea = Basic;
                }
                field("<Super Emergency Loan No_13"; Rec."Super Emergency Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("<Super Quick Amount_16"; Rec."Super Quick Amount")
                {
                    ApplicationArea = Basic;
                }
                field("<Super Quick Principal_16"; Rec."Super Quick Principal")
                {
                    ApplicationArea = Basic;
                }
                field("<Super Quick Int_16"; Rec."Super Quick Int")
                {
                    ApplicationArea = Basic;
                }
                field("<Super Quick Loan No_16"; Rec."Super Quick Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("<Quick Loan Amount_15"; Rec."Quick Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("<Quick Loan Principal_15"; Rec."Quick Loan Principal")
                {
                    ApplicationArea = Basic;
                }
                field("<Quick Loan Int-15"; Rec."Quick Loan Int")
                {
                    ApplicationArea = Basic;
                }
                field("<Quick Loan No_15"; Rec."Quick Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("<Super School Fees Amount_18"; Rec."Super School Fees Amount")
                {
                    ApplicationArea = Basic;
                }
                field("<Super School Fees Principal_18"; Rec."Super School Fees Principal")
                {
                    ApplicationArea = Basic;
                }
                field("<Super School Fees Int_18"; Rec."Super School Fees Int")
                {
                    ApplicationArea = Basic;
                }
                field("<Super School Fees Loan No_18"; Rec."Super School Fees Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("<Investment  Amount_19"; Rec."Investment  Amount")
                {
                    ApplicationArea = Basic;
                }
                field("<Investment  Principal_19"; Rec."Investment  Principal")
                {
                    ApplicationArea = Basic;
                }
                field("<Investment  Int_19"; Rec."Investment  Int")
                {
                    ApplicationArea = Basic;
                }
                field("<Investment Loan No_19"; Rec."Investment Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Contribution"; Rec."Deposit Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Fee"; Rec."Insurance Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Benevolent Fund"; Rec."Benevolent Fund")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Normal Amount 20"; Rec."Normal Amount 20")
                {
                    ApplicationArea = Basic;
                }
                field("Normal Pri (20)"; Rec."Normal Pri (20)")
                {
                    ApplicationArea = Basic;
                }
                field("Normal Int (20)"; Rec."Normal Int (20)")
                {
                    ApplicationArea = Basic;
                }
                field("Normal Loan No.(20)"; Rec."Normal Loan No.(20)")
                {
                    ApplicationArea = Basic;
                }
                field("<Normal Loan Amount_21"; Rec."Normal Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("<Normal Loan Principal_21"; Rec."Normal Loan Principal")
                {
                    ApplicationArea = Basic;
                }
                field("<Normal Loan Int_21"; Rec."Normal Loan Int")
                {
                    ApplicationArea = Basic;
                }
                field("<NORMAL LOAN NO_21"; Rec."NORMAL LOAN NO")
                {
                    ApplicationArea = Basic;
                    Caption = 'Normal Loan No';
                }
                field("<Normal Loan 1 Amount_22"; Rec."Normal Loan 1 Amount")
                {
                    ApplicationArea = Basic;
                }
                field("<Normal Loan 1 Principal_22"; Rec."Normal Loan 1 Principal")
                {
                    ApplicationArea = Basic;
                }
                field("<NORMAL LOAN 1 NO_22"; Rec."NORMAL LOAN 1 NO")
                {
                    ApplicationArea = Basic;
                    Caption = 'Normal Loan 1 Loan No';
                }
                field("Holiday savings"; Rec."Holiday savings")
                {
                    ApplicationArea = Basic;
                }
                field("MERCHANDISE Loan No"; Rec."MERCHANDISE Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("MERCHANDISE Amount"; Rec."MERCHANDISE Amount")
                {
                    ApplicationArea = Basic;
                }
                field("MERCHANDISE Pri"; Rec."MERCHANDISE Pri")
                {
                    ApplicationArea = Basic;
                }
                field("MERCHANDISE Int"; Rec."MERCHANDISE Int")
                {
                    ApplicationArea = Basic;
                }
                field("Welfare contribution"; Rec."Welfare contribution")
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

