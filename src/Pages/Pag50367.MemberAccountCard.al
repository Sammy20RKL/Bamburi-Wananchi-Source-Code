page 50367 "Member Account Card"
{
    ApplicationArea = Basic;
    Caption = 'Member Card';
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    // PromotedActionCategories = 'Process,Reports,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Customer;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                // //Editable = true;
                Visible = Individual;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID Number';
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    Style = StrongAccent;
                }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field(txtMarital; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                    Visible = txtMaritalVisible;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }

                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Payroll/Staff No"; Rec."Personal No")
                {
                    Caption = 'Payroll Number';
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer';
                    Editable = false;
                }

                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Location';
                    Editable = false;
                }
                field("Village/Residence"; Rec."Village/Residence")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Physical States"; Rec."Physical States")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }

                field("Job Title"; Rec."Job title")
                {
                    ApplicationArea = Basic;
                    Caption = 'Title';
                    Editable = false;
                    Visible = false;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Holiday Contribution"; Rec."Holiday Contribution") { ApplicationArea = Basic; Editable = true; }
                field(PIN; Rec.Pin)
                {
                    ApplicationArea = Basic;
                    Caption = 'KRA PIN';
                    Editable = false;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code"
                )
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code"
                )
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Overide Defaulters");
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');
                    end;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    // Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sms Notification"; Rec."Sms Notification")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Don't Charge Interest"; Rec."Don't Charge Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retaine Dividends"; Rec."Retaine Dividends")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
            }
            group("Group Account Details")
            {
                Visible = groupAcc;
                field(GroupNo; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Group No.';
                }
                field(GroupName; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Group Name';

                }
                field(GroupEmail; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;

                    caption = ' Group Email';

                }
                field(GroupKRAPin; Rec.pin)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;

                    Caption = 'Group KRA Pin';
                }
                field("Mobile Phone No Group"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;


                }
                field("Nature of Business"; Rec."Nature of Business")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group Nature of Business';


                }
                field("Mobile Phone No 2 Group"; Rec."Mobile No. 2")
                {
                    ApplicationArea = Basic;

                }
                field("Group Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                }
                field("Group Recruiter Name"; Rec."Recruiter Name")
                {
                    ApplicationArea = Basic;

                }
            }
            //Joint
            group(JointAccountOne)
            {
                Visible = Jooint;
                Caption = 'Member One Details';
                field("JointNo."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Joint No.';
                }
                field(JointTitle; Rec.Title)
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                }
                field(JoointName; Rec.Name)
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                }
                field("JointID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                }
                field("JointKRA Pin"; Rec.Pin)
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                }
                field(JointAddress; Rec.Address)
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                }
                field("JointE-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;

                }
                field(JoointGender; Rec.Gender)
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                }
                field("JointDate of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }

                field("JointEmployer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';

                }
                field("JointEmployer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';

                }
                field("Share Of Ownership One"; Rec."Share Of Ownership One")
                {
                    ApplicationArea = Basic;

                }
                field("Source of Income Member One"; Rec."Source of Income Member One")
                {
                    ApplicationArea = Basic;

                }
            }

            group(JointAccountTwo)
            {
                Caption = 'Member Two Details';
                Visible = Jooint;
                field("Member Title"; Rec.Title2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Title';

                    ShowMandatory = true;
                }
                field("Second Member Name"; Rec."Second Member Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';

                    ShowMandatory = true;
                }
                field("ID/Passport No"; Rec."ID NO/Passport 2")
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                }
                field("Member Gender"; Rec.Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';

                    ShowMandatory = true;
                }
                field("Marital Status2"; Rec."Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';

                    ShowMandatory = true;
                }
                field("Date of Birth2"; Rec."Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';

                    ShowMandatory = true;
                }
                field("Mobile No. 3"; Rec."Mobile No. 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';

                    ShowMandatory = true;
                }
                field("E-Mail (Personal2)"; Rec."E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail Adress';

                }
                field(Address3; Rec.Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address';

                }
                field("Home Postal Code2"; Rec."Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = ' Postal Code';

                }
                field("Home Town2"; Rec."Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';

                }
                field("Payroll/Staff No2"; Rec."Payroll/Staff No2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll/Staff No';

                }
                field("Employer Code2"; Rec."Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name2"; Rec."Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';

                }
                field("Share Of Ownership Two"; Rec."Share Of Ownership Two")
                {
                    ApplicationArea = Basic;

                }
                field("Source of IncomeMember Two"; Rec."Source of IncomeMember Two")
                {
                    ApplicationArea = Basic;

                }
            }
            group("Joint Information")
            {
                Visible = Jooint;
                field("JointRecruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic;

                }
                field("JointRecruiter Name"; Rec."Recruiter Name")
                {
                    ApplicationArea = Basic;

                }

                field(JointRelationship; Rec.JointRelationship)
                {
                    ApplicationArea = Basic;
                    Caption = 'Relationship';

                }
                field(Reasontocreatingajointaccount; Rec.Reasontocreatingajointaccount)
                {
                    ApplicationArea = Basic;

                    Caption = 'Reason to creating a joint account';
                }
            }
            //Junior
            group(Junior)
            {

                Visible = Junior;

                field("JuniorNo."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Junior Account Application Number';
                }

                field(JuniorName; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Birth Certficate No."; Rec."Birth Certficate No.")
                {
                    ApplicationArea = all;

                }
                field("Guardian No."; Rec."Guardian No.")
                {
                    ApplicationArea = all;

                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }
            group("Other Details")
            {
                Caption = 'Other Details';
                Editable = true;
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Contact Person Phone"; Rec."Contact Person Phone")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Board; Rec.Board)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Supervisory; Rec.Supervisory)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(staff; Rec.staff)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }

                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address';
                    Editable = false;
                    Visible = false;
                }
                field("Mode of Dividend Payment"; Rec."Mode of Dividend Payment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
            }
            group("Member Withdrawal Details")
            {
                Caption = 'Member Withdrawal Details';

                field("Withdrawal Application Date"; Rec."Withdrawal Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Date"; Rec."Withdrawal Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Withdrawal Fee"; Rec."Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason For Membership Withdraw"; Rec."Reason For Membership Withdraw")
                {
                    ApplicationArea = Basic;

                }
                field("Status - Withdrawal App."; Rec."Status - Withdrawal App.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawal Status';
                    Editable = false;
                }
            }
            group("Bank Details")
            {
                Editable = false;

                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                    Caption = ' Bank Name';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Branch"; Rec."Bank Branch Name")
                {
                    ApplicationArea = Basic;
                }
            }
            group("File Movement Tracker")
            {
                Caption = 'File Movement Tracker';
                visible = false;
                field(Filelocc; Rec.Filelocc)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current File Location';
                    Editable = false;
                }
                field("Loc Description"; Rec."Loc Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Move to"; Rec."Move to")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dispatch to:';
                }
                field("Move to description"; Rec."Move to description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic;
                }
                field("File Movement Remarks"; Rec."File Movement Remarks")
                {
                    ApplicationArea = Basic;
                }
                field("File MVT User ID"; Rec."File MVT User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File MVT Date"; Rec."File MVT Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File MVT Time"; Rec."File MVT Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("file Received"; Rec."file Received")
                {
                    ApplicationArea = Basic;
                    Caption = 'File Received';
                    Editable = false;
                }
                field("file received date"; Rec."file received date")
                {
                    ApplicationArea = Basic;
                    Caption = 'File received date';
                    Editable = false;
                }
                field("File received Time"; Rec."File received Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File Received by"; Rec."File Received by")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No Of Days"; Rec."No Of Days")
                {
                    ApplicationArea = Basic;
                    Caption = 'No of Days in Current Locaton';
                    Editable = false;
                }
                field("Reason for file overstay"; Rec."Reason for file overstay")
                {
                    ApplicationArea = Basic;
                }
                field("File Movement Remarks1"; Rec."File Movement Remarks1")
                {
                    ApplicationArea = Basic;
                    Caption = 'File MV General Remarks';
                }
            }

        }
        area(factboxes)
        {
            part(Control1000000021; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Member")
            {
                Caption = '&Member';
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Ledger Entries';
                    Image = CustomerLedger;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = field("No.");
                    RunPageView = sorting("Customer No.");
                    Promoted = true;
                    PromotedCategory = process;

                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                    visible = false;
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = Card;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                    visible = false;
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = ContactPerson;
                    visible = false;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
            }
            group(ActionGroup1102755023)
            {
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Image = Card;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.FindFirst then begin
                            Report.Run(50279, true, false, Cust);
                        end;
                    end;
                }

                action("Members Kin Details List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Members Kin Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Members Kin Details List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Members Beneficiary Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Members Beneficiary Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Members Nominee Details List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Group Account Members")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group Account Register';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = process;
                    RunObject = Page "Bosa Group Customer List";
                    RunPageLink = "Account No" = field("No.");
                    Visible = groupAcc;
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories Details';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");
                }
                action("Member is  a Guarantor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member is a Guarantor';
                    Image = "Report";

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51035, true, false, Cust);
                    end;
                }
                action("Member is  Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member is  Guaranteed';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51031, true, false, Cust); //51031
                    end;
                }
                action("Monthly Contributions")
                {
                    ApplicationArea = Basic;
                    Image = Setup;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Member Monthly Contributions";
                    RunPageLink = "No." = field("No.");
                }
                group(ActionGroup1102755018)
                {
                }
                action("Detailed Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50223, true, false, Cust);
                    end;
                }
                action("Detailed Statement Active Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Active Statement';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50229, true, false, Cust);
                    end;
                }

                action("Detailed Statement Active")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement(Active)';
                    Image = Report;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51046, true, false, Cust);
                    end;
                }
                action("Deposit Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then begin
                            Report.Run(50224, true, false, Cust);
                        END;
                    end;
                }
                action("Shares Statement")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50225, true, false, Cust);
                    end;
                }
                action("Dividend Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then begin
                            Report.Run(50051, true, false, Cust);
                        END;
                    end;
                }
                action("Loans Statement")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50227, true, false, Cust);
                    end;
                }

                action("Loans Perfomance Statement")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        LoansReg: Record "Loans Register";
                    begin
                        LoansReg.Reset();
                        LoansReg.SetRange("Client Code", Rec."No.");
                        LoansReg.SetRange(Source, LoansReg.Source::BOSA);

                        if LoansReg.FindSet() then
                            //Report.Run(50207, true, false, LoansReg)
                            Report.Run(51036, true, false, LoansReg)
                        else
                            Message('No loan performance records found for client %1.', Rec."No.");
                    end;
                }

                action("Member Shares Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Shares Status';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(137, true, false, Cust);
                    end;
                }
                action("Loans Guaranteed Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then begin
                            Report.Run(51031, true, false, Cust);
                        END;
                    end;
                }
                action("Member is a Guarantor")
                {
                    ApplicationArea = basic;
                    Caption = 'Member is a Guarantor';
                    promoted = true;
                    Image = Report2;
                    PromotedCategory = Report;
                    trigger OnAction()
                    begin
                        Cust.Reset();
                        Cust.SetRange(Cust."No.", Rec."No.");
                        If Cust.FindFirst() then
                            Report.Run(51035, true, false, Cust);
                    end;
                }
                action("Create Withdrawal Application")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()

                    begin
                        /* Rec.CalcFields("Current Shares", "Outstanding Balance");

                        if Rec."Current Shares" >= Rec."Outstanding Balance" then begin
                            if Confirm('Are you sure you want to create a Withdrawal Application for this Member', false) = true then begin
                                SwizzsoftFactory.FnCreateMembershipWithdrawalApplication(Rec."No.", Rec."Withdrawal Application Date", Rec."Reason For Membership Withdraw", Rec."Withdrawal Date");
                            end;
                        end else
                            Error('The withdraw Application has been denied'); */
                        Rec.CalcFields(Rec."Current Shares", "Outstanding Balance");
                        if Rec."Current Shares" >= Rec."Outstanding Balance" then begin
                            if Confirm('Are you sure you want to create a Withdrawal Application for this Member', false) = true then begin
                                TbExit.Reset;
                                TbExit.SetRange(TbExit."Member No.", Rec."No.");
                                if TbExit.Find('-') then begin
                                    Error('The withdraw Application already exists.');
                                    CurrPage.Close();
                                end;
                                SwizzsoftFactory.FnCreateMembershipWithdrawalApplication(Rec."No.", Rec."Withdrawal Application Date", Rec."Reason For Membership Withdraw", Rec."Withdrawal Date");
                                Rec.Status := Rec.Status::"Awaiting Withdrawal";
                                Rec.Modify();

                            end;
                        end else
                            Error('The withdraw Application has been denied');

                    end;
                }
                action("Recover Loans from Gurantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recover Loans from Gurantors';
                    Image = "Report";
                    visible = false;

                    trigger OnAction()
                    begin

                        if (Rec."Current Shares" * -1) > 0 then
                            Error('Please recover the loans from the members shares before recovering from gurantors.');

                        if Confirm('Are you absolutely sure you want to recover the loans from the guarantors as loans?') = false then
                            exit;

                        RoundingDiff := 0;

                        //delete journal line
                        Gnljnline.Reset;
                        Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                        Gnljnline.SetRange("Journal Batch Name", 'LOANS');
                        Gnljnline.DeleteAll;
                        //end of deletion

                        TotalRecovered := 0;

                        DActivity := Rec."Global Dimension 1 Code";
                        DBranch := Rec."Global Dimension 2 Code";

                        Rec.CalcFields("Outstanding Balance", "Accrued Interest", "Insurance Fund", "Current Shares");


                        if Rec."Closing Deposit Balance" = 0 then
                            Rec."Closing Deposit Balance" := Rec."Current Shares" * -1;
                        if Rec."Closing Loan Balance" = 0 then
                            Rec."Closing Loan Balance" := Rec."Outstanding Balance" + Rec."FOSA Outstanding Balance";
                        if Rec."Closing Insurance Balance" = 0 then
                            Rec."Closing Insurance Balance" := Rec."Insurance Fund" * -1;
                        Rec."Withdrawal Posted" := true;
                        Rec.Modify;


                        Rec.CalcFields("Outstanding Balance", "Accrued Interest", "Current Shares");



                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Client Code", Rec."No.");
                        LoansR.SetRange(LoansR.Source, LoansR.Source::BOSA);
                        if LoansR.Find('-') then begin
                            repeat

                                LoansR.CalcFields(LoansR."Outstanding Balance", LoansR."Oustanding Interest", LoansR."No. Of Guarantors");

                                //No Shares recovery
                                if LoansR."Recovered Balance" = 0 then begin
                                    LoansR."Recovered Balance" := LoansR."Outstanding Balance";
                                end;
                                LoansR."Recovered From Guarantor" := true;
                                LoansR."Guarantor Amount" := LoansR."Outstanding Balance";
                                LoansR.Modify;

                                if ((LoansR."Outstanding Balance" + LoansR."Oustanding Interest") > 0) and (LoansR."No. Of Guarantors" > 0) then begin

                                    LoanAllocation := ROUND((LoansR."Outstanding Balance") / LoansR."No. Of Guarantors", 0.01) +
                                                    ROUND((LoansR."Oustanding Interest") / LoansR."No. Of Guarantors", 0.01);


                                    LGurantors.Reset;
                                    LGurantors.SetRange(LGurantors."Loan No", LoansR."Loan  No.");
                                    LGurantors.SetRange(LGurantors.Substituted, false);
                                    if LGurantors.Find('-') then begin
                                        repeat


                                            Loans.Reset;
                                            Loans.SetRange(Loans."Client Code", LGurantors."Member No");
                                            Loans.SetRange(Loans."Loan Product Type", 'L07');
                                            Loans.SetRange(Loans.Posted, false);
                                            if Loans.Find('-') then
                                                Loans.DeleteAll;


                                            Loans.Init;
                                            Loans."Loan  No." := '';
                                            Loans.Source := Loans.Source::BOSA;
                                            Loans."Client Code" := LGurantors."Member No";
                                            Loans."Loan Product Type" := 'L07';
                                            Loans.Validate(Loans."Client Code");
                                            Loans."Application Date" := Today;
                                            Loans.Validate(Loans."Loan Product Type");
                                            if (LoansR."Approved Amount" > 0) and (LoansR.Installments > 0) then
                                                Loans.Installments := ROUND((LoansR."Outstanding Balance")
                                                                          / (LoansR."Approved Amount" / LoansR.Installments), 1, '>');
                                            Loans."Requested Amount" := LoanAllocation;
                                            Loans."Approved Amount" := LoanAllocation;
                                            Loans.Validate(Loans."Approved Amount");
                                            Loans."Loan Status" := Loans."loan status"::Approved;
                                            Loans."Issued Date" := Today;
                                            Loans."Loan Disbursement Date" := Today;
                                            Loans."Repayment Start Date" := Today;
                                            Loans."Batch No." := Rec."Batch No.";
                                            Loans."BOSA No" := LGurantors."Member No";
                                            Loans."Recovered Loan" := LoansR."Loan  No.";
                                            Loans.Insert(true);

                                            Loans.Reset;
                                            Loans.SetRange(Loans."Client Code", LGurantors."Member No");
                                            Loans.SetRange(Loans."Loan Product Type", 'L07');
                                            Loans.SetRange(Loans.Posted, false);
                                            if Loans.Find('-') then begin

                                                LineNo := LineNo + 10000;

                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Document No." := 'GL-' + LoansR."Client Code";
                                                GenJournalLine."Posting Date" := Today;
                                                GenJournalLine."External Document No." := LoansR."Loan  No.";
                                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                                GenJournalLine."Account No." := LGurantors."Member No";
                                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                                GenJournalLine.Description := 'Principle Amount';
                                                GenJournalLine.Amount := LoanAllocation;
                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                                GenJournalLine."Loan No" := Loans."Loan  No.";
                                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;


                                                Loans.Posted := true;
                                                Loans.Modify;


                                                //Off Set BOSA Loans

                                                //Principle
                                                LineNo := LineNo + 10000;

                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Document No." := 'GL-' + LoansR."Client Code";
                                                GenJournalLine."Posting Date" := Today;
                                                GenJournalLine."External Document No." := Loans."Loan  No.";
                                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                                GenJournalLine."Account No." := LoansR."Client Code";
                                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                                GenJournalLine.Description := 'Cleared by Guarantor loan: ' + Loans."Loan  No.";
                                                GenJournalLine.Amount := -ROUND(LoansR."Outstanding Balance" / LoansR."No. Of Guarantors", 0.01);
                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                                                GenJournalLine."Loan No" := LoansR."Loan  No.";
                                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;



                                                //Interest
                                                LineNo := LineNo + 10000;

                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Document No." := 'GL-' + LoansR."Client Code";
                                                GenJournalLine."Posting Date" := Today;
                                                GenJournalLine."External Document No." := Loans."Loan  No.";
                                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                                GenJournalLine."Account No." := LoansR."Client Code";
                                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                                GenJournalLine.Description := 'Cleared by Guarantor loan: ' + Loans."Loan  No.";
                                                GenJournalLine.Amount := -ROUND(LoansR."Oustanding Interest" / LoansR."No. Of Guarantors", 0.01);
                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                GenJournalLine."Loan No" := LoansR."Loan  No.";
                                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;



                                                LoansR.Advice := true;
                                                LoansR.Modify;

                                            end;

                                        until LGurantors.Next = 0;
                                    end;
                                end;

                            until LoansR.Next = 0;
                        end;


                        Rec."Defaulted Loans Recovered" := true;
                        Rec.Modify;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                        end;



                        Message('Loan recovery from guarantors posted successfully.');
                    end;
                }
                action("Recover Loans from Deposit")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Recover Loans from Deposit';

                    trigger OnAction()
                    begin
                        if Confirm('Are you absolutely sure you want to recover the loans from member deposit') = false then
                            exit;

                        //"Withdrawal Fee":=1000;

                        //delete journal line
                        Gnljnline.Reset;
                        Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                        Gnljnline.SetRange("Journal Batch Name", 'Recoveries');
                        Gnljnline.DeleteAll;
                        //end of deletion

                        TotalRecovered := 0;
                        TotalInsuarance := 0;

                        DActivity := Rec."Global Dimension 1 Code";
                        DBranch := Rec."Global Dimension 2 Code";
                        Rec.CalcFields("Outstanding Balance", "Accrued Interest", "Current Shares");

                        Rec.CalcFields("Outstanding Balance", "Outstanding Interest", "FOSA Outstanding Balance", "Accrued Interest", "Insurance Fund", "Current Shares");
                        TotalOustanding := Rec."Outstanding Balance" + Rec."Outstanding Interest";
                        // GETTING WITHDRAWAL FEE
                        if (0.15 * (Rec."Current Shares")) > 1000 then begin
                            Rec."Withdrawal Fee" := 1000;
                        end else begin
                            Rec."Withdrawal Fee" := 0.15 * (Rec."Current Shares");
                        end;
                        /*
                       // END OF GETTING WITHDRWAL FEE
                       LineNo:=LineNo+10000;

                       GenJournalLine.INIT;
                       GenJournalLine."Journal Template Name":='GENERAL';
                       GenJournalLine."Journal Batch Name":='Recoveries';
                       GenJournalLine."Line No.":=LineNo;
                       GenJournalLine."Document No.":="No.";
                       GenJournalLine."Posting Date":=TODAY;
                       GenJournalLine."External Document No.":="No.";
                       GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::Member;
                       GenJournalLine."Account No.":="No.";
                       GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                       GenJournalLine.Description:='WITHDRAWAL FEE';
                       GenJournalLine.Amount:="Withdrawal Fee";
                       GenJournalLine.VALIDATE(GenJournalLine.Amount);
                       GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Deposit Contribution";
                       GenJournalLine."Bal. Account No." :='103102';
                       GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                       GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                       GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                       GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                       GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                       IF GenJournalLine.Amount<>0 THEN
                       GenJournalLine.INSERT;


                       TotalRecovered:=TotalRecovered+GenJournalLine.Amount;
                       */

                        Rec."Closing Deposit Balance" := (Rec."Current Shares");


                        if Rec."Closing Deposit Balance" > 0 then begin
                            "Remaining Amount" := Rec."Closing Deposit Balance";

                            LoansR.Reset;
                            LoansR.SetRange(LoansR."Client Code", Rec."No.");
                            LoansR.SetRange(LoansR.Source, LoansR.Source::BOSA);
                            if LoansR.Find('-') then begin
                                repeat
                                    //"AMOUNTTO BE RECOVERED":=0;
                                    LoansR.CalcFields(LoansR."Outstanding Balance", LoansR."Oustanding Interest", LoansR."Loans Insurance");
                                    TotalInsuarance := TotalInsuarance + LoansR."Loans Insurance";
                                until LoansR.Next = 0;
                            end;

                            LoansR.Reset;
                            LoansR.SetRange(LoansR."Client Code", Rec."No.");
                            LoansR.SetRange(LoansR.Source, LoansR.Source::BOSA);
                            if LoansR.Find('-') then begin
                                repeat
                                    "AMOUNTTO BE RECOVERED" := 0;
                                    LoansR.CalcFields(LoansR."Outstanding Balance", LoansR."Oustanding Interest", LoansR."Loans Insurance");



                                    //Loan Insurance
                                    // LineNo := LineNo + 10000;
                                    // GenJournalLine.Init;
                                    // GenJournalLine."Journal Template Name" := 'GENERAL';
                                    // GenJournalLine."Journal Batch Name" := 'Recoveries';
                                    // GenJournalLine."Line No." := LineNo;
                                    // GenJournalLine."Document No." := "No.";
                                    // GenJournalLine."Posting Date" := Today;
                                    // GenJournalLine."External Document No." := "No.";
                                    // GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                    // GenJournalLine."Account No." := "No.";
                                    // GenJournalLine.Validate(GenJournalLine."Account No.");
                                    // GenJournalLine.Description := 'Cleared by deposits: ' + "No.";
                                    // GenJournalLine.Amount := -ROUND(LoansR."Loans Insurance");
                                    // GenJournalLine.Validate(GenJournalLine.Amount);
                                    // GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Paid";
                                    // GenJournalLine."Loan No" := LoansR."Loan  No.";
                                    // GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    // GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    // if GenJournalLine.Amount <> 0 then
                                    //     GenJournalLine.Insert;

                                    /*
                                    LineNo:=LineNo+10000;
                                    GenJournalLine.INIT;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='LOANS';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Document No.":="No.";
                                    GenJournalLine."Posting Date":=TODAY;
                                    GenJournalLine."External Document No.":="No.";
                                    GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::Member;
                                    GenJournalLine."Account No.":="No.";
                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine.Description:='Cleared by deposits: ' + "No.";
                                    GenJournalLine.Amount:=ROUND(LoansR."Loans Insurance");
                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Deposit Contribution";
                                    GenJournalLine."Loan No":=LoansR."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    IF GenJournalLine.Amount<>0 THEN
                                    GenJournalLine.INSERT;*/



                                    /*LoansR.RESET;
                                    LoansR.SETRANGE(LoansR."Client Code","No.");
                                    LoansR.SETRANGE(LoansR.Source,LoansR.Source::BOSA);
                                    IF LoansR.FIND('-') THEN BEGIN
                                    //REPEAT
                                    "AMOUNTTO BE RECOVERED":=0;
                                    LoansR.CALCFIELDS(LoansR."Outstanding Balance",LoansR."Oustanding Interest");*/


                                    //Off Set BOSA Loans
                                    //Interest
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'Recoveries';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine."External Document No." := Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                    GenJournalLine."Account No." := Rec."No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'Interest Capitalized: ' + Rec."No.";
                                    GenJournalLine.Amount := -ROUND(LoansR."Oustanding Interest");
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                    GenJournalLine."Loan No" := LoansR."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;


                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'Recoveries';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine."External Document No." := Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                    GenJournalLine."Account No." := Rec."No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'Interest Capitalized: ' + Rec."No.";
                                    GenJournalLine.Amount := ROUND(LoansR."Oustanding Interest");
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                    GenJournalLine."Loan No" := LoansR."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    PrincipInt := 0;
                                    TotalLoansOut := 0;
                                    Rec."Closing Deposit Balance" := (Rec."Current Shares" - TotalInsuarance);

                                    if "Remaining Amount" > 0 then begin
                                        PrincipInt := (LoansR."Outstanding Balance" + LoansR."Oustanding Interest");
                                        TotalLoansOut := (Rec."Outstanding Balance" + Rec."Outstanding Interest");

                                        //Principle
                                        LineNo := LineNo + 10000;
                                        //"AMOUNTTO BE RECOVERED":=ROUND(((LoansR."Outstanding Balance"+LoansR."Oustanding Interest")/("Outstanding Balance"+"Outstanding Interest")))*"Closing Deposit Balance";
                                        "AMOUNTTO BE RECOVERED" := ROUND((PrincipInt / TotalLoansOut) * Rec."Closing Deposit Balance", 0.01, '=');
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                        GenJournalLine."Journal Batch Name" := 'Recoveries';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Document No." := Rec."No.";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                                        GenJournalLine."Account No." := Rec."No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine.Description := 'Loan Against Deposits: ' + Rec."No.";
                                        if "AMOUNTTO BE RECOVERED" > (LoansR."Outstanding Balance" + LoansR."Oustanding Interest") then begin
                                            if "Remaining Amount" > (LoansR."Outstanding Balance" + LoansR."Oustanding Interest") then begin
                                                GenJournalLine.Amount := -ROUND(LoansR."Outstanding Balance" + LoansR."Oustanding Interest");
                                            end else begin
                                                GenJournalLine.Amount := -"Remaining Amount";

                                            end;

                                        end else begin
                                            if "Remaining Amount" > "AMOUNTTO BE RECOVERED" then begin
                                                GenJournalLine.Amount := -"AMOUNTTO BE RECOVERED";
                                            end else begin
                                                GenJournalLine.Amount := -"Remaining Amount";
                                            end;
                                        end;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                                        GenJournalLine."Loan No" := LoansR."Loan  No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        "Remaining Amount" := "Remaining Amount" + GenJournalLine.Amount;

                                        TotalRecovered := TotalRecovered + ((GenJournalLine.Amount));

                                    end;




                                until LoansR.Next = 0;
                            end;
                        end;
                        //Deposit
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'Recoveries';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := Rec."No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."External Document No." := Rec."No.";
                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Customer;
                        GenJournalLine."Account No." := Rec."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Defaulted Loans Against Deposits';
                        GenJournalLine.Amount := (TotalRecovered - TotalInsuarance) * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;



                        Rec."Defaulted Loans Recovered" := true;
                        Rec.Modify;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'Recoveries');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                        end;



                        Message('Loan recovery from Deposits posted successfully.');

                    end;
                }
                // action("FOSA Statement")
                // {
                //     ApplicationArea = Basic;
                //     Promoted = true;
                //     PromotedCategory = "Report";

                //     trigger OnAction()
                //     begin
                //         Vend.Reset;
                //         Vend.SetRange(Vend."BOSA Account No", "No.");
                //         if Vend.Find('-') then
                //             Report.Run(50248, true, false, Vend);
                //     end;


                // }
                action("Shares Certificate")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50303, true, false, Cust);
                    end;
                }


            }
        }



    }

    trigger OnAfterGetRecord()
    begin
        FosaName := '';
        if Rec."Physical States" = Rec."physical states"::Deaf then begin
            Message('This Member is Deaf')
        end else
            if Rec."Physical States" = Rec."physical states"::Blind then begin
                Message('This Member is Deaf')
            end;

        // if "FOSA Account" <> '' then begin
        //     if Vend.Get("FOSA Account") then begin
        //         FosaName := Vend.Name;
        //     end;
        // end;

        // lblIDVisible := true;
        // lblDOBVisible := true;
        // lblRegNoVisible := false;
        // lblRegDateVisible := false;
        // lblGenderVisible := true;
        // txtGenderVisible := true;
        // lblMaritalVisible := true;
        // txtMaritalVisible := true;

        // if "Account Category" <> "account category"::SINGLE then begin
        //     lblIDVisible := false;
        //     lblDOBVisible := false;
        //     lblRegNoVisible := true;
        //     lblRegDateVisible := true;
        //     lblGenderVisible := false;
        //     txtGenderVisible := false;
        //     lblMaritalVisible := false;
        //     txtMaritalVisible := false;

        // end;
        OnAfterGetCurrRec;

        Statuschange.Reset;
        Statuschange.SetRange(Statuschange."User Id", UserId);
        Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
        if not Statuschange.Find('-') then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Rec.Find(Which);
        CurrPage.Editable := RecordFound or (Rec.GetFilter("No.") = '');
        exit(RecordFound);
    end;

    procedure UpdateControls()
    begin
        if Rec."Account Category" = Rec."account category"::Individual then begin
            groupAcc := false;
            Individual := true;
            Junior := false;
            commonDetails := true;
            Jooint := false;

        end else
            if Rec."Account Category" = Rec."account category"::Junior then begin
                groupAcc := false;
                Junior := true;
                Individual := false;
                Jooint := false;
                commonDetails := true;

            end
            else
                if Rec."Account Category" = Rec."account category"::Group then begin
                    Individual := false;
                    Jooint := false;
                    Junior := false;
                    groupAcc := true;
                end else
                    //Account types.
                    if Rec."Account Category" = Rec."account category"::Joint then begin
                        Individual := false;
                        groupAcc := false;
                        Junior := false;
                        Jooint := true;
                        commonDetails := false;
                    end;
    end;

    trigger OnInit()
    begin
        txtMaritalVisible := true;
        lblMaritalVisible := true;
        txtGenderVisible := true;
        lblGenderVisible := true;
        lblRegDateVisible := true;
        lblRegNoVisible := true;
        lblDOBVisible := true;
        lblIDVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Customer Type" := Rec."customer type"::Member;
        Rec.Status := Rec.Status::Active;
        Rec."Customer Posting Group" := 'BOSA';
        Rec."Registration Date" := Today;
        Rec.Advice := true;
        Rec."Advice Type" := Rec."advice type"::"New Member";
        if GeneralSetup.Get(0) then begin
            Rec."Insurance Contribution" := GeneralSetup."Welfare Contribution";
            Rec."Registration Fee" := GeneralSetup."Registration Fee";

        end;
        OnAfterGetCurrRec;
    end;



    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        ActivateFields;
        /*
        IF NOT MapMgt.TestSetup THEN
          CurrForm.MapPoint.VISIBLE(FALSE);
        */
        UpdateControls

    end;

    var
        //SwizzsoftFactory: Codeunit "SWIZZSFT Factory";
        SwizzsoftFactory: Codeunit "Swizzsoft Factory";
        TbExit: Record "Membership Exist";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        CustomizedCalendar: Record "Customized Calendar Change";
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PictureExists: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        Individual: Boolean;
        groupAcc: Boolean;
        Junior: Boolean;
        Jooint: Boolean;
        commonDetails: Boolean;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        Vend: Record Vendor;
        Cust: Record Customer;
        LineNo: Integer;
        UsersID: Record User;
        GeneralSetup: Record "Sacco General Set-Up";
        Loans: Record "Loans Register";
        AvailableShares: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Accounts: Record Vendor;
        FosaName: Text[50];
        [InDataSet]
        lblIDVisible: Boolean;
        [InDataSet]
        lblDOBVisible: Boolean;
        [InDataSet]
        lblRegNoVisible: Boolean;
        [InDataSet]
        lblRegDateVisible: Boolean;
        [InDataSet]
        lblGenderVisible: Boolean;
        [InDataSet]
        txtGenderVisible: Boolean;
        [InDataSet]
        lblMaritalVisible: Boolean;
        [InDataSet]
        txtMaritalVisible: Boolean;
        AccNo: Code[20];
        Vendor: Record Vendor;
        TotalAvailable: Decimal;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        TotalDefaulterR: Decimal;
        value2: Decimal;
        Value1: Decimal;
        RoundingDiff: Decimal;
        Statuschange: Record "Status Change Permision";
        "WITHDRAWAL FEE": Decimal;
        "AMOUNTTO BE RECOVERED": Decimal;
        "Remaining Amount": Decimal;
        TotalInsuarance: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        FileMovementTracker: Record "File Movement Tracker";
        EntryNo: Integer;
        ApprovalsSetup: Record "Approvals Set Up";
        MovementTracker: Record "Movement Tracker";
        ApprovalUsers: Record "Approvals Users Set Up";
        "Change Log": Integer;
        openf: File;
        FMTRACK: Record "File Movement Tracker";
        CurrLocation: Code[30];
        "Number of days": Integer;
        Approvals: Record "Approvals Set Up";
        Description: Text[30];
        Section: Code[10];
        station: Code[10];
        CoveragePercentStyle: Text;


    procedure ActivateFields()
    begin
    end;

    local procedure OnAfterGetCurrRec()
    begin
        xRec := Rec;
        ActivateFields;
        SetStyles();
    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member Risk Level" <> Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member Risk Level" = Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;
}

