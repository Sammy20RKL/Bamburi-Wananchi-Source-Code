#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51035 "Members Loans Guarantors"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Members Loans Guarantors.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", Name;
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(No_Members; Customer."No.")
            {
            }
            column(Name_Members; Customer.Name)
            {
            }
            column(PhoneNo_Members; Customer."Phone No.")
            {
            }
            column(OutstandingBalance_Members; Customer."Outstanding Balance")
            {
            }
            column(FNo; FNo)
            {
            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Loanees  No" = field("No."), "Loan No" = field("Loan No. Filter");
                DataItemTableView = where("Outstanding Balance" = filter(> 0), Substituted = filter(false));
                RequestFilterFields = "Member No", "Loan No";
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(AmontGuaranteed_LoanGuarantors; "Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                column(NoOfLoansGuaranteed_LoanGuarantors; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Name_LoanGuarantors; "Loans Guarantee Details".Name)
                {
                }
                column(MemberNo_LoanGuarantors; "Loans Guarantee Details"."Member No")
                {
                }
                column(LoanNo_LoanGuarantors; "Loans Guarantee Details"."Loan No")
                {
                }
                column(EntryNo; EntryNo)
                {
                }
                column(OutStandingBal; "Loans Guarantee Details"."Outstanding Balance")
                {
                }
                column(TotalOutstandingBal; TotalOutstandingBal)
                {
                }
                column(EmployerCode; EmployerCode)
                {
                }
                column(Date_LoansGuaranteeDetails; "Loans Guarantee Details".Date)
                {
                }
                column(CommittedShares; CommittedShares)
                {
                }
                column(OriginalAmount; "Loans Guarantee Details"."Original Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Loan.GET();
                    CommittedShares := 0;
                    GuarantorNo := '';

                    Loansr.Reset;
                    Loansr.SetRange(Loansr."Loan  No.", "Loan No");
                    if Loansr.Find('-') then BEGIN
                        MemberNo := Loansr."Client Code";
                        MemberName := Loansr."Client Name";
                        EmployerCode := Loansr."Employer Code";
                        ApprovedAmt := Loansr."Approved Amount";
                    end;

                    //Message('approved amnt %1', ApprovedAmt);

                    GuarantorNo := "Loans Guarantee Details"."Member No";


                    //     ObjLoanGuar.Reset;
                    //     ObjLoanGuar.SetRange(ObjLoanGuar."Loan No", "Loan No");
                    //     ObjLoanGuar.SetRange(ObjLoanGuar."Member No", GuarantorNo);
                    //     if ObjLoanGuar.FindSet then begin
                    //         repeat
                    //             //MESSAGE(GuarantorNo);
                    //             ObjLoanGuar.CalcFields(ObjLoanGuar."Outstanding Balance");
                    //             TotalOutstandingBal:="Loans Guarantee Details"."Outstanding Balance";
                    //             if ApprovedAmt > 0 then begin
                    //                 CommittedShares := (ObjLoanGuar."Outstanding Balance" / ApprovedAmt) * ObjLoanGuar."Amont Guaranteed";
                    //                 //MESSAGE('Balance %1, Approved %2, Guaranteed %3 thus Committed = %4 for Member %5',ObjLoanGuar."Outstanding Balance",ApprovedAmt,ObjLoanGuar."Amont Guaranteed",CommittedShares,GuarantorNo);
                    //                 //MODIFY;
                    //             end;
                    //             if CommittedShares > 0 then begin
                    //                 ObjLoanGuar.Reset;
                    //                 ObjLoanGuar.SetRange(ObjLoanGuar."Loan No", "Loan No");
                    //                 ObjLoanGuar.SetRange(ObjLoanGuar."Member No", GuarantorNo);
                    //                 if ObjLoanGuar.Find('-') then begin
                    //                     ObjLoanGuar."Committed Shares" := CommittedShares;
                    //                     ObjLoanGuar.Modify;
                    //                 end;
                    //             end;
                    //         until ObjLoanGuar.Next = 0;
                    //     end;
                    //     //END
                    ObjLoanGuar.Reset;
                    ObjLoanGuar.SetRange("Loan No", "Loan No");
                    ObjLoanGuar.SetRange("Member No", "Loans Guarantee Details"."Member No");

                    if ObjLoanGuar.FindSet then begin
                        repeat
                            ObjLoanGuar.CalcFields("Outstanding Balance");

                            if ApprovedAmt > 0 then begin
                                CommittedShares := (ObjLoanGuar."Outstanding Balance" / ApprovedAmt) * ObjLoanGuar."Amont Guaranteed";

                                // Message('Commited shares %1', CommittedShares);

                                if CommittedShares > 0 then begin
                                    ObjLoanGuar."Committed Shares" := CommittedShares;
                                    ObjLoanGuar.Modify;
                                end;
                            end;
                        until ObjLoanGuar.Next = 0;
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*DOCUMENT_NO := "No.";
                IF CONFIRM('Do you want to charge Statement Fee?',FALSE)=FALSE THEN
                  EXIT
                ELSE
                  BEGIN
                    //MESSAGE('Charge for Member %1',DOCUMENT_NO);
                    Charges.RESET();
                    Charges.SETRANGE(Charges.Code,'STATEMENT_CHARGES');
                    IF Charges.FIND('-') THEN
                      BEGIN
                        StmtCharge := Charges."Charge Amount";
                        ChargesGL := Charges."GL Account";
                        IF StmtCharge > 0 THEN
                          IF vend.GET("FOSA Account No.") THEN
                          BEGIN
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor,Customer."FOSA Account No.",PDate,StmtCharge,'FOSA',DOCUMENT_NO,
                            'Detailed Statement Charge','');
                
                        //-------------PAY----------------------------
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::"G/L Account",ChargesGL,PDate,StmtCharge*-1,'FOSA',DOCUMENT_NO,
                            'Detailed Statement Charge','');
                          END;
                      END;
                  END;*/
                //Members.CALCFIELDS(Members."Outstanding Balance",Members."Current Shares",Members."Loans Guaranteed");
                //AvailableSH:=Members."Current Shares"-Members."Loans Guaranteed";

                FNo := FNo + 1;

            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'SCHARGE');
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;

                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'SCHARGE';
                PDate := Today;
                LastFieldNo := FieldNo("No.");
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        AvailableSH: Decimal;
        MemberNo: Text;
        MemberName: Text;
        EmployerCode: Text;
        Loansr: Record "Loans Register";
        EntryNo: Integer;
        TotalOutstandingBal: Decimal;
        OutStandingBal: Decimal;
        FNo: Integer;
        Company: Record "Company Information";
        StmtCharge: Decimal;
        // Charges: Record UnknownRecord51516439;
        ChargesGL: Code[20];
        LineNo: Integer;
        SFactory: Codeunit "SWIZZSFT Factory";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        PDate: Date;
        vend: Record Vendor;
        ObjLoanGuar: Record "Loans Guarantee Details";
        ApprovedAmt: Decimal;
        CommittedShares: Decimal;
        GuarantorNo: Code[50];
}

