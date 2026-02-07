Page 52221 "Membership Application Card"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    layout
    {
        area(content)
        {
            group("Application Header")
            {
                Caption = 'General Info';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Application No';
                }
                field("Assigned No."; Rec."Assigned No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Assigned No';
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = all;
                    Editable = true;
                    Caption = 'Account Category';
                    trigger OnValidate()
                    begin
                        FnUpdateControls();
                    end;
                }
                field("Application Category"; Rec."Application Category")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Applicant Details")
            {
                Caption = 'Applicant Details';

                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name";//+ ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                    end;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name";//+ ' ' + Rec."Last Name";
                    end;
                }
                field("Surname"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Caption = 'Date Of Birth';
                }
                field(Age; Rec.Age)
                {
                    Editable = false;
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Contact Details")
            {
                field("Address"; Rec.Address)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Telephone Number"; Rec."Secondary Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail Address"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Corporate Details")
            {
                Caption = 'Corporate Details';
                field("Joint Account Name"; Rec."Joint Account Name")
                {
                    ApplicationArea = all;
                    Editable = true;
                    Caption = 'Joint Account Name';
                    Visible = IsJointApplication;
                }
            }
            group("General Info")
            {
                Caption = 'General Info 2';


                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }

                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }


                field("How Did you know about us ?"; Rec."How Did you know of KANISA")
                {
                    ApplicationArea = Basic;
                    Caption = 'How Did you know about Us?';

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                }
                field("Recruiter Name"; Rec."Recruiter Name")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }

                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = all;

                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = all;
                }
                field("Activity Code Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Branch Code Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    // ShowMandatory = true;
                    Editable = true;
                }
                field(Station; Rec.Section)
                {
                    Caption = 'Station';
                    ApplicationArea = Basic;
                }
                field("Station Name"; Rec."Station Name")
                {
                    ApplicationArea = all;
                }
                field("Member's Residence"; Rec."Member's Residence")
                {
                    ApplicationArea = all;
                }
            }
            group("Employment Details")
            {
                Caption = 'Employment Details';
                Visible = true;
                field("Employment Info"; Rec."Employment Info")
                {
                    ApplicationArea = all;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    Visible = MemberIsEmployed;
                }
                field(Department; Rec.Department)
                {
                    Caption = 'Employer Name';
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = MemberIsEmployed;
                }
                field("Terms of Employment"; Rec."Terms of Employment")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = true;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                }
                field("Others Details"; Rec."Others Details")
                {
                    ApplicationArea = all;
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                Visible = true;
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Editable = true;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    // ShowMandatory = true;
                    Editable = false;
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
            }
            group("Applicant Form")
            {
                Caption = 'Application Form';
                Visible = (IsIndividualApplication) AND not (JuniourAccountType);


                field("Country of Residence"; Rec."Home Country")
                {
                    ApplicationArea = Basic;
                    //ShowMandatory = true;
                }
                field("County of Residence"; Rec."County")
                {
                    ApplicationArea = Basic;
                    //ShowMandatory = true;
                }
                // field("Sub County"; Rec."Sub County")
                // {
                //     ApplicationArea = Basic;
                //     ShowMandatory = true;
                // }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                    //ShowMandatory = true;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    ApplicationArea = Basic;
                    //ShowMandatory = true;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Identity Type"; Rec."Identification Document")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Enabled = Not JuniourAccountType;
                }
                field("Identity No"; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Enabled = Not JuniourAccountType;
                }
                field("Registration Type"; Rec."Registration Type")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Enabled = Not JuniourAccountType;
                    trigger OnValidate()
                    begin
                        FnUpdateControls();
                    end;
                }
                group("IsMember")
                {
                    Caption = '';
                    Visible = RegisteringAsMember;
                    field("Monthly Deposits Contribution"; Rec."Monthly Contribution")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                }


                field("Membership Application Date"; Rec."Membership Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Membership Application Status"; Rec."Membership Application Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Member Share Class"; Rec."Member Share Class")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                // field("Member Position"; Rec."Member Position")
                // {
                //     ApplicationArea = Basic;
                //     ShowMandatory = true;
                // }
                field("Type Of Employment"; Rec."Terms of Employment")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Enabled = Not JuniourAccountType;
                    trigger OnValidate()
                    begin
                        FnUpdateControls();
                    end;
                }
                group("IsEmployed")
                {
                    Caption = '';
                    Visible = (MemberIsEmployed) and Not (JuniourAccountType);



                    field(Designation; Rec.Designation)
                    {
                        ApplicationArea = Basic;
                        trigger OnValidate()
                        begin
                        end;
                    }
                }
                group("IsSelfEmployed")
                {
                    Caption = '';
                    Visible = MemberIsSelfEmployed;
                    field(Occupations; Rec.Occupation)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Type Of Activity Engaged';
                        ShowMandatory = true;
                        trigger OnValidate()
                        begin
                        end;
                    }
                    field("KRAPin"; Rec."KRA Pin")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                        Caption = 'KRA Pin';
                    }
                }

            }

        }
        area(factboxes)
        {
            part(Control149; "Applicant Picture")
            {

                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
                // Visible = IsIndividualApplication;
                Enabled = true;

            }
            // part(Control150; "Applicant Document")
            // {
            //     ApplicationArea = all;
            //     SubPageLink = "No." = FIELD("No.");
            //     Visible = IsIndividualApplication;
            //     Enabled = true;
            // }
            part(Control151; "Applicant Signature")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
                //   Visible = (IsIndividualApplication) AND NOT (JuniourAccountType);
                Enabled = true;
            }
            // part(Control152; "Applicant Logo")
            // {
            //     ApplicationArea = all;
            //     SubPageLink = "No." = FIELD("No.");
            //     Visible = (IsCooporateApplication);
            //     Enabled = true;
            // }
        }


    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Select Products")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Products";// "Members Application Products";
                    RunPageLink = "Membership Applicaton No" = field("No.");
                    Caption = 'Applied Products';
                }
                action("Next of Kin Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin Details';
                    Image = Relationship;
                    Promoted = true;
                    Enabled = (IsGroupApplication) OR (IsIndividualApplication) OR (IsJointApplication) and (Not JuniourAccountType);
                    PromotedCategory = Process;
                    RunObject = Page "Membership Applications NOK";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    Enabled = IsIndividualApplication;// (IsGroupApplication) OR (IsCooporateApplication) OR (IsJointApplication) and (Not JuniourAccountType);
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
                // action("Account Guardian")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Account Guardian';
                //     Image = EmployeeAgreement;
                //     Promoted = true;
                //     Enabled = IsIndividualApplication and JuniourAccountType;
                //     PromotedCategory = Process;
                //     RunObject = Page "Account Guardian Application";
                //     RunPageLink = "Application No" = field("No.");
                //     trigger OnAction()
                //     var
                //     begin

                //     end;
                // }
                action("Agent Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Agent';
                    Image = BusinessRelation;
                    Promoted = true;
                    Enabled = IsIndividualApplication and not JuniourAccountType;
                    PromotedCategory = Process;
                    RunObject = Page "Agent applications List";// "Member Agent Applications List";
                    RunPageLink = "Agent Code" = field("No.");
                    trigger OnAction()
                    var
                    begin

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ApprovalCodeunit: Codeunit SwizzsoftApprovalsCodeUnit;
                    begin
                        //Rec.TESTFIELD("Global Dimension 2 Code");
                        Rec.TESTFIELD("Monthly Contribution");

                        /* if Confirm('Are you sure you want to send ' + Format(REC."Full Name") + ' Membership Application for Approval ?') = true then begin
                            ApprovalCodeunit.SendMembershipApplicationsRequestForApproval(rec."No.", Rec);
                            CurrPage.Close();
                        end; */


                        if Confirm('Are you sure to send ' + Format(REC."Full Name") + ' Membership Application for Approval ?', false) = true then begin
                            exit;
                        end else begin
                            ApprovalCodeunit.SendMembershipApplicationsRequestForApproval(rec."No.", Rec);
                            // Commit();

                            CurrPage.Close();
                        end;
                    end;
                }





            }



        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnUpdateControls();
    end;

    trigger OnAfterGetRecord()
    begin
        FnUpdateControls();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
    end;

    trigger OnOpenPage()
    begin
        FnUpdateControls();

    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    var
        Cust: Record Customer;
        Accounts: Record Vendor;
        AcctNo: Code[20];

        Acc: Record Vendor;
        UsersID: Record User;

        BOSAACC: Code[20];
        PictureExists: Boolean;
        text001: label 'Status must be open';
        SystemFactory: Codeunit "Swizzsoft Factory";
        UserMgt: Codeunit "User Setup Management";
        IsIndividualApplication: Boolean;
        IsJointApplication: Boolean;
        IsGroupApplication: Boolean;

        RegisteringAsGroupMember: Boolean;
        RegisteringAsCorporate: Boolean;
        IsCooporateApplication: Boolean;
        MemberIsEmployed: Boolean;
        MemberIsSelfEmployed: Boolean;
        RegisteringAsMember: Boolean;
        IsCustomerType: boolean;
        JuniourAccountType: Boolean;

    Local procedure FnUpdateControls();
    begin
        IsIndividualApplication := false;
        IsGroupApplication := false;
        IsJointApplication := false;
        JuniourAccountType := false;
        IsCooporateApplication := false;
        MemberIsEmployed := false;
        MemberIsSelfEmployed := false;
        RegisteringAsMember := false;
        IsCustomerType := false;
        RegisteringAsGroupMember := false;
        RegisteringAsCorporate := false;
        if (Rec."Account Category" = Rec."Account Category"::Individual) then begin
            IsIndividualApplication := true;
        end;
        if (rec."Account Category" = Rec."Account Category"::Corporate) then begin
            IsJointApplication := true;
            Rec."Global Dimension 1 Code" := 'BOSA';
        end else
            if rec."Employment Info" = rec."Employment Info"::Employed then begin
                MemberIsEmployed := true;
            end;
        //.........
        if rec."Employment Info" = rec."Employment Info"::"Self Employed" then begin
            MemberIsSelfEmployed := true;
        end;
        //.........
        if Rec."Registration Type" = Rec."Registration Type"::New then begin
            RegisteringAsMember := true;
        end else
            // if Rec."Registration Type" = Rec."Registration Type"::Customer then begin
            //     rec."Monthly Deposits Contribution" := 0;
                IsCustomerType := true;
        // end else
        //     if Rec."Registration Type" = Rec."Registration Type"::"Micro Finance" then begin
        //         IsCustomerType := false;
        //     end;
        //..........
        IF Rec."Account Type" = Rec."Account Type"::"Junior Account" THEN begin
            JuniourAccountType := true;
            Rec."Employment Info" := Rec."Employment Info"::" ";
            Rec."Employer Code" := '';
            Rec.Occupation := '';
            Rec.Designation := '';
            Rec."KRA Pin" := '';
            Rec."ID No." := '';
            Rec."Identification Document" := Rec."Identification Document"::"Birth Certificate";
            Rec."Marital Status" := Rec."Marital Status"::Single;
            Rec."Registration Type" := Rec."Registration Type"::New;
            rec."Terms of Employment" := Rec."Terms of Employment"::" ";
        end ELSE
            IF Rec."Account Type" = Rec."Account Type"::Single THEN begin
                JuniourAccountType := false;
            end;
    end;
}

