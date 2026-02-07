Page 50089 "Loans Sub-Page List Disburse"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Loans Register";
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }

                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                // field("Net Amount"; "Net Amount")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Style = Ambiguous;
                // }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Monthly Repayment';
                    Style = StrongAccent;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Style = Strong;

                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    editable = false;
                }




                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Installments';
                    Editable = false;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StandardAccent;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }


                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic;
                }



            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin


    end;

    trigger OnOpenPage()
    begin

    end;

    var
        LoanType: Record "Loan Products Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        LoansReg: Record "Loans Register";



}

