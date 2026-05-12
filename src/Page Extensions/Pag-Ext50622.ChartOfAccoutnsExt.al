pageextension 50622 "ChartOfAccoutnsExt" extends "Chart of Accounts"
{

    layout
    {
        addafter(Balance)
        {

            field("Budgeted Amount"; Rec."Budgeted Amount")
            {
                ApplicationArea = Basic;
                Editable = false;
                visible = false;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    CalcFormFields;
                    BudgetedAmountOnAfterValidate;
                end;
            }

            // field("Budget Controlled"; "Budget Controlled")
            // {
            //     ApplicationArea = Basic;
            //     Editable = false;

            // }
            field(BudgetPct; BudgetPct)
            {
                ApplicationArea = Basic;
                Editable = false;
                visible = false;
                Caption = 'Budget variance';
                trigger OnValidate()
                begin
                    CalcFormFields();
                    BudgetedAmountOnAfterValidate();
                end;
            }
            field(Favour; Favour)
            {
                ApplicationArea = Basic;
                Editable = false;
                visible = false;
                Caption = 'Budget variance Indication';
                StyleExpr = StyleExprTxt;
            }


        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                GLEntry.SetRange("G/L Account No.", Rec."No.");
                if GLEntry.FindSet() then begin
                    Enable := false;
                end;
            end;
        }
        modify(Name)
        {
            Editable = Enable;
        }
        modify("Account Subcategory Descript.")
        {
            Visible = false;

        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Cost Type No.")
        {
            Visible = false;
        }

        modify(Control1900383207)
        {
            Visible = false;
        }
        modify(Control1905767507)
        {
            Visible = false;
        }

    }
    trigger OnOpenPage()


    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Accessed and read the chart of accounts listing page');
        GLEntry.Reset();


    end;

    trigger OnAfterGetRecord()
    begin

        CalcFormFields();

    end;

    local procedure BudgetedAmountOnAfterValidate()
    begin
        CurrPage.Update();
    end;

    local procedure CalcFormFields()
    begin

        Rec.CalcFields("Net Change", "Budgeted Amount");
        if Rec."Net Change" >= 0 then begin
            Rec."Debit Amount" := Rec."Net Change";
            Rec."Credit Amount" := 0;
        end else begin
            Rec."Debit Amount" := 0;
            Rec."Credit Amount" := -Rec."Net Change";
        end;
        if Rec."Budgeted Amount" >= 0 then begin
            Rec."Budgeted Debit Amount" := Rec."Budgeted Amount";
            Rec."Budgeted Credit Amount" := 0;
        end else begin
            Rec."Budgeted Debit Amount" := 0;
            Rec."Budgeted Credit Amount" := -Rec."Budgeted Amount";
        end;
        if rec."Account Type" = Rec."Account Type"::"Begin-Total"
        then
            Favour := Favour::" " else
            if Rec."Budgeted Amount" = 0 then begin
                BudgetPct := 0;
                Favour := Favour::"Not-Budgeted";
                StyleExprTxt := 'StandardAccent'
            end
            else
                BudgetPct := Abs(Rec."Net Change" / Rec."Budgeted Amount" * 100);

        if BudgetPct > 100 then begin
            Favour := Favour::"Non-Favourable";
            StyleExprTxt := 'Unfavorable';
        end
        else if (BudgetPct < 100) and (Rec."Budgeted Amount" > 0) then begin
            Favour := Favour::Favourable;
            StyleExprTxt := 'favorable'
        end;


    end;

    trigger OnClosePage()
    begin
        AuditLog.FnReadingsMadeAudit(UserId, 'Closed chart of accounts listing page');
    end;

    var

        GLEntry: Record "G/L Entry";
        AuditLog: Codeunit "Audit Log Codeunit";
        Enable: Boolean;
        StyleExprTxt: Text;
        Text000: Label 'Not Editable';
        BudgetPct: Decimal;
        Favour: Option " ","Not-Budgeted",Favourable,"Non-Favourable";

}