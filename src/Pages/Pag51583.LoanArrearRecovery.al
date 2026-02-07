page 51583 LoanArrearRecovery
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Loan Arrears To Offset';
    SourceTable = "Loan Arrears Selection Buffer";
    // SourceTableTemporary = true;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                // field(MarkedForArrearRecovery; Rec."Arrear Recovery Status")
                // {

                //     ApplicationArea = All;
                //     Editable = true;
                //     Caption = 'Recovery Status';
                //     ToolTip = 'Check this box to mark for arrears recovery.';

                // }

                field("Selected For Offset"; Rec."Selected")
                {
                    ApplicationArea = All;
                    Caption = 'Select For Offset';
                }

                field("Loan No."; Rec."Source Loan No.")
                {

                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Client involved in the arrears recovery.';
                    Editable = false;
                }

                field("Loan No"; Rec."Loan No.")
                {

                    ApplicationArea = All;
                    Editable = false;
                }

                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of the loan from which arrears will be recovered.';
                    Editable = false;
                }

                field("Principle Amount"; Rec."Principal Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = All;
                    Editable = true;

                }



                field("Total Arrears"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Amt in Arrears';
                    StyleExpr = 'Unfavorable';
                }


                // field("Total Top Up"; Rec."Total Top Up")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Total amount to be recovered.';
                // }
            }

        }
    }


    actions
    {
        area(Processing)
        {
            action(ConfirmSelection)
            {
                ApplicationArea = All;
                Caption = 'Confirm Selection';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Confirm;

                trigger OnAction()
                begin
                    ProcessSelectedLoans();
                    CurrPage.Close();
                end;
            }
        }

    }


    local procedure ProcessSelectedLoans()
    var
        ObjLoanOffsets: Record "Loan Offset Details";
        LoanBuffer: Record "Loan Arrears Selection Buffer";
    begin
        // Process only selected loans
        LoanBuffer.Copy(Rec);
        LoanBuffer.SetRange(Selected, true);

        if LoanBuffer.FindSet() then begin
            repeat
                // Insert into Loan Offset Details table
                ObjLoanOffsets.Reset();
                ObjLoanOffsets.SetRange("Client Code", LoanBuffer."Client Code");
                ObjLoanOffsets.SetRange("Loan Top Up", LoanBuffer."Loan No.");

                if not ObjLoanOffsets.FindFirst() then begin
                    ObjLoanOffsets.Init();
                    ObjLoanOffsets."Arrear Recovery Status" := 1;
                    ObjLoanOffsets."Loan No." := LoanBuffer."Source Loan No.";
                    ObjLoanOffsets."Client Code" := LoanBuffer."Client Code";
                    ObjLoanOffsets."Loan Top Up" := LoanBuffer."Loan No.";
                    ObjLoanOffsets."Loan Type" := LoanBuffer."Loan Type";
                    ObjLoanOffsets."Principle Top Up" := LoanBuffer."Principal Amount";
                    ObjLoanOffsets."Interest Top Up" := LoanBuffer."Interest Amount";
                    ObjLoanOffsets."Total Top Up" := LoanBuffer."Total Amount";
                    ObjLoanOffsets."LoanArrears" := LoanBuffer."Total Amount";
                    ObjLoanOffsets.Insert();
                end;
            until LoanBuffer.Next = 0;
        end;
    end;

}
