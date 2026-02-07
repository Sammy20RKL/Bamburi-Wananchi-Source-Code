#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50863 "Loan 1st Demand Notices Card"
{
    PageType = Card;
    SourceTable = "Default Notices Register";

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
                field("Loan In Default"; Rec."Loan In Default")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Instalments"; Rec."Loan Instalments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Completion Date"; Rec."Expected Completion Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount In Arrears"; Rec."Amount In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Outstanding Balance"; Rec."Loan Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Notice Type"; Rec."Notice Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        FNenableVisbility();
                    end;
                }
                group("Auctioneer Details")
                {
                    Visible = VarAuctioneerDetailsVisible;
                    field("Auctioneer No"; Rec."Auctioneer No")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Auctioneer  Name"; Rec."Auctioneer  Name")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Auctioneer Address"; Rec."Auctioneer Address")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Auctioneer Mobile No"; Rec."Auctioneer Mobile No")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                }
                field("Demand Notice Date"; Rec."Demand Notice Date")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Sent"; Rec."Email Sent")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Demand Letters")
            {
                action("1st Notice Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                        if ObjLoans.FindSet then begin
                            Report.Run(50053, true, true, ObjLoans);
                        end;
                        Commit;
                        PreviewOn := true;
                        Rec.Modify;
                    end;
                }
                action("Loan Aging-Member")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Report;

                    trigger OnAction()
                    var
                        ObjLoans: Record Customer; // Ensure ObjLoans is declared correctly
                    begin
                        ObjLoans.RESET;
                        ObjLoans.SETRANGE(ObjLoans."No.", Rec."Member No");

                        if ObjLoans.FindSet() then begin
                            Report.Run(50041, true, true, ObjLoans);
                        end;
                    end;
                }


                action("1st Notice ")
                {
                    ApplicationArea = Basic;
                    Caption = '1st Notify sms';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        TempBlob: Codeunit "Temp Blob";
                        RecRef: RecordRef;
                        OutStr: OutStream;
                        InStr: InStream;
                        FileName: Text;
                        Cust: Record Customer;
                        EmailMessage: Codeunit "Email Message";
                        Email: Codeunit Email;
                        BodyText: Text;
                        Companyinfo: Record "Company Information";
                    begin
                        if not PreviewOn then
                            Error('Kindly Preview The Report First To Confirm');

                        Rec.TestField("Loan In Default");
                        Rec.TestField("Notice Type");
                        Rec.TestField("Demand Notice Date");

                        CompanyInfo.Get();
                        if not Cust.Get(Rec."Member No") then
                            Error('Member not found.');

                        // === 1. Generate the report as PDF ===
                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                        if not ObjLoans.FindSet then
                            Error('Please select the loan in Arrears');

                        RecRef.GetTable(ObjLoans);

                        TempBlob.CreateOutStream(OutStr);
                        Report.SaveAs(Report::"Loan Defaulter 1st Notice", '', ReportFormat::Pdf, OutStr, RecRef);

                        TempBlob.CreateInStream(InStr);
                        FileName := StrSubstNo('%1_%2.pdf', Cust."No.", Rec."Loan In Default");

                        // === 2. Compose the email ===
                        BodyText := 'Defaulter First Notice: Dear ,' + Rec."Member Name" + ' you have defaulted  '
                                    + Rec."Loan Product Name" + ' with Arrears of KSHs.' + Format(ROUND(Rec."Amount In Arrears", 1, '=')) +
                                    ' at Bamburi Wananchi SACCO LTD.  <br></br>' +
                                    'A demand letter with more information has been attached to this mail.' +
                                     '</br>' +
                                    'Kind regards,' + '<br></br>' +

                                    Companyinfo.Name + '</br>' + Companyinfo.Address + '</br>' + Companyinfo.City + '</br>' +
                                    Companyinfo."Post Code" + '</br>' + Companyinfo."Country/Region Code" + '</br>' +
                                    Companyinfo."Phone No." + '</br>' + Companyinfo."E-Mail";


                        EmailMessage.Create(Cust."E-Mail", 'Loan Default Notice', BodyText, true);
                        EmailMessage.AddAttachment(FileName, 'application/pdf', InStr);

                        // === 3. Send the email ===
                        if Cust."E-Mail" <> '' then
                            Email.Send(EmailMessage);

                        //4.Send the Message now
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;

                        SMSMessage.Reset;
                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        SMSMessage."Account No" := Rec."Member No";
                        SMSMessage."Date Entered" := Rec."Demand Notice Date";
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN DEF1';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Defaulter First Notice: Dear ,' + Rec."Member Name" + ' you have defaulted  '
                                                    + Rec."Loan Product Name" + ' with Arrears of KSHs.' + Format(ROUND(Rec."Amount In Arrears", 1, '=')) +
                                                  ' at Bamburi Wananchi SACCO LTD. ';

                        SMSMessage."Telephone No" := cust."Mobile Phone No";
                        cust.Reset();
                        if cust.Get(Rec."Member No") then
                            SMSMessage."Telephone No" := cust."Mobile Phone No";
                        SMSMessage.Insert();

                        //update vales
                        Rec.DEFAUTER := true;
                        Rec.SECONDNOTE := true;
                        Rec."Second Letter Date" := Today;
                        Rec."Notice Type" := Rec."notice type"::"2nd Demand Notice";
                        Rec.Modify();
                        // END;

                        Message('Email and SMS sent successfully.');
                        CurrPage.Close;
                    end;
                }
                action("2nd Notice Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjDemands.Reset;
                        ObjDemands.SetRange(ObjDemands."Loan In Default", Rec."Loan In Default");
                        ObjDemands.SetFilter(ObjDemands."Document No", '<>%1', Rec."Document No");
                        if ObjDemands.Find('-') = false then begin
                            Rec."Notice Type" := Rec."notice type"::"2nd Demand Notice";
                            Rec."Demand Notice Date" := Today;
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                            if ObjLoans.FindSet then begin
                                Report.Run(51516915, true, true, ObjLoans);
                            end;
                        end;
                        // //
                        // //  ObjDemands.RESET;
                        // //  ObjDemands.SETRANGE(ObjDemands."Loan In Default","Loan In Default");
                        // //  IF ObjDemands.FINDSET THEN BEGIN
                        // //    //IF ObjDemands.COUNT>1 THEN BEGIN
                        // //    "Notice Type":="Notice Type"::"2nd Demand Notice";
                        // //    "Demand Notice Date":=TODAY;
                        // //        ObjLoans.RESET;
                        // //        ObjLoans.SETRANGE(ObjLoans."Loan  No.","Loan In Default");
                        // //        IF ObjLoans.FINDSET THEN BEGIN
                        // //          REPORT.RUN(51516915,TRUE,TRUE,ObjLoans);
                        // //          END;
                        // //        // END;
                        // //      END;

                    end;
                }
                action("CRB Demand Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjDemands.Reset;
                        ObjDemands.SetRange(ObjDemands."Document No", Rec."Document No");
                        if ObjDemands.FindSet then begin
                            Rec."Notice Type" := Rec."notice type"::"CRB Notice";
                            Rec."Demand Notice Date" := Today;
                        end;

                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                        if ObjLoans.FindSet then begin
                            Report.Run(51516926, true, true, ObjLoans);
                        end;
                    end;
                }
                action("3rd Notice Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjDemands.Reset;
                        ObjDemands.SetRange(ObjDemands."Document No", Rec."Document No");
                        if ObjDemands.FindSet then begin
                            Rec."Notice Type" := Rec."notice type"::"3rd Notice";
                            Rec."Demand Notice Date" := Today;
                        end;

                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                        if ObjLoans.FindSet then begin
                            Report.Run(51516916, true, true, ObjLoans);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist :=TRUE;
        IF Rec.Status=Status::Approved THEN BEGIN
          OpenApprovalEntriesExist:=FALSE;
          CanCancelApprovalForRecord:=FALSE;
          EnabledApprovalWorkflowsExist:=FALSE;
          END;
          */

    end;

    trigger OnAfterGetRecord()
    begin
        FNenableVisbility();
        FNenableEditing();
    end;

    trigger OnOpenPage()
    begin
        FNenableVisbility();
        FNenableEditing();
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        SwizzsoftFactory: Codeunit "Swizzsoft Factory";
        JTemplate: Code[20];
        JBatch: Code[20];
        GenSetup: Record 51398;
        DocNo: Code[20];
        LineNo: Integer;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ObjVendors: Record Vendor;
        ObjAccTypes: Record 51436;
        AvailableBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjDemands: Record 51926;
        VarAuctioneerDetailsVisible: Boolean;
        SMSMessage: Record 51471;
        iEntryNo: Integer;
        cust: Record Customer;
        PreviewOn: Boolean;

    local procedure FNenableVisbility()
    begin
        VarAuctioneerDetailsVisible := false;

        if Rec."Notice Type" = Rec."notice type"::"3rd Notice" then begin
            VarAuctioneerDetailsVisible := true;
        end
    end;

    local procedure FNenableEditing()
    begin
    end;
}

