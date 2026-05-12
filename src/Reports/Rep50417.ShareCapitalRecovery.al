Report 50417 "Share Capital Recovery"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    RDLCLayout = './Layouts/Share Capital Recovery.rdlc';

    dataset
    {
        dataitem("Member Register"; Customer)
        {
            DataItemTableView = sorting("No.") where("Customer Type" = const(Member));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Date Filter";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(S_No; RNo)
            {
            }
            column(No; "Member Register"."No.")
            {
            }
            column(Name; "Member Register".Name)
            {
            }
            column(Shares_Retained; "Member Register"."Shares Retained")
            {
            }
            column(Current_Shares; "Member Register"."Current Shares")
            {
            }

            trigger OnAfterGetRecord()
            begin

                "Member Register".CalcFields("Member Register"."Shares Retained", "Member Register"."Current Shares");

                DepositsAvailable := "Member Register"."Current Shares";//ABS("Member Register"."Current Shares");
                NetPayable := "Member Register"."Shares Retained";//ABS("Member Register"."Shares Retained");
                ReqAmt := 0;
                GSetup.Get();

                //Recover Share Capital from Deposits if Less than Minimum of 5000
                if NetPayable < GSetup."Retained Shares" then begin
                    if DepositsAvailable > 0 then begin

                        ReqAmt := GSetup."Retained Shares" - NetPayable;

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'SHARECAP';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        GenJournalLine."Account No." := "Member Register"."No.";
                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := 'MINIMUMSHARECAPRECOV';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Minimum Share Capital Recovered from Deposits';
                        if DepositsAvailable > ReqAmt then begin
                            GenJournalLine.Amount := -ReqAmt
                        end else
                            GenJournalLine.Amount := -DepositsAvailable;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        GenJournalLine."Shortcut Dimension 2 Code" := 'HQ';
                        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'SHARECAP';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        GenJournalLine."Account No." := "Member Register"."No.";
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := 'MINIMUMSHARECAPRECOV';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Amount := ReqAmt;
                        GenJournalLine.Description := 'Minimum Share Capital Recovered from Deposits';
                        if DepositsAvailable > ReqAmt then begin
                            GenJournalLine.Amount := ReqAmt
                        end else
                            GenJournalLine.Amount := DepositsAvailable;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        GenJournalLine."Shortcut Dimension 2 Code" := 'HQ';
                        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin

                //Post New
                // GenJournalLine.RESET;
                // GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                // GenJournalLine.SETRANGE("Journal Batch Name", 'SHARECAP');
                // IF GenJournalLine.FIND('-') THEN BEGIN
                //     CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJournalLine);
                // END;
                // //Post New

                Message('Process Complete');

            end;

            trigger OnPreDataItem()
            begin

                /*
                Temp.GET(USERID);
                Jtemplate:=Temp."Receipt Journal Template";
                JBatch:=Temp."Receipt Journal Batch";
                
                IF Jtemplate = '' THEN BEGIN
                ERROR('Ensure The Receipt Journal Template is set up in csh office set up ')
                END;
                IF JBatch = '' THEN BEGIN
                ERROR('Ensure The Receipt Journal Batch is set up in csh office set up ')
                END;
                */

                //delete journal line
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'SHARECAP');
                GenJournalLine.DeleteAll;
                //end of deletion

                if Confirm('Are you sure you want to Recover the Minimum Share Capital from Member Deposits?', true) = false then
                    exit;

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'SHARECAP');
                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'SHARECAP';
                    GenBatches.Description := 'MINIMUM SHARE CAPITAL RECOVERY FROM DEPOSITS';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        RNo: Integer;
        Company: Record "Company Information";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Gen. Journal Line": Codeunit "Gen. Jnl.-Post Line";
        DepositsAvailable: Decimal;
        NetPayable: Decimal;
        TotalRecovered: Decimal;
        ReqAmt: Decimal;
        Jtemplate: Code[30];
        JBatch: Code[30];
        GSetup: Record "Sacco General Set-Up";
        cust: Record Customer;
}

