#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50310 "Payroll Employee Card."
{
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Payroll Employee.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = All;
                    Caption = 'Sacco Member No.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Staff No';
                }

                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Employee Email"; Rec."Employee Email")
                {
                    ApplicationArea = All;
                }
                field("Joining Date"; Rec."Joining Date")
                {
                    ApplicationArea = All;
                    Caption = 'Appointment Date';
                    ShowMandatory = true;
                }
                field("Last Increment Date"; Rec."Last Increment Date")
                {
                    ApplicationArea = All;
                    Caption = 'Last Increment Date';
                    Enabled = false;
                    Visible = false;
                }
                field("Next Increment Date"; Rec."Next Increment Date") //transaction priod month
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Of Retirement"; Rec."Date Of Retirement")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Global Dimension 2"; Rec."Global Dimension 2")
                {
                    ApplicationArea = All;
                    Caption = '"Global Dimension 2"';
                    Visible = false;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("National ID No"; Rec."National ID No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("NSSF No"; Rec."NSSF No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("NHIF No"; Rec."NHIF No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("PIN No"; Rec."PIN No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Organization; Rec.Organization)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Living with disability"; Rec."Living with disability")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Is Management"; Rec."Is Management")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payroll Categories"; Rec."Payroll Categories")
                {
                    ApplicationArea = All;
                }
                field("Work Station"; Rec."Work Station")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    applicationarea = all;
                    editable = true;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Pay Details")
            {
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                }
                field("Paid per Hour"; Rec."Paid per Hour")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pays PAYE"; Rec."Pays PAYE")
                {
                    ApplicationArea = All;
                }
                field("Pays NSSF"; Rec."Pays NSSF")
                {
                    ApplicationArea = All;
                }
                field("Pays NHIF"; Rec."Pays NHIF")
                {
                    ApplicationArea = All;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = All;
                }
                field("Insurance Premium"; Rec."Insurance Premium")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(NITA; Rec.NITA)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pays Pension"; Rec."Pays Pension")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group("Bank Details")
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Visible = true;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                // field("Branch Code"; "Branch Code")
                // {
                //     ApplicationArea = All;
                //     ShowMandatory = true;
                // }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                // field("Bank Location"; "Bank Location")
                // {
                //     ApplicationArea = All;
                //     ShowMandatory = true;
                // }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
            group("Other Details")
            {
                field("Payslip Message"; Rec."Payslip Message")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
            }
            group("Cummulative Figures")
            {
                Editable = false;

                field("Cummulative Basic Pay"; Rec."Cummulative Basic Pay")
                {
                    ApplicationArea = All;
                }
                field("Cummulative Gross Pay"; Rec."Cummulative Gross Pay")
                {
                    ApplicationArea = All;
                }
                /*  field("Cummulative Allowances"; "Cummulative Allowances")
                  {
                  }*/
                field("Cummulative Deductions"; Rec."Cummulative Deductions")
                {
                    ApplicationArea = All;
                }
                field("Cummulative Net Pay"; Rec."Cummulative Net Pay")
                {
                    ApplicationArea = All;
                }
                field("Cummulative PAYE"; Rec."Cummulative PAYE")
                {
                    ApplicationArea = All;
                }
                field("Cummulative NSSF"; Rec."Cummulative NSSF")
                {
                    ApplicationArea = All;
                }
                field("Cummulative Pension"; Rec."Cummulative Pension")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cummulative HELB"; Rec."Cummulative HELB")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cummulative NHIF"; Rec."Cummulative NHIF")
                {
                    ApplicationArea = All;
                }
            }
            group("Suspension of Payment")
            {
                field("Suspend Pay"; Rec."Suspend Pay")
                {
                    ApplicationArea = All;
                }
                field("Suspend Date"; Rec."Suspend Date")
                {
                    ApplicationArea = All;
                }
                field("Suspend Reason"; Rec."Suspend Reason")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("Process Current Employee")
            {
                ApplicationArea = All;
                Caption = 'Process Payroll';
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;

                Visible = false;

                trigger OnAction()
                var
                    PayrollEmployDed: Record "Payroll Employee Transactions.";
                begin
                    ContrInfo.Reset;
                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then begin
                        SelectedPeriod := objPeriod."Date Opened";
                        varPeriodMonth := objPeriod."Period Month";
                        SalCard.Get(Rec."No.");
                    end;
                    //For Multiple Payroll
                    if ContrInfo."Multiple Payroll" then begin
                        PayrollDefined := '';
                        PayrollType.Reset;
                        PayrollType.SetCurrentKey(EntryNo);
                        if PayrollType.FindFirst then begin
                            NoofRecords := PayrollType.Count;
                            i := 0;
                            repeat
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                if i < NoofRecords then PayrollDefined := PayrollDefined + ',' until PayrollType.Next = 0;
                        end;
                        //Selection := STRMENU(PayrollDefined,NoofRecords);
                        PayrollType.Reset;
                        PayrollType.SetRange(PayrollType.EntryNo, Selection);
                        if PayrollType.Find('-') then begin
                            //PayrollCode:=PayrollType."Payroll Code";
                            PayrollCode := HrEmployee."Posting Group";
                        end;
                    end;
                    //Delete all Records from the prPeriod Transactions for Reprocessing
                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.FindFirst then begin
                        //IF ContrInfo."Multiple Payroll" THEN BEGIN
                        ObjPayrollTransactions.Reset;
                        ObjPayrollTransactions.SetRange(ObjPayrollTransactions."Payroll Period", objPeriod."Date Opened");
                        ObjPayrollTransactions.SetRange("Employee Code", Rec."No.");
                        if ObjPayrollTransactions.Find('-') then begin
                            ObjPayrollTransactions.DeleteAll;
                        end;
                    end;
                    PayrollEmployerDed.Reset;
                    PayrollEmployerDed.SetRange(PayrollEmployerDed."Payroll Period", SelectedPeriod);
                    PayrollEmployerDed.SetRange("Employee Code", Rec."No.");
                    if PayrollEmployerDed.Find('-') then PayrollEmployerDed.DeleteAll;
                    //*********************************************************************************************add interest
                    PayrollEmployDed.Reset;
                    PayrollEmployDed.SetRange(PayrollEmployDed."No.", Rec."No.");
                    PayrollEmployDed.SetRange(PayrollEmployDed."IsCoop/LnRep", true);
                    if PayrollEmployDed.FindSet() then begin
                        repeat
                            PayrollEmployDed."Interest Charged" := Round(PayrollEmployDed.Balance * PayrollEmployDed."Interest Rate" / 12 / 100, 1, '=');
                            //Message('Interest%1', Format(PayrollEmployDed."Interest Charged"));
                            PayrollEmployDed.Modify;
                        until PayrollEmployDed.Next = 0;
                    end;
                    // if ContrInfo."Multiple Payroll" then
                    //                    //*********************************************************************************************add interest
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                    HrEmployee.SetRange(HrEmployee."No.", Rec."No.");
                    if HrEmployee.Find('-') then begin
                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat
                            Sleep(100);
                            if not SalCard."Suspend Pay" then begin
                                ProgressWindow.Update(1, HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee.Surname);
                                if SalCard.Get(HrEmployee."No.") then
                                    ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Joining Date", SalCard."Basic Pay", SalCard."Pays PAYE", SalCard."Pays NSSF", SalCard."Pays NHIF", SelectedPeriod, SelectedPeriod, HrEmployee."Payroll No", '', HrEmployee."Date of Leaving", true, HrEmployee."Branch Code", PayrollCode);
                            end;
                        until HrEmployee.Next = 0;
                        ProgressWindow.Close;
                    end;
                    Message('Payroll processing completed successfully.');
                end;
            }
            action("Process Payroll")
            {
                ApplicationArea = All;
                Caption = 'Process Payroll';
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;
                trigger OnAction()
                begin
                    ContrInfo.Reset;
                    // ContrInfo.GET;

                    objPeriod.RESET;
                    objPeriod.SETRANGE(objPeriod.Closed, FALSE);
                    IF objPeriod.FIND('-') THEN BEGIN
                        SelectedPeriod := objPeriod."Date Opened";
                        varPeriodMonth := objPeriod."Period Month";
                        SalCard.GET(Rec."No.");
                    END;

                    //For Multiple Payroll
                    IF ContrInfo."Multiple Payroll" THEN BEGIN
                        PayrollDefined := '';
                        PayrollType.RESET;
                        PayrollType.SETCURRENTKEY(EntryNo);
                        IF PayrollType.FINDFIRST THEN BEGIN
                            NoofRecords := PayrollType.COUNT;
                            i := 0;
                            REPEAT
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                IF i < NoofRecords THEN
                                    PayrollDefined := PayrollDefined + ','
                            UNTIL PayrollType.NEXT = 0;
                        END;
                        //Selection := STRMENU(PayrollDefined,NoofRecords);

                        PayrollType.RESET;
                        PayrollType.SETRANGE(PayrollType.EntryNo, Selection);
                        IF PayrollType.FIND('-') THEN BEGIN
                            PayrollCode := PayrollType."Payroll Code";
                        END;
                    END;

                    //Delete all Records from the prPeriod Transactions for Reprocessing
                    objPeriod.RESET;
                    objPeriod.SETRANGE(objPeriod.Closed, FALSE);
                    IF objPeriod.FINDFIRST THEN BEGIN

                        //IF ContrInfo."Multiple Payroll" THEN BEGIN
                        ObjPayrollTransactions.RESET;
                        ObjPayrollTransactions.SETRANGE(ObjPayrollTransactions."Payroll Period", objPeriod."Date Opened");
                        IF ObjPayrollTransactions.FIND('-') THEN BEGIN
                            ObjPayrollTransactions.DELETEALL;
                        END;
                    END;

                    PayrollEmployerDed.RESET;
                    PayrollEmployerDed.SETRANGE(PayrollEmployerDed."Payroll Period", SelectedPeriod);
                    IF PayrollEmployerDed.FIND('-') THEN
                        PayrollEmployerDed.DELETEALL;

                    //MESSAGE ('Member is %1',PayrollEmployerDed."Membership No");


                    IF ContrInfo."Multiple Payroll" THEN
                        HrEmployee.RESET;
                    HrEmployee.SETRANGE(HrEmployee.Status, HrEmployee.Status::Active);
                    IF HrEmployee.FIND('-') THEN BEGIN
                        ProgressWindow.OPEN('Processing Salary for Employee No. #1#######');
                        REPEAT
                            SLEEP(100);
                            IF NOT SalCard."Suspend Pay" THEN BEGIN
                                ProgressWindow.UPDATE(1, HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee.Surname);
                                IF SalCard.GET(HrEmployee."No.") THEN
                                    ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Joining Date", SalCard."Basic Pay", SalCard."Pays PAYE"
                                    , SalCard."Pays NSSF", SalCard."Pays NHIF", SelectedPeriod, SelectedPeriod, HrEmployee."Payroll No", '',
                                    HrEmployee."Date of Leaving", TRUE, HrEmployee."Branch Code", PayrollCode);
                            END;
                        UNTIL HrEmployee.NEXT = 0;
                        ProgressWindow.CLOSE;
                    END;
                    MESSAGE('Payroll processing completed successfully.');

                end;
            }
            action("Employee Earnings")
            {
                ApplicationArea = All;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Earnings.";
                RunPageLink = "No." = FIELD("No.");
                RunPageView = WHERE("Transaction Type" = FILTER(Income));
            }
            action("Employee Deductions")
            {
                ApplicationArea = All;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Deductions.";
                RunPageLink = "No." = FIELD("No.");
                RunPageView = WHERE("Transaction Type" = FILTER(Deduction));
            }
            action("Employee Assignments")
            {
                ApplicationArea = All;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Assignments.";
                RunPageLink = "No." = FIELD("No.");
            }
            action("Employee Cummulatives")
            {
                ApplicationArea = All;
                Image = History;
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Cummulatives.";
                RunPageLink = "No." = FIELD("No.");
            }
            action("Send Payslip Via Email")
            {
                ApplicationArea = All;
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    FnSendReceiptviaEmail;
                end;
            }
            action("Send P9")
            {
                ApplicationArea = All;
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    FnSendP9Email;
                end;
            }
            action("View PaySlip")
            {
                ApplicationArea = All;
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp."No.", Rec."No.");
                    if PayrollEmp.FindFirst then begin
                        REPORT.Run(51016, true, false, PayrollEmp);
                    end;
                end;
            }
            action("Living with Disability2")
            {
                ApplicationArea = All;
                Caption = 'Living with Disability';
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec."Living with disability" := true;
                    Rec.Modify;
                end;
            }
        }
    }
    var
        PayrollEmp: Record "Payroll Employee.";
        PayrollManager: Codeunit "Payroll Management";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender.";
        // PayrollMonthlyTrans: Record "Payroll Monthly Transactions.";
        //  PayrollEmployeeDed: Record "Payroll Employee Deductions.";
        PayrollEmployerDed: Record "Payroll Employer Deductions.";
        objEmp: Record "Salary Processing Header";
        SalCard: Record "Payroll Employee.";
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit "Payroll Processing";
        HrEmployee: Record "Payroll Employee.";
        ProgressWindow: Dialog;
        // prPeriodTransactions: Record "prPeriod Transactions..";
        prEmployerDeductions: Record "Payroll Employer Deductions.";
        PayrollType: Record "Payroll Type.";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information.";
        UserSetup: Record "User Setup";
        ObjPayrollTransactions: Record "prPeriod Transactions.";
        varPeriodMonth: Integer;

    procedure FnSendP9Email()
    var
        MemberReg: Record Customer;
        FileName: Text[200];
        FileName2: Text[200];
        FileType: Text[100];
        SendEmailTo: Text[100];
        EmailBody: Text[1000];
        EmailSubject: Text[100];
        membersreg: Record Customer;
        Outstr: OutStream;
        Instr: InStream;
        Outstr2: OutStream;
        Instr2: InStream;
        TempBlob: Codeunit "Temp Blob";
        Receipt: Record "Payroll Employee.";
        MailToSend: Codeunit "Email Message";
        GenerateDoc: InStream; //Generate PDF/Document to be sent 
        EncodeStream: Codeunit "Base64 Convert"; //To encode the stream of data form GenerateDoc
        FnEmail: Codeunit Email;
        DialogBox: Dialog;
        reportrun: Report "P9 Report";
        reportparameters: text;
        ReportTable: Record "Payroll Employee.";
        CompanyInfo: Record "Company Information";
        PeriodDate: Record "Payroll Calender.";

    begin
        if Confirm('Are you sure you want to Send P9 to ' + Format(Receipt."Full Name") + '?', false) = false then begin
            Message('Aborted');
            exit
        end else begin


            DialogBox.Open('Sending P9 Slip to  ' + Format(Receipt."Full Name"));
            //------------------->Get Key Details of Send Email
            SendEmailTo := '';
            SendEmailTo := FnGetClientCodeEmail(Rec."No.");
            EmailSubject := '';
            EmailSubject := 'P9 for ' + Format(Rec."Payroll Period");
            EmailBody := '';
            EmailBody := 'Dear <b>' + Format(Rec."Full Name") + '</b>,</br></br>' +
            'We hope this email finds you well. Please find attached your P9.' +
                Companyinfo.Name + '</br> ' + Companyinfo.Address + '</br> ' + Companyinfo.City + '</br>' +
           Companyinfo."Post Code" + '</br>' + Companyinfo."Country/Region Code" + '</br>' +
            Companyinfo."Phone No." + '</br> ' + Companyinfo."E-Mail";
            //------------------->Generate The Report Attachments To Send
            //---------Attachment 1
            reportparameters := reportrun.RunRequestPage();
            //reportparameters :=  format("No.") + Format( "Payroll Period");
            FileName := Format(Rec."Payroll Period") + '-Payslip.pdf';
            TempBlob.CreateOutStream(Outstr);
            Report.SaveAs(Report::"P9 Report", reportparameters, ReportFormat::Pdf, Outstr);
            TempBlob.CreateInStream(Instr);
            //------------------->Create Emails Start
            MailToSend.Create(SendEmailTo, EmailSubject, EmailBody, true);
            MailToSend.AddAttachment(FileName, FileType, Instr);
            //.........................................
            FnEmail.Send(MailToSend);
            DialogBox.Close();
            Message('Email Send to %1 Succesfully', Rec."Full Name");
        end;
    end;

    procedure FnSendReceiptviaEmail()
    var
        MemberReg: Record Customer;
        FileName: Text[200];
        FileName2: Text[200];
        FileType: Text[100];
        SendEmailTo: Text[100];
        EmailBody: Text[1000];
        EmailSubject: Text[100];
        membersreg: Record Customer;
        Outstr: OutStream;
        Instr: InStream;
        Outstr2: OutStream;
        Instr2: InStream;
        TempBlob: Codeunit "Temp Blob";
        Receipt: Record "Payroll Employee.";
        MailToSend: Codeunit "Email Message";
        GenerateDoc: InStream; //Generate PDF/Document to be sent 
        EncodeStream: Codeunit "Base64 Convert"; //To encode the stream of data form GenerateDoc
        FnEmail: Codeunit Email;
        DialogBox: Dialog;
        reportrun: Report "Payroll Payslip";
        reportparameters: text;
        ReportTable: Record "Payroll Employee.";
        CompanyInfo: Record "Company Information";
        PeriodDate: Record "Payroll Calender.";

    begin
        if Confirm('Are you sure you want to Send Payslip to ' + Format(Receipt."Full Name") + '?', false) = false then begin
            Message('Aborted');
            exit
        end else begin


            DialogBox.Open('Sending Payslip to  ' + Format(Receipt."Full Name"));
            //------------------->Get Key Details of Send Email
            SendEmailTo := '';
            SendEmailTo := FnGetClientCodeEmail(Rec."No.");
            EmailSubject := '';
            EmailSubject := 'Payslip for ' + Format(Rec."Payroll Period");

            EmailBody := 'Dear <b>' + Format(Rec."Full Name") + '</b>,</br></br>' +
            'We hope this email finds you well. Please find attached your Payslip.' +
                Companyinfo.Name + '</br> ' + Companyinfo.Address + '</br> ' + Companyinfo.City + '</br>' +
           Companyinfo."Post Code" + '</br>' + Companyinfo."Country/Region Code" + '</br>' +
            Companyinfo."Phone No." + '</br> ' + Companyinfo."E-Mail";
            //------------------->Generate The Report Attachments To Send
            //---------Attachment 1
            reportparameters := reportrun.RunRequestPage();
            //reportparameters :=  format("No.") + Format( "Payroll Period");
            FileName := Format(Rec."Payroll Period") + '-Payslip.pdf';
            TempBlob.CreateOutStream(Outstr);
            Report.SaveAs(Report::"Payroll Payslip", reportparameters, ReportFormat::Pdf, Outstr);
            TempBlob.CreateInStream(Instr);
            //------------------->Create Emails Start
            MailToSend.Create(SendEmailTo, EmailSubject, EmailBody, true);
            MailToSend.AddAttachment(FileName, FileType, Instr);
            //.........................................
            FnEmail.Send(MailToSend);
            DialogBox.Close();
            Message('Email Send to %1 Succesfully', Rec."Full Name");
        end;
    end;

    local procedure FnGetClientCodeEmail(ClientCode: Code[50]): Text[100]
    var
        PayrollEmp: Record "Payroll Employee.";
        receipt: Record "Payroll Employee.";
    begin
        PayrollEmp.Reset();
        PayrollEmp.SetRange(PayrollEmp."No.", ClientCode);
        if PayrollEmp.Find('-') then begin
            exit(PayrollEmp."Employee Email");
        end;
    end;
}

