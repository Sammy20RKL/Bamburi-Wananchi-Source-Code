#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56142 "Over draft Application Card-P"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Over Draft Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Over Draft No"; Rec."Over Draft No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Application date"; Rec."Application date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Overdraft Repayment Start Date"; Rec."Overdraft Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Overdraft Repayment Completion"; Rec."Overdraft Repayment Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured by"; Rec."Captured by")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Current Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Draft Per OD"; Rec."Outstanding Draft Per OD")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Draft';
                    Editable = false;
                }
                field("Outstanding Overdraft"; Rec."Outstanding Overdraft")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Outstanding Overdraft';
                    Editable = false;
                }
                field("Oustanding Overdraft Interest"; Rec."Oustanding Overdraft Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount applied"; Rec."Amount applied")
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft period(Months)"; Rec."Overdraft period(Months)")
                {
                    ApplicationArea = Basic;
                }
                field("Override Interest Rate"; Rec."Override Interest Rate")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        EditableField := false;
                        if Rec."Override Interest Rate" then
                            EditableField := true;
                    end;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field("Monthly Overdraft Repayment"; Rec."Monthly Overdraft Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Interest Repayment"; Rec."Monthly Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Interest Charged"; Rec."Total Interest Charged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Overdraft Status"; Rec."Overdraft Status")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Overdraft security"; Rec."Overdraft security")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Landvisible := false;
                        Motorvisible := false;
                        Salaryvisible := false;
                        if Rec."Overdraft security" = Rec."overdraft security"::"Motor Vehicle" then begin
                            Motorvisible := true;
                        end;
                        if Rec."Overdraft security" = Rec."overdraft security"::Land then begin
                            Landvisible := true;
                        end;
                        if Rec."Overdraft security" = Rec."overdraft security"::Salary then begin
                            Salaryvisible := true;
                        end;
                    end;
                }
                field("Running Overdraft"; Rec."Running Overdraft")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Salary)
            {
                Caption = 'Salary';
                Visible = Salaryvisible;
                field("Basic salary"; Rec."Basic salary")
                {
                    ApplicationArea = Basic;
                }
                field(Employer; Rec.Employer)
                {
                    ApplicationArea = Basic;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Terms Of Employment"; Rec."Terms Of Employment")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Motor Vehicle")
            {
                Caption = 'Motor Vehicle';
                Visible = Motorvisible;
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ApplicationArea = Basic;
                }
                field("Current Value"; Rec."Current Value")
                {
                    ApplicationArea = Basic;
                }
                field(Multpliers; Rec.Multpliers)
                {
                    ApplicationArea = Basic;
                }
                field("Amount to secure Overdraft"; Rec."Amount to secure Overdraft")
                {
                    ApplicationArea = Basic;
                }
                field(insured; Rec.insured)
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Land)
            {
                Caption = 'Land';
                Visible = Landvisible;
                field("Land deed No"; Rec."Land deed No")
                {
                    ApplicationArea = Basic;
                }
                field("Land acrage"; Rec."Land acrage")
                {
                    ApplicationArea = Basic;
                }
                field("Land location"; Rec."Land location")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Approved);
                    Cust.Reset;
                    Cust.SetRange(Cust."Account No", Rec."Account No");
                    Report.Run(50281, true, false, Cust);
                end;
            }
            action(Terminate)
            {
                ApplicationArea = Basic;
                Image = BreakRulesOn;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Over Draft No", Rec."Over Draft No");
                    if Cust.Find('-') then begin
                        Cust."Running Overdraft" := false;
                        Cust."Overdraft Status" := Cust."Overdraft Status";
                        Cust.Modify;
                    end
                end;
            }
        }
    }

    var
        Gnljnline: Record "Gen. Journal Line";
        LineN: Integer;
        vend: Record Vendor;
        overdraftno: Code[30];
        Cust: Record "Over Draft Register";
        LineNo: Integer;
        UserSetup: Record "User Setup";
        GenSetup: Record "Sacco General Set-Up";
        DValue: Record "Dimension Value";
        OverdraftBank: Code[10];
        GenJournalLine: Record "Gen. Journal Line";
        OverdraftAut: Record "Over Draft Authorisationx";
        LneNo: Integer;
        OVED: Record "Over Draft Register";
        Landvisible: Boolean;
        Salaryvisible: Boolean;
        Motorvisible: Boolean;
        SFactory: Codeunit "Swizzsoft Factory";
        EditableField: Boolean;
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        CommisionOnOverdraft: Decimal;

    local procedure PostOverdraft()
    var
        OverdraftAcc: Record "Over Draft Register";
        OVERBAL: Decimal;
        RemainAmount: Decimal;
        Overdraftbank: Code[10];
        dbanch: Code[50];
        balanceov: Decimal;
        vendoroverdraft: Record Vendor;
        BALRUN: Decimal;
        OVERDRAFTREC: Record Vendor;
        "overdraftcomm a/c": Code[10];
        vendor2: Record Vendor;
        commoverdraft: Decimal;
        overdraftSetup: Record "Overdraft Setup";
        currentbal: Decimal;
    begin
        BATCH_TEMPLATE := 'PURCHASES';
        BATCH_NAME := 'FTRANS';
        DOCUMENT_NO := Rec."Over Draft No";
        currentbal := 0;
        overdraftSetup.Get();

        vendoroverdraft.Reset;
        vendoroverdraft.SetRange(vendoroverdraft."No.", Rec."Account No");
        if vendoroverdraft.Find('-') then begin
            vendoroverdraft.CalcFields(vendoroverdraft.Balance);
            currentbal := vendoroverdraft.Balance;
        end;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        CommisionOnOverdraft := overdraftSetup."Overdraft Commision Charged";
        LineNo := 0;
        //1.----------------------DEDIT FOSA A/C(Commission on Overdraft)--------------------------------------------------------------------------------------------
        if currentbal >= CommisionOnOverdraft then begin
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
            Rec."Account No", Today, ROUND(CommisionOnOverdraft, 0.05, '>'), 'FOSA', 'OV' + Rec."Account No", Rec."Account No" + ' Commission on Overdraft', '',
            GenJournalLine."account type"::"G/L Account", overdraftSetup."Commission A/c");
            Rec."commission charged" := true;
        end;
        //2.----------------------CREDIT INCOME G/L(Interest on Overdraft)--------------------------------------------------------------------------------------------
        if currentbal >= (CommisionOnOverdraft + (Rec."Interest Rate" * Rec."Approved Amount") / 100) then begin
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalancedCashier(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
            Rec."Account No", Today, (Rec."Interest Rate" * Rec."Approved Amount") / 100, 'FOSA', 'OV' + Rec."Account No", Rec."Account No" + ' Overdraft Int Charged', '',
            GenJournalLine."account type"::"G/L Account", overdraftSetup."Interest Income A/c", DOCUMENT_NO, GenJournalLine."overdraft codes"::"Interest Accrued");
            Rec."Interest Charged" := true;
        end;
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);
        Rec.Modify;
        Message('Overdraft succesfully processed.');
    end;
}

