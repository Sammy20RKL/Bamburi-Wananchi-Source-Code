#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50597 "Share Boosting Card"
{
    PageType = Card;
    SourceTable = "Loan PayOff";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FOSA Account No"; Rec."FOSA Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requested PayOff Amount"; Rec."Requested PayOff Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Requested Boosting Amount';
                }
                field("Approved PayOff Amount"; Rec."Approved PayOff Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Boosting Amount';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
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
            action("Post Share Boosting")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if Confirm('Are You Sure you Want to Post this Share Boosting?', false) = true then begin


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'PAYOFF');
                        if GenJournalLine.Find('-') then begin
                            GenJournalLine.DeleteAll;
                        end;



                        GenJournalLine.Init;
                        LineNo := LineNo + 10000;
                        //Principle
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'PAYOFF';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := Rec."Document No";
                        GenJournalLine."Posting Date" := Today;
                        //GenJournalLine."External Document No.":=MultipleCheque."Cheque No";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        GenJournalLine."Account No." := Rec."Member No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                        GenJournalLine.Description := 'Share Boosting- ' + '-' + Rec."Document No";
                        GenJournalLine.Amount := Rec."Approved PayOff Amount" * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //GenJournalLine."Loan No":=PayOffDetails."Loan to PayOff";
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                        //GenJournalLine."Bal. Account No.":="FOSA Account No";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        Message('sdfghjk');
                        GenJournalLine.Init;
                        LineNo := LineNo + 10000;
                        //Principle
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'PAYOFF';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := Rec."Document No";
                        GenJournalLine."Posting Date" := Today;
                        //GenJournalLine."External Document No.":=MultipleCheque."Cheque No";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."FOSA Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
                        GenJournalLine.Description := 'Share Boosting- ' + '-' + Rec."Document No";
                        GenJournalLine.Amount := Rec."Approved PayOff Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        ///GenJournalLine."Loan No":=PayOffDetails."Loan to PayOff";
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                        //GenJournalLine."Bal. Account No.":="FOSA Account No";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        GenSetup.Get();
                        //Comission
                        GenJournalLine.Init;
                        LineNo := LineNo + 10000;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'PAYOFF';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := Rec."Document No";
                        GenJournalLine."Posting Date" := Today;
                        //GenJournalLine."External Document No.":=MultipleCheque."Cheque No";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := LoanType."Loan PayOff Fee Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                        GenJournalLine.Description := 'Share Boosting Fee- ' + '-' + Rec."Document No";
                        GenJournalLine.Amount := Rec."Approved PayOff Amount" * (GenSetup."Boosting Shares %" / 100) * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Loan No" := PayOffDetails."Loan to PayOff";
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                        //GenJournalLine."Bal. Account No.":="FOSA Account No";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        GenJournalLine.Init;
                        LineNo := LineNo + 10000;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'PAYOFF';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := Rec."Document No";
                        GenJournalLine."Posting Date" := Today;
                        //GenJournalLine."External Document No.":=MultipleCheque."Cheque No";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."FOSA Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                        GenJournalLine.Description := 'Share Boosting Fee- ' + '-' + Rec."Document No";
                        GenJournalLine.Amount := Rec."Approved PayOff Amount" * (GenSetup."Boosting Shares %" / 100);
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //GenJournalLine."Loan No":=PayOffDetails."Loan to PayOff";
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                        //GenJournalLine."Bal. Account No.":="FOSA Account No";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;


                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                    GenJournalLine.SetRange("Journal Batch Name", 'PayOff');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;
                    Rec.Posted := true;
                    Rec."Posting Date" := Today;
                    Rec."Posted By" := UserId;
                    Rec.Modify;
                    //Post New

                    Message('Share Boosting Posted Succesfuly');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total PayOut Amount");
        Rec."Requested PayOff Amount" := Rec."Total PayOut Amount";
        Rec."Approved PayOff Amount" := Rec."Total PayOut Amount";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created By" := UserId;
        rec."Application Date" := Today;
    end;

    var
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        GenSetup: Record "Sacco General Set-Up";
}

