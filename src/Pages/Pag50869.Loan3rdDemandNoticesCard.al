#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50869 "Loan 3rd Demand Notices Card"
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
                field(THIRDNOTE; Rec.THIRDNOTE)
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
            group("Demand Letters")
            {
                action("1st Notice Letter")
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
                            Rec."Notice Type" := Rec."notice type"::"1st Demand Notice";
                            Rec."Demand Notice Date" := Today;
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                            if ObjLoans.FindSet then begin
                                Report.Run(50053, true, true, ObjLoans);
                            end;
                        end;

                        //  ObjDemands.RESET;
                        //  ObjDemands.SETRANGE(ObjDemands."Loan In Default","Loan In Default");
                        //  IF ObjDemands.FINDSET THEN BEGIN
                        //    IF ObjDemands.COUNT>1 THEN BEGIN
                        //    "Notice Type":="Notice Type"::"2nd Demand Notice";
                        //    "Demand Notice Date":=TODAY;
                        //        ObjLoans.RESET;
                        //        ObjLoans.SETRANGE(ObjLoans."Loan  No.","Loan In Default");
                        //        IF ObjLoans.FINDSET THEN BEGIN
                        //          REPORT.RUN(51516915,TRUE,TRUE,ObjLoans);
                        //          END;
                        //         END;
                        //      END;

                    end;
                }
                action("3rd Notice ")
                {
                    ApplicationArea = Basic;
                    Caption = '3rd Notify sms';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField("Loan In Default");
                        Rec.TestField("Notice Type");
                        Rec.TestField("Demand Notice Date");
                        Rec.TestField("Notice Type");

                        cust.Reset;
                        cust.SetRange(cust."No.", Rec."Member No");
                        if cust.Find('-') then begin
                            //PhoneNo:=Cust."Phone No.";

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
                            SMSMessage.Source := 'LOAN DEF3';
                            SMSMessage."Entered By" := UserId;
                            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;

                            SMSMessage."SMS Message" := 'Defaulter Final Notice: Dear ,' + Rec."Member Name" + ' you defaulted  '
                            + Rec."Loan Product Name" + ' with Outstanding balance of KSHs.' + Format(ROUND(Rec."Amount In Arrears", 1, '=')) +
                                                      ' and outstanding Balance we will recoverly from your Guarantors , Polytech SACCO LTD. ';


                            SMSMessage."Telephone No" := cust."Phone No.";
                            cust.Reset;
                            if cust.Get(Rec."Member No") then
                                SMSMessage."Telephone No" := cust."Phone No.";
                            SMSMessage.Insert;
                        end;
                        //............................................................................


                        // Cust.RESET;
                        // Cust.SETRANGE(Cust."No.",LoanGuar."Member No");
                        // IF Cust.FIND('-') THEN BEGIN
                        // Loans."Client Name":=Cust.Name;
                        // END;


                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Rec."Loan In Default");
                        if LoanGuar.Find('-') then begin
                            repeat
                                ;


                                //IF SendSMS = TRUE THEN BEGIN
                                //SMS MESSAGE
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
                                SMSMessage."Account No" := LoanGuar."Member No";
                                SMSMessage."Date Entered" := Today;
                                SMSMessage."Time Entered" := Time;
                                SMSMessage.Source := 'LOAN DEF3';
                                SMSMessage."Entered By" := UserId;
                                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                                SMSMessage."SMS Message" := 'Final Notice: Dear '
                            + LoanGuar.Name + ' We would like to inform you that We will recover ' + Rec."Member Name" + ' Loan dependent on what you had guaranteed from your deposits to pay off the outstanding of ksh' +
                            Format(ROUND(Rec."Amount In Arrears", 1, '=')) + ' at POLYTECH SACCO LTD. ';
                                cust.Reset;

                                cust.Reset;
                                cust.SetRange(cust."No.", LoanGuar."Member No");
                                if cust.Find('-') then begin
                                    //MESSAGE ('call ame is %1',cust."Mobile Phone No");


                                    SMSMessage."Telephone No" := cust."Mobile Phone No";
                                    SMSMessage.Insert;

                                end;
                            until LoanGuar.Next = 0;
                        end;
                        // //.............................................................................
                        //
                        Rec.DEFAUTER := true;
                        Rec."Third Letter Date" := Today;
                        Rec.Modify;
                        // END;


                        Message('Notified successfully');

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
                                Report.Run(50054, true, true, ObjLoans);
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
                            Report.Run(50055, true, true, ObjLoans);
                        end;
                    end;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        /*
                        DocumentType:=DocumentType::PackageLodging;
                        ApprovalEntries.Setfilters(DATABASE::"Safe Custody Package Register",DocumentType,"Package ID");
                        ApprovalEntries.RUN;
                        */

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*//Check Item and Agent Attachment
                        ObjAgents.RESET;
                        ObjAgents.SETRANGE(ObjAgents."Package ID","Package ID");
                        ObjAgents.SETFILTER(ObjAgents."Agent Name",'<>%1','');
                        IF ObjAgents.FINDSET=FALSE THEN BEGIN
                          ERROR('You have to specify atleast 1 package agent');
                          END;
                        
                        ObjItems.RESET;
                        ObjItems.SETRANGE(ObjItems."Package ID","Package ID");
                        ObjItems.SETFILTER(ObjItems."Item Description",'<>%1','');
                        IF ObjItems.FINDSET=FALSE THEN BEGIN
                          ERROR('You have to specify atleast 1 package item');
                          END;
                        
                        IF ApprovalsMgmt.CheckPackageLodgeApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendPackageLodgeForApproval(Rec)
                        
                          */

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*IF ApprovalsMgmt.CheckPackageLodgeApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnCancelPackageLodgeApprovalRequest(Rec);*/


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
        ObjLoans: Record 51371;
        ObjDemands: Record 51926;
        VarAuctioneerDetailsVisible: Boolean;
        SMSMessage: Record 51471;
        iEntryNo: Integer;
        cust: Record 51364;
        LoanGuar: Record 51372;
        Loans: Record 51371;
        Cust1: Record 51364;

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

