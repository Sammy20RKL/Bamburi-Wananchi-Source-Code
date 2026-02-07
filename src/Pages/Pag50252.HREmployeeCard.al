#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50252 "HR Employee Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Print,Functions,Employee,Attachments';
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group("General Details")
            {
                Caption = 'General Details';
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    AssistEdit = true;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        // IF AssistEdit() THEN
                        CurrPage.Update;
                    end;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Passport Number"; Rec."Passport Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = Basic;
                }
                field("Citizenship Text"; "Citizenship Text")
                {
                    ApplicationArea = Basic;
                    Caption = 'Country / Region Code';
                    Editable = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code") { ApplicationArea = Basic; }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(IsBoard; Rec.IsBoard)
                {
                    ApplicationArea = Basic;
                    Caption = 'Board Member';
                    Visible = false;
                }
                field(IsBoardChair; Rec.IsBoardChair)
                {
                    ApplicationArea = Basic;
                    Caption = 'Board Chair';
                    Visible = false;
                }
                field(IsCommette; Rec.IsCommette)
                {
                    ApplicationArea = Basic;
                    Caption = 'Committee Member';
                    Visible = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = Basic;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                    Caption = 'Employee User Id';

                }
                field("Fosa Account"; Rec."Fosa Account")
                {
                    ApplicationArea = Basic;
                }
                field(SupervisorNames; SupervisorNames)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor ';
                    // Editable = false;
                    // Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Supervisor; Rec.Supervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor';
                    // Visible = false;
                }
                field("Supervisor Name"; Rec."Supervisor Name") { Editable = false; }
            }
            group("Communication Details")
            {
                Caption = 'Communication Details';
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                    Importance = Promoted;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                }
                field("Ext."; Rec."Ext.")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = PhoneNo;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = EMail;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = Basic;
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Gender."; Rec."Gender.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                // field(Signature; Signature)
                // {
                //     ApplicationArea = Basic;
                // }
                field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                }
                field("First Language Read"; Rec."First Language Read")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("First Language Write"; Rec."First Language Write")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("First Language Speak"; Rec."First Language Speak")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Second Language Read"; Rec."Second Language Read")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Second Language Write"; Rec."Second Language Write")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Second Language Speak"; Rec."Second Language Speak")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Additional Language"; Rec."Additional Language")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Vehicle Registration Number"; Rec."Vehicle Registration Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Number Of Dependants"; Rec."Number Of Dependants")
                {
                    ApplicationArea = Basic;
                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = Basic;
                }
                field("Health Assesment?"; Rec."Health Assesment?")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme No."; Rec."Medical Scheme No.")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme Head Member"; Rec."Medical Scheme Head Member")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme Name"; Rec."Medical Scheme Name")
                {
                    ApplicationArea = Basic;
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic;
                }
                field("Health Assesment Date"; Rec."Health Assesment Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                field("Main Bank"; Rec."Main Bank")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("<Bank Code>"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Code';
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("<Branch Code>"; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Code';
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        if Rec."Date Of Birth" >= Today then begin
                            Error('Invalid Entry');
                        end;
                        DAge := Dates.DetermineAge(Rec."Date Of Birth", Today);
                    end;
                }
                field(DAge; DAge)
                {
                    ApplicationArea = Basic;
                    Caption = 'Age';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        DService := Dates.DetermineAge(Rec."Date Of Join", Today);
                    end;
                }
                field(DService; DService)
                {
                    ApplicationArea = Basic;
                    Caption = 'Length of Service';
                    Editable = false;
                    Enabled = false;
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Scheme Join Date"; Rec."Pension Scheme Join Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        DPension := Dates.DetermineAge(Rec."Pension Scheme Join Date", Today);
                    end;
                }
                field("Medical Scheme Join Date"; Rec."Medical Scheme Join Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        DMedical := Dates.DetermineAge(Rec."Medical Scheme Join Date", Today);
                    end;
                }
                field(DMedical; DMedical)
                {
                    ApplicationArea = Basic;
                    Caption = 'Time On Medical Aid Scheme';
                    Editable = false;
                    Enabled = false;
                }
                field("Wedding Anniversary"; Rec."Wedding Anniversary")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Job Details")
            {
                Caption = 'Job Details';
                field("Job Specification"; Rec."Job Specification")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Terms of Service")
            {
                Caption = 'Terms of Service';
                field("Secondment Institution"; Rec."Secondment Institution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Seondment';
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Send Alert to"; Rec."Send Alert to")
                {
                    ApplicationArea = Basic;
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
            group("Payment Information")
            {
                Caption = 'Payment Information';
                field("PIN No."; Rec."PIN No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
            group("Separation Details")
            {
                Caption = 'Separation Details';
                field("Date Of Leaving the Company"; Rec."Date Of Leaving the Company")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        /*
                        FrmCalendar.SetDate("Date Of Leaving the Company");
                        FrmCalendar.RUNMODAL;
                        D := FrmCalendar.GetDate;
                        CLEAR(FrmCalendar);
                        IF D <> 0D THEN
                          "Date Of Leaving the Company":= D;
                        //DAge:= Dates.DetermineAge("Date Of Birth",TODAY);
                        
                        */

                    end;
                }
                field("Termination Grounds"; Rec."Termination Grounds")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
            group("Leave Details/Medical Claims")
            {
                Caption = 'Leave Details/Medical Claims';
                field("Reimbursed Leave Days"; Rec."Reimbursed Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Allocated Leave Days"; Rec."Allocated Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Total (Leave Days)"; Rec."Total (Leave Days)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Total Leave Taken"; Rec."Total Leave Taken")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Acrued Leave Days"; Rec."Acrued Leave Days")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Cash per Leave Day"; Rec."Cash per Leave Day")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Cash - Leave Earned"; Rec."Cash - Leave Earned")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Leave Status"; Rec."Leave Status")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Leave Type Filter"; Rec."Leave Type Filter")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Leave Period Filter"; Rec."Leave Period Filter")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Claim Limit"; Rec."Claim Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Amount Used"; Rec."Claim Amount Used")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Remaining Amount"; Rec."Claim Remaining Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755004; "HR Employees Factbox")
            {
                SubPageLink = "No." = field("No.");
            }

        }
    }

    actions
    {
        area(navigation)
        {

            group("&Employee")
            {
                Caption = '&Employee';
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("No.");
                    RunPageView = where(Type = filter("Next of Kin"));
                }
                action(Beneficiaries)
                {
                    ApplicationArea = Basic;
                    Caption = 'Beneficiaries';
                    Image = Opportunity;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("No.");
                    RunPageView = where(Type = filter(Beneficiary));
                }

                action(Qualifications)
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employee Qualification Line";
                    RunPageLink = "Employee No." = field("No.");
                }
                action("Employment History")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employment History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HR Employment History Lines";
                    RunPageLink = "Employee No." = field("No.");
                }


                action(Supervisees)
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisees';
                    RunObject = Page "HR Employees Supervisee";
                    Visible = FALSE;
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        //Recalculate Important Dates
        if (Rec."Date Of Leaving the Company" = 0D) then begin
            if (Rec."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(Rec."Date Of Birth", Today);
            if (Rec."Date Of Joining the Company" <> 0D) then
                DService := Dates.DetermineAge(Rec."Date Of Joining the Company", Today);
            if (Rec."Pension Scheme Join Date" <> 0D) then
                DPension := Dates.DetermineAge(Rec."Pension Scheme Join Date", Today);
            if (Rec."Medical Scheme Join Date" <> 0D) then
                DMedical := Dates.DetermineAge(Rec."Medical Scheme Join Date", Today);
            //MODIFY;
        end else begin
            if (Rec."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(Rec."Date Of Birth", Rec."Date Of Leaving the Company");
            if (Rec."Date Of Joining the Company" <> 0D) then
                DService := Dates.DetermineAge(Rec."Date Of Joining the Company", Rec."Date Of Leaving the Company");
            if (Rec."Pension Scheme Join Date" <> 0D) then
                DPension := Dates.DetermineAge(Rec."Pension Scheme Join Date", Rec."Date Of Leaving the Company");
            if (Rec."Medical Scheme Join Date" <> 0D) then
                DMedical := Dates.DetermineAge(Rec."Medical Scheme Join Date", Rec."Date Of Leaving the Company");
            //MODIFY;
        end;

        //Recalculate Leave Days
        Rec.Validate("Allocated Leave Days");
        SupervisorNames := GetSupervisor(Rec."User ID");
    end;

    trigger OnClosePage()
    begin
        /* TESTFIELD("First Name");
         TESTFIELD("Middle Name");
         TESTFIELD("Last Name");
         TESTFIELD("ID Number");
         TESTFIELD("Cellular Phone Number");
        */

    end;



    var
        PictureExists: Boolean;
        Text001: label 'Do you want to replace the existing picture of %1 %2?';
        Text002: label 'Do you want to delete the picture of %1 %2?';
        Dates: Codeunit "HR Datess";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        D: Date;
        // DoclLink: Record "HR Employee Attachments";
        "Filter": Boolean;
        prEmployees: Record "HR Employees";
        prPayrollType: Record "prPayroll Type";
        Mail: Codeunit Mail;
        HREmp: Record "HR Employees";
        SupervisorNames: Text[60];
        Misc: Record "Misc. Article Information";
        Conf: Record "Confidential Information";
        HRValueChange: Record "HR Value Change";
        CompInfo: Record "Company Information";
        Body: Text[1024];
        Text003: label 'Welcome to Lotus Capital Limited';
        Filename: Text;
        Recordlink: Record "Record Link";
        Text004a: label 'It is a great pleasure to welcome you to Moi Teaching and Referral Hospital. You are now part of an organization that has its own culture and set of values. On your resumption and during your on-boarding process,  to help you to understand and adapt quickly and easily to the LOTUS CAPITAL culture and values, HR Unit shall provide you with various important documents that you are encouraged to read and understand.';
        Text004b: label 'On behalf of the Managing Director, I congratulate you for your success in the interview process and I look forward to welcoming you on board LOTUS CAPITAL Limited.';
        Text004c: label 'Adebola SAMSON-FATOKUN';
        Text004d: label 'Strategy & Corporate Services';
        NL: Char;
        LF: Char;
        objpostingGroup: Record "prEmployee Posting Group";
        objDimVal: Record "Dimension Value";
        "Citizenship Text": Text[200];


    procedure GetSupervisor(var sUserID: Code[50]) SupervisorName: Text[200]
    var
        UserSetup: Record "User Setup";
    begin
        if sUserID <> '' then begin
            UserSetup.Reset;
            if UserSetup.Get(sUserID) then begin

                SupervisorName := UserSetup."Approver ID";
                if SupervisorName <> '' then begin

                    HREmp.SetRange(HREmp."User ID", SupervisorName);
                    if HREmp.Find('-') then
                        SupervisorName := HREmp.FullName;

                end else begin
                    SupervisorName := '';
                end;


            end else begin
                Error('User' + ' ' + sUserID + ' ' + 'does not exist in the user setup table');
                SupervisorName := '';
            end;
        end;
    end;


    procedure GetSupervisorID(var EmpUserID: Code[50]) SID: Text[200]
    var
        UserSetup: Record "User Setup";
        SupervisorID: Code[20];
    begin
        if EmpUserID <> '' then begin
            SupervisorID := '';

            UserSetup.Reset;
            if UserSetup.Get(EmpUserID) then begin
                SupervisorID := UserSetup."Approver ID";
                if SupervisorID <> '' then begin
                    SID := SupervisorID;
                end else begin
                    SID := '';
                end;
            end else begin
                Error('User' + ' ' + EmpUserID + ' ' + 'does not exist in the user setup table');
            end;
        end;
    end;
}

