#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50390 "Loans Sub-Page List"
{
    // CardPageID = "Loans Reschedule Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
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
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Principle Outstanding Balance';
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Interest Due"; Rec."Interest Due")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Paid"; Rec."Interest Paid")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Oustanding Interest"; Rec."Oustanding Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Interest';
                }
                field("Loan Insurance Charged"; Rec."Loan Insurance Charged")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Charged';
                    Editable = false;
                }
                field("Loan Insurance Paid"; Rec."Loan Insurance Paid")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Paid';
                    Editable = false;
                }
                field("Outstanding Insurance"; Rec."Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Penalty Charged"; Rec."Penalty Charged")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Paid"; Rec."Penalty Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Current Payoff Amount"; Rec."Loan Current Payoff Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(VarAmountinArrears; VarAmountinArrears)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Amount in Arrears';
                    Editable = false;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loans Category"; Rec."Loans Category")
                {
                    ApplicationArea = Basic;
                }
                field("Loans Category-SASRA"; Rec."Loans Category-SASRA")
                {
                    ApplicationArea = Basic;
                }
                field("No. Of Guarantors"; Rec."No. Of Guarantors")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                }
                field("Loan Due"; Rec."Loan Due")
                {
                    ApplicationArea = Basic;
                }
                field("Partial Disbursed(Amount Due)"; Rec."Partial Disbursed(Amount Due)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan  Cash Cleared"; Rec."Loan  Cash Cleared")
                {
                    ApplicationArea = Basic;
                }
                field("Total Topup Amount"; Rec."Total Topup Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        InterestDue := SFactory.FnGetInterestDueTodate(Rec);
        OutstandingInterest := SFactory.FnGetInterestDueTodate(Rec) - Rec."Interest Paid";
    end;

    trigger OnAfterGetRecord()
    begin
        // ObjLoans.RESET;
        // ObjLoans.SETRANGE(ObjLoans."Loan  No.","Loan  No.");
        // IF ObjLoans.FINDSET THEN BEGIN
        //  ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance","Oustanding Interest","Outstanding Insurance","Outstanding Penalty");
        //
        //    VarEndYear:=CALCDATE('CY',TODAY);
        //    VarInsuranceMonths:=ROUND((VarEndYear-TODAY)/30,1,'=');
        //
        //    ObjProductCharge.RESET;
        //    ObjProductCharge.SETRANGE(ObjProductCharge."Product Code","Loan Product Type");
        //    ObjProductCharge.SETRANGE(ObjProductCharge."Loan Charge Type",ObjProductCharge."Loan Charge Type"::"Loan Insurance");
        //    IF ObjProductCharge.FINDSET THEN BEGIN
        //        VarInsurancePayoff:=ROUND(("Approved Amount"*(ObjProductCharge.Percentage/100))*VarInsuranceMonths,0.05,'>');
        //      END;
        //  VarLoanPayoffAmount:="Outstanding Balance"+"Oustanding Interest"+"Outstanding Insurance"+"Outstanding Penalty"+VarInsurancePayoff;
        //  ObjLoans."Loan Current Payoff Amount":=VarLoanPayoffAmount;
        //  ObjLoans.MODIFY;
        //  END;
        //
        // VarAmountinArrears:=0;
        // //Get Arrears
        // ObjRepaymentSchedule.RESET;
        // ObjRepaymentSchedule.SETRANGE(ObjRepaymentSchedule."Loan No.","Loan  No.");
        // IF ObjRepaymentSchedule.FINDSET=TRUE THEN
        //  BEGIN
        //    IF ("Outstanding Balance">0) AND (Repayment<>0) THEN
        //      BEGIN
        //        VarAmountinArrears:=SFactory.FnGetLoanAmountinArrears("Loan  No.");
        //        END;
        //    END;
    end;

    var
        LoanType: Record "Loan Products Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        FieldStyle: Text;
        FieldStyleI: Text;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "Swizzsoft Factory.";
        ObjLoans: Record "Loans Register";
        VarLoanPayoffAmount: Decimal;
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20]; var MemberNo: Code[20])
    begin
        LoanNo := Rec."Loan  No.";
        LoanProductType := Rec."Loan Product Type";
        MemberNo := Rec."Client Code";
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        Rec.CalcFields("Outstanding Balance", "Oustanding Interest");
        if (Rec."Outstanding Balance" < 0) then
            FieldStyle := 'Attention';

        if (Rec."Oustanding Interest" < 0) then
            FieldStyleI := 'Attention';
    end;
}

