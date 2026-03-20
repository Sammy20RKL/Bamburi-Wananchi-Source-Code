
page 56120 "Membership Application List"
{
    ApplicationArea = Basic;
    CardPageID = "Member Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    // SourceTableView = where(Status = const(Open));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Account Type"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Payroll/Staff No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Kin Details";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action1102755012)
                {
                    Caption = '-';
                }
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
                        DocumentType := Documenttype::"Account Opening";
                        ApprovalEntries.SetRecordFilters(Database::"Membership Applications", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                    //Approvalmgt: Codeunit "Export F/O Consolidation";
                    begin
                        if Rec."ID No." <> '' then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", Rec."ID No.");
                            Cust.SetFilter(Cust."Customer Type", '%1|%2', Cust."Customer Type"::Bosa, Cust."Customer Type"::Staff);
                            //Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                            if Cust.Find('-') then begin
                                if Cust."No." <> Rec."No." then
                                    Error('Member has already been created');
                            end;
                        end;

                        Rec.TestField("No. Series");
                        Rec.TestField("Employer Code");
                        Rec.TestField("ID No.");
                        Rec.TestField("Mobile Phone No");
                        //TESTFIELD("E-Mail (Personal)");
                        Rec.TestField("Customer Posting Group");
                        Rec.TestField("Global Dimension 1 Code");
                        // Rec.TestField("Global Dimension 2 Code");
                        /*
                       PictureExists:=Picture.HASVALUE;
                       SignatureExists:=Signature.HASVALUE;

                       IF (PictureExists = FALSE) OR (SignatureExists=FALSE) THEN
                       ERROR('Kindly upload a picture & signature');
                          */

                        if Rec.Status <> Rec.Status::Open then
                            Error(Text001);

                        Doc_Type := Doc_type::"Account Opening";
                        Table_id := Database::"Membership Applications";
                        //if Approvalmgt.SendApproval(Table_id,"No.",Doc_Type,Status)then;
                        //End allocate batch number

                        SrestepApprovalsCodeUnit.SendMembershipApplicationsRequestForApproval(rec."No.", Rec);

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                    //Approvalmgt: Codeunit "Export F/O Consolidation";
                    begin

                        //IF Approvalmgt.CancelAccOpeninApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1102755004)
                {
                    Caption = '       -';
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to approve account application?', false) = true then begin

                            if Rec."ID No." <> '' then begin
                                Cust.Reset;
                                Cust.SetRange(Cust."ID No.", Rec."ID No.");
                                Cust.SetFilter(Cust."Customer Type", '%1|%2', Cust."Customer Type"::Bosa, Cust."Customer Type"::Staff);
                                //  Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                if Cust.Find('-') then begin
                                    if Cust."No." <> Rec."No." then
                                        Error('Member has already been created');
                                end;
                            end;

                            if Rec.Status <> Rec.Status::Approved then
                                Error('This application has not been approved');


                            //IF UPPERCASE("Sent for Approval By")=UPPERCASE(USERID) THEN
                            //.ERROR('Operation denied');

                            //Create BOSA account
                            Cust."No." := '';
                            Cust.Name := Rec.Name;
                            Cust.Address := Rec.Address;
                            Cust."Post Code" := Rec."Postal Code";
                            Cust.County := Rec.City;
                            Cust."Phone No." := Rec."Phone No.";
                            Cust."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            Cust."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            Cust."Customer Posting Group" := Rec."Customer Posting Group";
                            Cust."Registration Date" := Rec."Registration Date";
                            Cust.Status := Cust.Status::Active;
                            Cust."Employer Code" := Rec."Employer Code";
                            Cust."Date of Birth" := Rec."Date of Birth";
                            Cust."Station/Department" := Rec."Station/Department";
                            Cust."E-Mail" := Rec."E-Mail (Personal)";
                            Cust.Location := Rec.Location;
                            Cust."Sub-Location" := Rec."Sub-Location";
                            Cust.District := Rec.District;
                            Cust."Payroll/Staff No" := Rec."Payroll No";
                            Cust."ID No." := Rec."ID No.";
                            Cust."Mobile Phone No" := Rec."Mobile Phone No";
                            Cust."Marital Status" := Rec."Marital Status";
                            Cust."Customer Type" := Cust."customer type";
                            Cust.Gender := Rec.Gender;
                            // Cust.Picture:=Picture;
                            // Cust.Signature:=Signature;
                            Cust."Monthly Contribution" := Rec."Monthly Contribution";
                            Cust."Contact Person" := Rec."Contact Person";
                            Cust."Contact Person Phone" := Rec."Contact Person Phone";
                            Cust."ContactPerson Relation" := Rec."ContactPerson Relation";
                            Cust."Recruited By" := Rec."Recruited By";
                            Cust."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            Cust."Village/Residence" := Rec."Village/Residence";
                            Cust.Insert(true);
                            //Cust.VALIDATE(Cust."ID No.");

                            //CLEAR(Picture);
                            //CLEAR(Signature);
                            //MODIFY;

                            BOSAACC := Cust."No.";

                            /*
                            AcctNo:='001208'+BOSAACC;
                            //Create FOSA account
                            Accounts.INIT;
                            Accounts."No.":=AcctNo;
                            Accounts."Date of Birth":="Date of Birth";
                            Accounts.Name:=Name;
                            Accounts."Creditor Type":=Accounts."Creditor Type"::Account;
                            Accounts."Staff No":="Payroll/Staff No";
                            Accounts."ID No.":="ID No.";
                            Accounts."Mobile Phone No":="Mobile Phone No";
                            Accounts."Registration Date":="Registration Date";
                            Accounts."Post Code":="Post Code";
                            Accounts.County:=City;
                            Accounts."BOSA Account No":=Cust."No.";
                            Accounts.Picture:=Picture;
                            Accounts.Signature:=Signature;
                            Accounts."Passport No.":="Passport No.";
                            Accounts."Company Code":="Employer Code";
                            Accounts.Status:=Accounts.Status::New;
                            Accounts."Account Type":='SAVINGS';
                            Accounts."Date of Birth":="Date of Birth";
                            Accounts."Global Dimension 1 Code":='FOSA';
                            Accounts."Global Dimension 2 Code":="Global Dimension 2 Code";
                            Accounts.Address:=Address;
                            Accounts."Address 2":="Address 2";
                            Accounts."Phone No.":="Phone No.";
                            Accounts."Registration Date":=TODAY;
                            Accounts.Status:=Accounts.Status::Active;
                            Accounts.Section:=Section;
                            Accounts."Home Address":="Home Address";
                            Accounts.District:=District;
                            Accounts.Location:=Location;
                            Accounts."Sub-Location":="Sub-Location";
                            Accounts."Registration Date":=TODAY;
                            Accounts."Monthly Contribution" := "Monthly Contribution";
                            Accounts."E-Mail":="E-Mail (Personal)";
                            //Accounts."Home Page":="Home Page";
                            //Accounts."Savings Account No.":="Savings Account No.";
                            //Accounts."Signing Instructions":="Signing Instructions";
                            //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                            //Accounts."FD Maturity Date":="FD Maturity Date";
                            //Accounts."Electrol Zone Code":="Electrol Zone Code";
                            //Accounts."Departments Code":="Departments Code";
                            //Accounts."Sections Code":="Sections Code";
                            Accounts.INSERT;


                            Accounts.RESET;
                            IF Accounts.GET(AcctNo) THEN BEGIN
                            Accounts.VALIDATE(Accounts.Name);
                            Accounts.VALIDATE(Accounts."Account Type");
                            Accounts.VALIDATE(Accounts."Global Dimension 1 Code");
                            Accounts.VALIDATE(Accounts."Global Dimension 2 Code");
                            Accounts.MODIFY;

                            //Update BOSA with FOSA Account
                            IF Cust.GET(BOSAACC) THEN BEGIN
                            Cust."FOSA Account":=AcctNo;
                            Cust.MODIFY;
                            END;
                            END;
                            */

                            NextOfKinApp.Reset;
                            NextOfKinApp.SetRange(NextOfKinApp."Account No", Rec."No.");
                            if NextOfKinApp.Find('-') then begin
                                repeat
                                    NextOfKin.Init;
                                    NextOfKin."Account No" := BOSAACC;
                                    NextOfKin.Name := NextOfKinApp.Name;
                                    NextOfKin.Relationship := NextOfKinApp.Relationship;
                                    NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                                    NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                                    NextOfKin.Address := NextOfKinApp.Address;
                                    NextOfKin.Telephone := NextOfKinApp.Telephone;
                                    //NextOfKin.Fax:=NextOfKinApp.Fax;
                                    NextOfKin.Email := NextOfKinApp.Email;
                                    NextOfKin."ID No." := NextOfKinApp."ID No.";
                                    NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                                    NextOfKin.Insert;
                                until NextOfKinApp.Next = 0;
                            end;

                            AccountSignApp.Reset;
                            AccountSignApp.SetRange(AccountSignApp."Account No", Rec."No.");
                            if AccountSignApp.Find('-') then begin
                                repeat
                                    AccountSign.Init;
                                    AccountSign."Account No" := AcctNo;
                                    AccountSign.Names := AccountSignApp.Names;
                                    AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                                    AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                                    AccountSign."ID No." := AccountSignApp."ID No.";
                                    AccountSign.Signatory := AccountSignApp.Signatory;
                                    AccountSign."Must Sign" := AccountSignApp."Must Sign";
                                    AccountSign."Must be Present" := AccountSignApp."Must be Present";
                                    AccountSign.Picture := AccountSignApp.Picture;
                                    AccountSign.Signature := AccountSignApp.Signature;
                                    AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                                    //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                    AccountSign.Insert;
                                until AccountSignApp.Next = 0;
                            end;

                            Cust.Reset;
                            if Cust.Get(BOSAACC) then begin
                                Cust.Validate(Cust.Name);
                                //Cust.VALIDATE(Accounts."Account Type");
                                Cust.Validate(Cust."Global Dimension 1 Code");
                                Cust.Validate(Cust."Global Dimension 2 Code");
                                Cust.Modify;
                            end;


                            /*
                            GenSetUp.GET();
                             Notification.CreateMessage('Dynamics NAV',GenSetUp."Sender Address","E-Mail (Personal)",'Member Acceptance Notification',
                                            'Member application '+ "No." + ' has been approved'
                                           + ' (Dynamics NAV ERP)',FALSE);
                             Notification.Send;
                            */

                            Message('Account created successfully.');
                            //END;
                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved By" := UserId;
                            Rec.Modify;
                        end else
                            Error('Not approved');

                    end;
                }
            }
        }
    }



    trigger OnOpenPage()
    begin

        Rec.SetRange("User ID", UserId);
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        Accounts: Record Vendor;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Next Of kin";
        NextofKinFOSA: Record "Members Next Kin Details";
        AccountSign: Record "Member Account Signatories";
        AccountSignApp: Record "Member App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "Member App Next Of kin";
        NOKBOSA: Record "Members Next Kin Details";
        BOSAACC: Code[20];
        NextOfKin: Record "Members Next Kin Details";
        PictureExists: Boolean;
        UserMgt: Codeunit "User Setup Management";
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
        //Notification: Codeunit "SMTP Mail";
        NotificationE: Codeunit Mail;
        MailBody: Text[250];
        ccEmail: Text[1000];
        toEmail: Text[1000];
        GenSetUp: Record "Sacco General Set-Up";
        ClearingAcctNo: Code[20];
        AdvrAcctNo: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
        SignatureExists: Boolean;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
}
