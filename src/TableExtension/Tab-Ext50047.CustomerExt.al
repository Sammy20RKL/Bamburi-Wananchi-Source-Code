tableextension 50047 "CustomerExt" extends Customer
{
    // DrillDownPageId = "Member List";
    // LookupPageId = "Member List";
    fields
    {

        field(10001; "No. of Approved Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = const(Approved),
                                                        "Client Code" = field("No."),
                                                        "Outstanding Balance" = filter(<> 0)));
            Caption = 'No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10002; "No. of Issued Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = const(Issued),
                                                        "Client Code" = field("No.")));
            Caption = 'No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10003; "No. of Rejected Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = const(Rejected),
                                                        "Client Code" = field("No.")));
            Caption = 'No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10004; "No. of Members Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(<> 0),
                                                                 Substituted = filter(false)));
            Caption = 'No. Members Guaranteed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68000; "Customer Type"; Option)
        {
            OptionCaption = ' ,BOSA, Member,FOSA,STAFF,Investments,Checkoff,Property,MicroFinance';
            OptionMembers = " ",BOSA,Member,FOSA,STAFF,Investments,Checkoff,Property,MicroFinance;
        }
        field(68001; "Registration Date"; Date)
        {
        }
        field(68002; "Current Loan"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = const(Loan),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Document No." = field("Document No. Filter"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68003; "Current Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68004; "Total Repayments"; Decimal)
        {
            Editable = false;
        }
        field(68005; "Principal Balance"; Decimal)
        {
        }
        field(68006; "Principal Repayment"; Decimal)
        {
        }
        field(68008; "Debtors Type"; Option)
        {
            OptionCaption = ' ,Staff,Client,Others';
            OptionMembers = " ",Staff,Client,Others;
        }
        field(68009; Supervisory; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68011; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68012; Status; Option)
        {
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New,Awaiting Withdrawal';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New,"Awaiting Withdrawal";

        }
        field(68013; "FOSA Account"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(68015; "Old Account No."; Code[20])
        {
        }
        field(68016; "Loan Product Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loan Products Setup".Code;
        }
        field(68017; "Employer Code"; Code[50])
        {
            TableRelation = "Sacco Employers".Code;

            trigger OnValidate()
            var
                SCEMPCODE: Record "Sacco Employers";
            begin
                if SCEMPCODE.Get("Employer Code") then begin
                    "Employer Name" := SCEMPCODE.Description;
                end;

            end;
        }
        field(68018; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin


            end;
        }
        field(68019; "E-Mail (Personal)"; Text[50])
        {
        }
        field(68020; "Station/Department"; Code[20])
        {
            TableRelation = "Loans Guarantee Details"."Loan No" where(Name = field("Employer Code"));
        }
        field(68021; "Home Address"; Text[50])
        {
        }
        field(68022; Location; Text[50])
        {
        }
        field(68023; "Sub-Location"; Text[50])
        {
        }
        field(68024; District; Text[50])
        {
        }
        field(68025; "Resons for Status Change"; Text[80])
        {
        }
        field(68026; "Payroll/Staff No"; Code[20])
        {

            trigger OnValidate()
            begin


            end;
        }
        field(68027; "ID No."; Code[50])
        {

            trigger OnValidate()
            begin


            end;
        }
        field(68028; "Mobile Phone No"; Code[50])
        {

            trigger OnValidate()
            begin


            end;
        }
        field(68029; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower;
        }
        field(68030; Signature; Media)
        {
            Caption = 'Signature';
            //SubType = Bitmap;

            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.", "FOSA Account No.");
                if Vend.Find('-') then begin
                    Vend.Signature := Signature;
                    Vend.Modify;
                end;
            end;
        }
        field(68031; "Passport No."; Code[50])
        {
        }
        field(68032; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;

            trigger OnValidate()
            begin


            end;
        }
        field(68033; "Withdrawal Date"; Date)
        {
        }
        field(68034; "Withdrawal Fee"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(68035; "Status - Withdrawal App."; Option)
        {
            CalcFormula = lookup("Membership Withdrawals".Status where("Member No." = field("No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Application,Being Processed,Approved,Rejected,Canceled';
            OptionMembers = " ",Application,"Being Processed",Approved,Rejected,Canceled;

            trigger OnValidate()
            begin

            end;
        }
        field(68036; "Withdrawal Application Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Withdrawal Application Date" <> 0D then
                    "Withdrawal Date" := CalcDate('2M', "Withdrawal Application Date");
            end;
        }
        field(68037; "Investment Monthly Cont"; Decimal)
        {
        }
        field(68038; "Investment Max Limit."; Decimal)
        {
        }
        field(68039; "Current Investment Total"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Application Fee"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(68040; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(68041; "Shares Retained"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Share Capital"),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;

        }
        field(68043; "Registration Fee Paid"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                           "Transaction Type" = const("Registration Fee"),
                                                                           "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68044; "Registration Fee"; Decimal)
        {
        }
        field(68045; "Society Code"; Code[20])
        {
        }
        field(68046; "Insurance Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Benevolent Fund"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68047; "Holiday Contribution"; Decimal)
        {

            trigger OnValidate()
            begin

            end;
        }
        field(78047; "Welfare Contr"; Decimal)
        {
            trigger OnValidate()
            begin

            end;
        }
        field(68048; "Investment B/F"; Decimal)
        {
        }
        field(68049; "Dividend Amount"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = const(dividend),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  Reversed = filter(false),
                                                                  "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68050; "Name of Chief"; Text[50])
        {
        }
        field(68051; "Office Telephone No."; Code[50])
        {
        }
        field(68052; "Extension No."; Code[30])
        {
        }
        field(68053; "Insurance Contribution"; Decimal)
        {

            trigger OnValidate()
            begin
                //Advice:=TRUE;
            end;
        }
        field(68054; Advice; Boolean)
        {
        }
        field(68055; Province; Code[50])
        {
        }
        field(68056; "Previous Share Contribution"; Decimal)
        {
        }
        field(68057; "Un-allocated Funds"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                       "Transaction Type" = const("Unallocated Funds"),
            //                                                       "Posting Date" = field("Date Filter"),
            //                                                       "Document No." = field("Document No. Filter"), "Posting Date" = field("Date Filter"), Reversed = const(false)));




            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Unallocated Funds"),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68058; "Refund Request Amount"; Decimal)
        {
            CalcFormula = sum(Refunds.Amount where("Member No." = field("No.")));
            // Editable = false;
            FieldClass = FlowField;
        }
        field(68059; "Refund Issued"; Boolean)
        {
            Editable = false;
        }
        field(68060; "Batch No."; Code[20])
        {

            trigger OnValidate()
            begin


            end;
        }
        field(68061; "Current Status"; Option)
        {
            OptionMembers = Approved,Rejected;
        }
        field(68062; "Cheque No."; Code[20])
        {
        }
        field(68063; "Cheque Date"; Date)
        {
        }
        field(68064; "Accrued Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68065; "Defaulted Loans Recovered"; Boolean)
        {
        }
        field(68066; "Withdrawal Posted"; Boolean)
        {
        }
        field(68069; "Loan No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("No."));
        }
        field(68070; "Currect File Location"; Code[50])
        {
            CalcFormula = max("File Movement Tracker".Station where("Member No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68071; "Move To1"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68073; "File Movement Remarks"; Text[50])
        {
        }
        field(68076; "Status Change Date"; Date)
        {
        }
        field(68077; "Last Payment Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No."), "Transaction Type" = filter("Deposit Contribution" | "Loan Repayment")
                                                                       ));
            FieldClass = FlowField;
        }
        field(68078; "Discounted Amount"; Decimal)
        {
        }
        field(68079; "Current Savings"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Deposit Contribution"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(68080; "Payroll Updated"; Boolean)
        {
        }
        field(68081; "Last Marking Date"; Date)
        {
        }
        field(68082; "Dividends Capitalised %"; Decimal)
        {

            trigger OnValidate()
            begin
            end;
        }
        field(68083; "FOSA Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment" | "Unallocated Funds"),
                                                                  "Global Dimension 1 Code" = filter('FOSA'), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(68084; "FOSA Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest Due"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(68085; "Formation/Province"; Code[20])
        {

            trigger OnValidate()
            begin


            end;
        }
        field(68086; "Division/Department"; Code[20])
        {
            // TableRelation = Table51516158.Field1;
        }
        field(68087; "Station/Section"; Code[20])
        {
            // TableRelation = Table51516159.Field1;
        }
        field(68088; "Closing Deposit Balance"; Decimal)
        {
        }
        field(68089; "Closing Loan Balance"; Decimal)
        {
        }
        field(68090; "Closing Insurance Balance"; Decimal)
        {
        }
        field(68091; "Dividend Progression"; Decimal)
        {
        }
        field(68092; "Closing Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68093; "Welfare Fund"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(68094; "Discounted Dividends"; Decimal)
        {
        }
        field(68095; "Mode of Dividend Payment"; Option)
        {
            OptionCaption = ' ,FOSA,EFT,Cheque,Defaulted Loan (Capitalised)';
            OptionMembers = " ",FOSA,EFT,Cheque,"Defaulted Loan";
        }
        field(68096; "Qualifying Shares"; Decimal)
        {
        }
        field(68097; "Defaulter Overide Reasons"; Text[60])
        {
        }
        field(68098; "Defaulter Overide"; Boolean)
        {

            trigger OnValidate()
            begin


            end;
        }
        field(68099; "Closure Remarks"; Text[40])
        {
        }
        field(692145; "Bank Account Name"; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(68100; "Bank Account No."; Code[120])
        {
        }
        field(68101; "Bank Code"; Code[120])
        {
            //TableRelation = "Member App Signatories"."Account No";
            // ValidateTableRelation = false;
        }
        field(68102; "Dividend Processed"; Boolean)
        {
        }
        field(68103; "Dividend Error"; Boolean)
        {
        }
        field(68104; "Dividend Capitalized"; Decimal)
        {
        }
        field(68105; "Dividend Paid FOSA"; Decimal)
        {
        }
        field(68106; "Dividend Paid EFT"; Decimal)
        {
        }
        field(68107; "Dividend Withholding Tax"; Decimal)
        {
        }
        field(68109; "Loan Last Payment Date"; Date)
        {
            FieldClass = Normal;
        }
        field(68110; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                          "Transaction Type" = filter("Interest Paid" | "Interest Due"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(68111; "Last Transaction Date"; Date)
        {
            FieldClass = Normal;
        }
        field(68116; "Share Capital"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Share Capital"),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68112; "Account Category"; Option)
        {
            OptionCaption = 'Individual,Joint,Corporate,Group,Junior';
            OptionMembers = Individual,Joint,Corporate,Group,Junior;
        }
        field(68113; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other,Group';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other,Group;
        }
        field(68114; "Source Of Funds"; Option)
        {
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(68115; "MPESA Mobile No"; Code[20])
        {
        }
        field(68120; "Force No."; Code[20])
        {
        }
        field(68121; "Last Advice Date"; Date)
        {
        }
        field(68122; "Advice Type"; Option)
        {
            OptionMembers = " ","New Member","Shares Adjustment","ABF Adjustment","Registration Fees",Withdrawal,Reintroduction,"Reintroduction With Reg Fees";
        }
        field(68140; "Share Balance BF"; Decimal)
        {
        }
        field(68143; "Move to"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));

            trigger OnValidate()
            var
                Approvalsetup: Record "Approvals Set Up";
            begin
                Approvalsetup.Reset;
                Approvalsetup.SetRange(Approvalsetup.Stage, "Move to");
                if Approvalsetup.Find('-') then begin
                    "Move to description" := Approvalsetup.Station;
                end;
            end;
        }
        field(68144; "File Movement Remarks1"; Option)
        {
            OptionCaption = ' ,Reconciliation purposes,Auditing purposes,Refunds,Loan & Signatories,Withdrawal,Risks payment,Cheque Payment,Custody,Document Filing,Passbook,Complaint Letters,Defaulters,Dividends,Termination,New Members Details,New Members Verification';
            OptionMembers = " ","Reconciliation purposes","Auditing purposes",Refunds,"Loan & Signatories",Withdrawal,"Risks payment","Cheque Payment",Custody,"Document Filing",Passbook,"Complaint Letters",Defaulters,Dividends,Termination,"New Members Details","New Members Verification";
        }
        field(68145; "File MVT User ID"; Code[20])
        {
        }
        field(68146; "File MVT Time"; Time)
        {
        }
        field(68147; "File Previous Location"; Code[20])
        {
        }
        field(68148; "File MVT Date"; Date)
        {
        }
        field(68149; "file received date"; Date)
        {
        }
        field(68150; "File received Time"; Time)
        {
        }
        field(68151; "File Received by"; Code[30])
        {
        }
        field(68152; "file Received"; Boolean)
        {
        }
        field(68154; "Change Log"; Integer)
        {
            CalcFormula = count("Change Log Entry" where("Primary Key Field 1 Value" = field("No.")));
            FieldClass = FlowField;
        }
        field(68155; Section; Code[10])
        {
            // TableRelation = if (Section = const('')) Table51516170.Field3;
        }
        field(68156; rejoined; Boolean)
        {
        }
        field(68157; "Job title"; Code[300])
        {
        }
        field(68158; Pin; Code[20])
        {
        }
        field(68160; "Remitance mode"; Option)
        {
            OptionCaption = ',Check off,Cash,Standing Order';
            OptionMembers = ,"Check off",Cash,"Standing Order";
        }
        field(68161; "Terms of Service"; Option)
        {
            OptionCaption = ',Permanent,Temporary,Contract';
            OptionMembers = ,Permanent,"Temporary",Contract;
        }
        field(68162; Comment1; Text[100])
        {
        }
        field(68163; Comment2; Text[100])
        {
        }
        field(68164; "Current file location"; Code[10])
        {
        }
        field(68165; "Work Province"; Code[10])
        {
        }
        field(68166; "Work District"; Code[10])
        {
        }
        field(68167; "Bank Name"; Text[160])
        {
        }
        field(68168; "Bank Branch Code"; Text[60])
        {
        }
        field(68968; "Bank Branch Name"; Text[60])
        {
        }
        field(68169; "Customer Paypoint"; Code[10])
        {
            // Enabled = false;
        }
        field(68170; "Date File Opened"; Date)
        {
        }
        field(68171; "File Status"; Code[10])
        {
        }
        field(68172; "Customer Title"; Code[10])
        {
        }
        field(68174; "Move to description"; Text[30])
        {
        }
        field(68175; Filelocc; Integer)
        {
            CalcFormula = max("File Movement Tracker"."Entry No." where("Member No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68176; "S Card No."; Code[10])
        {
        }
        field(68179; "Loc Description"; Text[100])
        {
            CalcFormula = lookup("File Movement Tracker".Description where("Entry No." = field(upperlimit(Filelocc)),
                                                                            "Member No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68180; "Current Balance"; Decimal)
        {
        }
        field(68181; "Member Transfer Date"; Date)
        {
        }
        field(68182; "Contact Person"; Code[20])
        {
        }
        // field(68183; "Member withdrawable Deposits"; Decimal)
        // {
        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                           "Posting Date" = field("Date Filter"),
        //                                                           "Document No." = field("Document No. Filter"),
        //                                                           "Transaction Type" = const("Insurance Contribution")));
        //     FieldClass = FlowField;
        // }
        field(68184; "Current Location"; Text[60])
        {
        }
        field(68185; "Group Code"; Code[20])
        {
        }
        field(68186; "Monthly contribution"; Decimal)
        {

        }
        field(68187; "Benevolent Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Benevolent Fund"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                    Reversed = Const(false),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68188; "Office Branch"; Code[20])
        {
        }
        field(68189; Department; Code[20])
        {
            //TableRelation = Table51516158.Field1;
        }
        field(68190; Occupation; Text[30])
        {
        }
        field(68191; Designation; Text[30])
        {
        }
        field(68192; "Village/Residence"; Text[50])
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68193; "Incomplete Shares"; Boolean)
        {
            // Enabled = false;
        }
        field(68194; "Contact Person Phone"; Code[30])
        {
        }
        // field(68195; "Development Shares"; Decimal)
        // {
        //     CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                           "Transaction Type" = filter("Xmas Contribution"),
        //                                                           "Posting Date" = field("Date Filter")));
        //     Enabled = false;
        //     FieldClass = FlowField;
        // }
        // field(68196; "Fanikisha savings"; Decimal)
        // {
        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                            "Transaction Type" = filter("Penalty Paid"),
        //                                                            "Posting Date" = field("Date Filter")));
        //     Enabled = false;
        //     FieldClass = FlowField;
        // }
        field(68197; "Old Fosa Account"; Code[50])
        {
        }
        field(68198; "Recruited By"; Code[50])
        {
        }
        field(68200; "ContactPerson Relation"; Code[20])
        {
            // TableRelation = Table50091;
        }
        field(68201; "ContactPerson Occupation"; Code[20])
        {
            // Enabled = false;
        }
        field(68202; "Member No. 2"; Code[20])
        {
        }
        field(6804711; "Holiday Monthly Contribution"; Decimal)
        {

            trigger OnValidate()
            begin

            end;
        }
        field(68199; "Likizo Contribution"; Decimal)
        {


            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Holiday Savings"),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;

            FieldClass = FlowField;
        }
        field(68203; "Alpha Savings"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   // "Transaction Type" = filter(Alpha_savings),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;

            FieldClass = FlowField;
        }

        // field(68204; "Junior Savings One"; Decimal)
        // {


        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                            "Transaction Type" = filter(Junior_1),
        //                                                            "Posting Date" = field("Date Filter"), Reversed = const(false)));



        //     Editable = false;
        //     FieldClass = FlowField;
        // }

        // field(682016; "Junior Savings Two"; Decimal)
        // {

        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                            "Transaction Type" = filter(Junior_2),
        //                                                            "Posting Date" = field("Date Filter"), Reversed = const(false)));
        //     Editable = false;

        //     FieldClass = FlowField;
        // }
        // field(682017; "Junior Savings Three"; Decimal)
        // {
        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                            "Transaction Type" = filter(Junior3),
        //                                                            "Posting Date" = field("Date Filter"), Reversed = const(false)));
        //     Editable = false;

        //     FieldClass = FlowField;
        // }
        field(68206; "Insurance on Shares"; Decimal)
        {
            // Enabled = false;
        }
        field(68207; "Physical States"; Option)
        {
            Enabled = false;
            OptionCaption = 'Normal,Deaf,Blind';
            OptionMembers = Normal,Deaf,Blind;
        }
        field(68208; DIOCESE; Code[30])
        {
            Enabled = false;
        }
        field(68212; "Mobile No. 2"; Code[20])
        {
        }
        field(68213; "Employer Name"; Text[50])
        {
        }
        field(68214; Title; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(68215; Town; Code[30])
        {
            Editable = false;
        }
        field(68222; "Home Town"; Code[30])
        {
            Editable = false;
        }
        field(69038; "Loans Defaulter Status"; Option)
        {
            CalcFormula = lookup("Loans Register"."Loans Category-SASRA" where("Client Code" = field("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(69039; "Home Postal Code"; Code[15])
        {
            TableRelation = "Post Code".Code;
        }
        field(69040; "Total Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment")));
            FieldClass = FlowField;
        }
        field(69041; "No of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(<> 0),
                                                                 Substituted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69042; "Member Found"; Boolean)
        {
        }
        // field(69043; "Housing Title"; Decimal)
        // {
        //     CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                           "Transaction Type" = filter(Junior_2), "Posting Date" = field("Date Filter"), Reversed = const(false),
        //                                                           "Document No." = field("Document No. Filter")));
        //     Enabled = false;
        //     FieldClass = FlowField;
        // }
        field(69044; "Housing Water"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   //    "Transaction Type" = filter(Konza),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(69045; "Housing Main"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   //    "Transaction Type" = filter("Housing Water"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(69046; "Member Can Guarantee  Loan"; Boolean)
        {
        }
        field(69047; "FOSA Account Bal"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("FOSA Account No."),
                                                                           "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                           Reversed = const(false),
                                                                           "Currency Code" = field("Currency Filter"), "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69048; "Rejoining Date"; Date)
        {
        }
        field(69049; "Active Loans Guarantor"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69050; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Substituted Guarantor" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69051; "Member Deposit *3"; Decimal)
        {
        }
        field(69052; "New loan Eligibility"; Decimal)
        {
        }
        field(69053; "Share Certificate No"; Integer)
        {
        }
        field(69054; "Last Share Certificate No"; Integer)
        {
            CalcFormula = max(Customer."Share Certificate No");
            FieldClass = FlowField;
        }
        field(69055; "No Of Days"; Integer)
        {
        }
        field(69056; "Pepea Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Pepea Shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter"), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        // field(69057; "Group Account No"; Code[15])
        // {
        //     // TableRelation = Customer where("Customer Posting Group" = const('MICRO'),
        //     //                                           "Group Account" = const(true));
        //     TableRelation = Customer."No." where("Account Category" = filter(Group | Joint), "Customer Posting Group" = const('MICRO'));
        // }
        // field(69057; "Housing Contribution"; Decimal)
        // {
        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                            "Transaction Type" = filter(Investment),
        //                                                            "Posting Date" = field("Date Filter"),
        //                                                            "Document No." = field("Document No. Filter")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(69060; "Loan Officer Name"; Text[30])
        {
            Editable = true;
        }
        field(69061; "Micro Group Code"; Code[30])
        {
        }
        field(69064; "Account Type"; Option)
        {
            OptionCaption = ' ,Single,Group';
            OptionMembers = " ",Single,Group;
        }
        field(69072; "Repayment Method"; Option)
        {
            OptionCaption = ' ,Amortised,Reducing Balance,Straight Line,Constants,Ukulima Flat';
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line",Constants,"Ukulima Flat";
        }
        field(69073; "Sms Notification"; Boolean)
        {
        }
        field(69074; "Group Account"; Boolean)
        {
        }
        field(69075; "Group Account Name"; Code[50])
        {
        }
        field(69076; "BOSA Account No."; Code[10])
        {
        }
        field(69077; "School Fees Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("COOP Shares"), "Posting Date" = field("Date Filter"), Reversed = const(false),
            //                                                        "Document No." = field("Document No. Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69078; "Monthly Sch.Fees Cont."; Decimal)
        {
        }
        field(69079; PortalPassword; Text[20])
        {
        }
        field(69080; "Monthly ShareCap Cont."; Decimal)
        {
        }
        field(69081; "MICRO Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment" | "Unallocated Funds"),
                                                                  "Global Dimension 1 Code" = filter('MICRO'), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69082; "Fosa Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("FOSA Shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        Reversed = filter(false),
            //                                                        "Document No." = field("Document No. Filter")));
            // FieldClass = FlowField;
        }
        field(69083; "Rejoined By"; Text[100])
        {

        }
        field(69084; "van Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("van Shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        Reversed = filter(false),
            //                                                        "Document No." = field("Document No. Filter")));
            // FieldClass = FlowField;
        }
        field(69085; "Ceep Reg Paid"; Boolean)
        {
        }
        field(69086; "Preferencial Building Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("Preferencial Building Shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        Reversed = filter(false),
            //                                                        "Document No." = field("Document No. Filter")));
            // FieldClass = FlowField;
        }
        field(69087; "Executive Deposits"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter(Executive),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        Reversed = filter(false),
            //                                                        "Document No." = field("Document No. Filter")));
            // FieldClass = FlowField;
        }
        // field(69088; "Housing Deposits"; Decimal)
        // {
        //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
        //                                                            "Transaction Type" = filter(Investment),
        //                                                            "Posting Date" = field("Date Filter"),
        //                                                            Reversed = filter(false),
        //                                                            "Document No." = field("Document No. Filter")));
        //     FieldClass = FlowField;
        // }
        field(69089; "Loan Officer No"; Code[20])
        {
        }
        field(69090; "Direct Recovery Total"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Loan Repayment" | "Interest Paid"),
                                                                   "Document No." = filter('RCV*'),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69091; Membership; Boolean)
        {
        }
        field(69092; "Lift Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("Lift Shares"),
            //                                                        "Posting Date" = field("Date Filter"), Reversed = const(false)));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69093; "Tamba Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("Tamba Shares"),
            //                                                        "Posting Date" = field("Date Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69094; "Changamka Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("Changamka Shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69095; "Kussco Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = const("Kuscco Shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69096; "CIC Shares"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Transaction Type" = filter("CIC shares"),
            //                                                        "Posting Date" = field("Date Filter"),
            //                                                        "Document No." = field("Document No. Filter")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(69097; "Business Loan Officer"; Code[100])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(69098; Board; Boolean)
        {

        }
        field(69099; staff; Boolean)
        {

        }
        field(69100; "Net Dividend Payable"; Decimal)
        {

        }
        field(69101; "Shares Variance"; Decimal)
        {

        }
        field(69102; "Tax on Dividend"; Decimal)
        {

        }
        field(69103; "Div Amount"; Decimal)
        {

        }
        field(69104; "Gross Dividend Amount Payable"; Decimal)
        {

        }
        field(69105; "Member Picture"; Blob)
        {

        }
        field(69106; "Loan Arrears"; Decimal)
        {
            Editable = false;

        }
        field(69107; "Sacco Insider"; Boolean)
        {

        }
        field(69231; "Member Risk Level"; Option)
        {
            OptionCaption = 'Low Risk,Medium Risk,High Risk';
            OptionMembers = "Low Risk","Medium Risk","High Risk";
        }
        field(69232; "Due Diligence Measure"; Text[40])
        {
        }
        field(69233; "Retaine Dividends"; Boolean)
        {

        }
        field(69221; "Length Of Relationship"; Option)
        {
            Description = 'What Is the Lenght Of the Relationship';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 to 1 Year,1 to 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        }

        field(69322; IPRS; Code[20])
        {

        }

        field(69227; "Enquiries Made"; Integer)
        {
            CalcFormula = count("General Equiries." where("Calling For" = const(Enquiry), "Lead Status" = const(Closed), "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69228; "Request Made"; Integer)
        {
            CalcFormula = count("General Equiries." where("Calling For" = const(Request), "Lead Status" = const(Closed), "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69229; "Appreciations Made"; Integer)
        {
            CalcFormula = count("General Equiries." where("Calling For" = const(Appreciation), "Lead Status" = const(Closed), "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69230; "Complains Made"; Integer)
        {
            CalcFormula = count("General Equiries." where("Calling For" = const(Complaint), "Lead Status" = const(Closed), "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69239; "Criticisms Made"; Integer)
        {
            CalcFormula = count("General Equiries." where("Calling For" = const(Criticism), "Lead Status" = const(Closed), "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69240; "Captured By"; Code[100])
        {

        }
        field(69241; "Account Created By"; Code[100])
        {

        }
        field(69242; "Principal Paid"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Loan Repayment"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69243; "Interest Paid"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest paid"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69245; "Group Officer"; Code[100])
        {
            //TableRelation = "Loan Officers Details".Name;
            // CalcFormula = lookup(Customer."Loan Officer Name" where("No." = field("Group Account No")));
            // FieldClass = FlowField;
        }
        field(69246; "Principal Arrears"; Decimal)
        {
            CalcFormula = sum("Loan Classification Calculator"."Principle In Arrears" where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69247; "Interest Arrears"; Decimal)
        {
            CalcFormula = sum("Loan Classification Calculator"."Interest In Arrears" where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69248; "Total Arrears"; Decimal)
        {
            // CalcFormula = sum("Loan Classification Calculator"."Amount In Arrears" where("Client Code" = field("No.")));
            CalcFormula = sum("Loans Register"."Amount in Arrears" where("Client Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(69430; "Non Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //  field(69431; "Account Category"; enum "Memb App Acc Categ")
        // {

        // }
        field(69431; "Date Employed"; Date)
        {

        }
        field(69432; "Guardian No."; Code[50])
        {
            TableRelation = Customer."No.";
            DataClassification = ToBeClassified;

            // trigger OnValidate()
            // begin
            //     Cust.Reset;
            //     Cust.SetRange(Cust."No.", "Guardian No.");
            //     if Cust.Find('-') then begin
            //         "Guardian Name" := Cust.Name;
            //     end;
            // end;
        }
        field(69433; "Guardian Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69434; "Don't Charge Interest"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69435; "Re-instated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69436; "Dormantancy Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69437; "Source of Income Member One"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69438; "Source of IncomeMember Two"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69439; JointRelationship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69440; "Reasontocreatingajointaccount"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69441; "Birth Certficate No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        //
        field(69442; "Registration No"; Code[30])
        {
        }
        field(69443; "ID NO/Passport 2"; Code[30])
        {
        }
        field(69444; "Registration office"; Text[30])
        {
            TableRelation = Location.Code;
        }
        field(69445; "Picture 2"; Blob)
        {
            SubType = Bitmap;
        }
        field(69446; "Signature  2"; Blob)
        {
            SubType = Bitmap;
        }
        field(69447; Title2; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69448; "Mobile No. 3"; Code[20])
        {
        }
        field(69449; "Date of Birth2"; Date)
        {


        }
        field(69450; "Marital Status2"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69451; Gender2; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(69453; "Home Postal Code2"; Code[20])
        {
            TableRelation = "Post Code";


        }
        field(69454; "Home Town2"; Text[60])
        {
        }
        field(69455; "Payroll/Staff No2"; Code[20])
        {
        }
        field(69456; "Employer Code2"; Code[20])
        {
            TableRelation = "Sacco Employers";


        }
        field(69457; "Employer Name2"; Code[50])
        {
        }
        field(69458; "E-Mail (Personal2)"; Text[50])
        {
        }
        field(69459; "Share Of Ownership Two"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69460; "Recruiter Name"; Text[50])
        {
        }
        field(69461; "Second Member Name"; Text[30])
        {
        }
        field(69462; "Share Of Ownership One"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69464; Age; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(69195; "Reason For Membership Withdraw"; Option)
        {

            OptionMembers = ,Relocation,Expulsion,"Financial Constraints","Personal Reasons",Death;
        }
        field(69196; "Alpha Monthly Contribution"; Decimal) { }
        field(69197; "Junior Monthly Contribution"; Decimal) { }
        field(69200; "Dividend Processed Date"; Date) { }
        field(69201; "Receivables Amount"; Decimal)
        {

            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   Reversed = filter(false),
                                                                  "Transaction Type" = filter(" "), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }

        field(69202; "Personal No"; Code[20])
        {

            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.Reset;
                Vend.SetRange("BOSA Account No", "No.");
                if Vend.Find('-') then begin
                    Vend."Personal No." := "Personal No";
                    Vend.Modify;
                end
            end;
        }
        field(69203; "Group Account No"; Code[15])
        {
            TableRelation = Customer."No." where("Group Account" = filter(true));
        }
        field(69204; "Nature Of Business"; Option)
        {
            OptionCaption = 'Sole Proprietorship, Partnership';
            OptionMembers = "Sole Proprietorship"," Partnership";
        }
        field(69205; "FOSA Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(69206; "Expected Monthly Income"; Decimal)
        {
        }
        field(69207; "Industry Type"; Option)
        {
            Description = 'What Is the Industry Type?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 – 1 Year,1 – 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69208; "Lenght Of Relationship"; Option)
        {
            Description = 'What Is the Lenght Of the Relationship';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 to 1 Year,1 to 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69209; "International Trade"; Option)
        {
            Description = 'Is the customer involved in International Trade?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 – 1 Year,1 – 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69210; "Electronic Payment"; Option)
        {
            Description = 'Does the customer engage in electronic payments?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69211; "Accounts Type Taken"; Option)
        {
            Description = 'Which account type is the customer taking?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69212; "Cards Type Taken"; Option)
        {
            Description = 'Which card is the customer taking?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69213; "Others(Channels)"; Option)
        {
            Description = 'Which products or channels is the customer taking?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69214; "No of BD Trainings Attended"; Integer)
        {
            CalcFormula = count("CRM Traineees" where("Member No" = field("No."),
                                                       Attended = filter(true)));
            FieldClass = FlowField;
        }
        field(69216; "House Group Status"; Option)
        {
            OptionCaption = 'Active,Exiting the Group';
            OptionMembers = Active,"Exiting the Group";
        }
        field(69217; "Member Residency Status"; Option)
        {
            Description = 'What is the customer''s residency status?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 – 1 Year,1 – 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69218; "Individual Category"; Option)
        {
            Description = 'What is the customer category?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 – 1 Year,1 – 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69219; Entities; Option)
        {
            Description = 'What is the Entity Type?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 – 1 Year,1 – 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69220; "Jiokoe Savings"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Jiokoe Savings"),
                                                                   Reversed = filter(false),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69222; "Certificate No"; Code[20])
        {
        }
        field(69300; "Member Share Class"; Option)
        {
            OptionCaption = ' ,Class A,Class B';
            OptionMembers = " ","Class A","Class B";
        }
        field(69301; "Last Boosting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69302; "Member House Group"; Code[15])
        {
            TableRelation = "Member House Groups"."Cell Group Code";

            trigger OnValidate()
            var
                ObjCellGroup: Record "Member House Groups";
            begin
                if ObjCellGroup.Get("Member House Group") then begin
                    "Member House Group Name" := ObjCellGroup."Cell Group Name";
                end;
                /*CellGroups.RESET;
                CellGroups.SETRANGE(CellGroups."Cell Group Code","Member Cell Group");
                IF CellGroups.FIND('-') THEN BEGIN
                "Member Cell Group Name":=CellGroups."Cell Group Name";
                END;*/

            end;
        }
        field(69303; "Member House Group Name"; Code[20])
        {
        }
        field(69304; "No Of Group Members."; Integer)
        {
        }
        field(69305; "Total Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(69306; "Existing Loan Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register".Repayment where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69307; "Existing Fosa Loan Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register".Repayment where("Client Code" = field("FOSA Account No.")));
            FieldClass = FlowField;
        }
        field(69308; Disabled; Boolean)
        {
        }
        field(69309; TLoansGuaranteed; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(69310; TLoansGuaranteedS; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(<> 0),
                                                                                  "Self Guarantee" = filter(true)));
            FieldClass = FlowField;
        }
        field(69311; "Member's Residence"; Code[25])
        {
        }
        field(69312; "Date of Employment"; Date)
        {
        }
        field(69313; "Position Held"; Code[15])
        {
        }
        field(69314; Industry; Code[15])
        {
        }
        field(69315; "Business Name"; Code[20])
        {
        }
        field(69316; "Physical Business Location"; Code[15])
        {
        }
        field(69317; "Year of Commence"; Date)
        {
        }
        field(69318; "Identification Document"; Option)
        {
            OptionCaption = 'Nation ID Card,Passport Card,Aliens Card,Birth Certificate,Company Reg. No,Driving License';
            OptionMembers = "Nation ID Card","Passport Card","Aliens Card","Birth Certificate","Company Reg. No","Driving License";
        }
        field(69319; "Referee Member No"; Code[15])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if Cust.Get("Referee Member No") then begin
                    "Referee Name" := Cust.Name;
                    "Referee Mobile Phone No" := Cust."Mobile Phone No";
                    "Referee ID No" := Cust."ID No.";
                end;
            end;
        }
        field(69320; "Referee Name"; Code[30])
        {
            Editable = false;
        }
        field(69321; "Referee ID No"; Code[15])
        {
            Editable = false;
        }
        field(693221; "Referee Mobile Phone No"; Code[15])
        {
            Editable = false;
        }
        field(69323; "Email Indemnified"; Boolean)
        {
        }
        field(69324; "Send E-Statements"; Boolean)
        {
        }
        field(69325; "Terms Of Employment"; Option)
        {
            OptionCaption = ' ,Permanent,Temporary,Contract,Private,Probation';
            OptionMembers = " ",Permanent,"Temporary",Contract,Private,Probation;
        }
        field(69326; "Employment Info"; Option)
        {
            OptionCaption = ' ,Employed,UnEmployed,Contracting,Others';
            OptionMembers = " ",Employed,UnEmployed,Contracting,Others;
        }
        field(69327; "Joint Account Name"; Text[30])
        {
        }
        field(69328; "Application No."; Code[10])
        {
        }
        field(69329; "Member Category"; Option)
        {
            OptionCaption = 'New Application,Account Reactivation,Transfer';
            OptionMembers = "New Application","Account Reactivation",Transfer;
        }
        field(69330; "Pension No"; Code[30])
        {
        }
        field(69331; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69332; "Created By"; Code[40])
        {
        }
        field(69333; "Modified By"; Code[15])
        {
        }
        field(69334; "Modified On"; Date)
        {
        }
        field(69335; "Others Details"; Text[15])
        {
        }
        field(69336; Products; Option)
        {
            OptionCaption = 'BOSA Account,BOSA+Current Account,BOSA+Smart Saver,BOSA+Fixed Deposit,Smart Saver Only,Current Only,Fixed  Deposit Only,Fixed+Smart Saver,Fixed+Current,Current+Smart Saver';
            OptionMembers = "BOSA Account","BOSA+Current Account","BOSA+Smart Saver","BOSA+Fixed Deposit","Smart Saver Only","Current Only","Fixed  Deposit Only","Fixed+Smart Saver","Fixed+Current","Current+Smart Saver";
        }
        field(69337; "Additional Shares"; Decimal)
        {
            //     CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                            "Posting Date" = field("Date Filter"),
            //                                                            "Document No." = field("Document No. Filter"),
            //                                                            "Transaction Type" = const("Additional Shares")));
            //     FieldClass = FlowField;
        }
        field(69338; "Loans Recoverd from Guarantors"; Decimal)
        {
            // CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
            //                                                        "Recovery Transaction Type" = filter("Guarantor Recoverd"),
            //                                                        "Document No." = field("Document No. Filter"),
            //                                                        "Posting Date" = field("Date Filter")));
            //FieldClass = FlowField;
        }
        field(69339; "Assigned System ID"; Code[15])
        {
            TableRelation = User."User Name";
        }
        field(69340; "Member Loan Liability"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Committed Shares" where("Outstanding Balance" = filter(> 0),
                                                                                  "Member No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69341; "Holiday Savings"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter("Holiday Savings"),
                                                                   "Customer No." = field("No."),
                                                                   Reversed = filter(false),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69841; "Welfare Contribution"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter("Welfare Contribution"),
                                                                   "Customer No." = field("No."),
                                                                   Reversed = filter(false),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69342; "Risk Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Benevolent Fund"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   Reversed = filter(false),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69343; "Members Parish"; Code[10])
        {
            TableRelation = "Member's Parishes".Code;

            trigger OnValidate()
            var
                Parishes: Record "Member's Parishes";
            begin
                Parishes.Reset;
                Parishes.SetRange(Parishes.Code, "Members Parish");
                if Parishes.Find('-') then begin
                    "Parish Name" := Parishes.Description;
                    "Member Share Class" := Parishes."Share Class";
                end;
            end;
        }
        field(69344; "Parish Name"; Text[10])
        {
        }
        field(69345; colleges; Code[2])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Checkoff Calender.".Field1;
        }
        field(69346; "Rejoin status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69347; "Bank Charges on processings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69348; "WithholdingTax on gross div"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69349; "Gross Int On Deposits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69350; "Gross Div on share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69351; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69352; "Retiring Age"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69353; "Insider Lending"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69354; "Insider Board"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69355; "Savings Monthly Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Monthly Xmas Contribution';
        }
        field(69357; "Member Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Member,Board,Staff';
            OptionMembers = ,Member,Board,Staff;
        }
        field(69358; meeting; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69359; Password; Text[45])
        {
            DataClassification = ToBeClassified;
        }
        field(69360; "Password Reset Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(69361; "Member Needs House Group"; Boolean)
        {
        }
        field(69362; "Old Payrol Number"; Code[18])
        { }
        field(69363; "Approved By"; Code[15])
        {
        }
        field(69364; "Approved On"; Date)
        {
        }
        field(69366; "FOSA Shares Account No"; Code[15])
        {
        }
        field(69367; "Additional Shares Account No"; Code[13])
        {
        }
        field(69368; "Action On Dividend Earned"; Option)
        {
            OptionCaption = 'Pay to FOSA Account,Capitalize On Deposits,Repay Loans';
            OptionMembers = "Pay to FOSA Account","Capitalize On Deposits","Repay Loans";
        }
        field(69369; "Deposits Account No"; Code[15])
        {
        }
        field(69370; "Share Capital No"; Code[15])
        {
        }
        field(69371; "Benevolent Fund No"; Code[15])
        {
        }
        field(69372; "Loan Recovered From Guarantors"; Code[15])
        {
            CalcFormula = lookup("Member Ledger Entry"."Recoverd Loan" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(69373; "ID Date of Issue"; Date)
        {
        }
        field(69374; "Literacy Level"; Code[10])
        {
        }
        field(69375; "Member Of a Group"; Boolean)
        {
        }
        field(69376; "Any Other Sacco"; Text[10])
        {
        }
        field(69377; "Member class"; Option)
        {
            OptionCaption = ',Class A,Class B';
            OptionMembers = ,"Class A","Class B";
        }
        field(69378; "Card No"; Code[15])
        {
        }
        field(69379; "BRID No"; Code[15])
        {
        }
        field(69380; "Postal Code 3"; Code[15])
        {
            TableRelation = "Post Code";
        }
        field(69381; "Town 3"; Code[15])
        {
        }
        field(69382; "Passport 3"; Code[15])
        {
        }
        field(69384; "Member Parish 3"; Code[10])
        {
        }
        field(69385; "Member Parish Name 3"; Text[10])
        {
        }
        field(69386; "Picture 3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69387; "Signature  3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69388; Title3; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69389; "Mobile No. 3-Joint"; Code[15])
        {
        }
        field(69390; "Date of Birth3"; Date)
        {

            trigger OnValidate()
            var
                GenSetUp: Record "Sacco General Set-Up";
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');


                if "Date of Birth" <> 0D then begin
                    if GenSetUp.Get() then begin
                        if CalcDate(GenSetUp."Min. Member Age", "Date of Birth") > Today then
                            Error('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    end;
                end;
            end;
        }
        field(69391; "Marital Status3"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69392; Gender3; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(69393; Address3; Code[10])
        {
        }
        field(69394; "Home Postal Code3"; Code[10])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Home Postal Code");
                if PostCode.Find('-') then begin
                    "Home Town" := PostCode.City
                end;
            end;
        }
        field(69395; "Home Town3"; Text[10])
        {
        }
        field(69396; "Payroll/Staff No3"; Code[15])
        {
        }
        field(69397; "Employer Code3"; Code[10])
        {
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            var
                Employer: Record "Sacco Employers";
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer.Description;
            end;
        }
        field(69398; "Employer Name3"; Code[20])
        {
        }
        field(69399; "E-Mail (Personal3)"; Text[20])
        {
        }
        field(69400; "Name 3"; Code[20])
        {
        }
        field(69401; "ID No.3"; Code[10])
        {
        }
        field(69402; "Mobile No. 4"; Code[15])
        {
        }
        field(69403; Address4; Code[15])
        {
        }
        field(69407; "Address3-Joint"; Code[15])
        {
        }
        field(69408; "Mobile No. Three"; Code[15])
        {
        }
        field(69409; "Postal Code 2"; Code[10])
        {
            TableRelation = "Post Code";
        }
        field(69410; "Town 2"; Code[20])
        {
        }
        field(69411; "Passport 2"; Code[15])
        {
        }
        field(69412; "Member Parish 2"; Code[10])
        {
            Enabled = false;
        }
        field(69413; "Member Parish Name 2"; Text[10])
        {
            Enabled = false;
        }
        field(69414; "Name of the Group/Corporate"; Text[20])
        {
        }
        field(69415; "Date of Registration"; Date)
        {
        }
        field(69416; "No of Members"; Integer)
        {
        }
        field(69417; "Group/Corporate Trade"; Code[20])
        {
        }
        field(69419; "Contracting Details"; Text[20])
        {
        }
        field(69420; "Death date"; Date)
        {
        }
        field(69421; "Edit Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69422; "Deposit Boosted Date"; Date)
        {
        }
        field(69423; "Deposit Boosted Amount"; Decimal)
        {
        }
        field(69424; "Employment Terms"; Option)
        {
            OptionCaption = ' ,Permanent,Casual';
            OptionMembers = " ",Permanent,Casual;
        }
        field(69425; "Payroll Agency"; Code[10])
        {
        }
        field(69426; "Introduced By"; Code[20])
        {
        }
        field(69427; "Introducer Name"; Text[20])
        {
        }
        field(69428; "Introducer Staff No"; Code[20])
        {
        }
        field(69429; BoostedDate; Date)
        {
        }
        field(69500; BoostedAmount; Decimal)
        {
        }
        field(69501; "Nominee Envelope No."; Code[10])
        {
        }
        field(69502; Defaulter; Boolean)
        {
        }
        field(69503; "Reason for file overstay"; Text[50])
        {
        }
        field(69505; "Folio Number"; Code[20])
        {
        }
        field(69506; "Sacco Branch"; Code[10])
        {
        }
        field(69507; User; Code[20])
        {
            TableRelation = "User Setup";
        }
        field(69508; "Signing Instructions"; Option)
        {
            OptionCaption = 'Any to Sign,Two to Sign,Three to Sign,All to Sign';
            OptionMembers = "Any to Sign","Two to Sign","Three to Sign","All to Sign";
        }
        // field(69509; "Welfare Contribution"; Decimal)
        // {

        //     trigger OnValidate()
        //     begin
        //         //Advice:=TRUE;
        //     end;
        // }
        field(69510; UserId; Code[10])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(69511; "Employer Address"; Code[15])
        {
        }
        field(69512; "Mobile Defaulter"; Boolean)
        {
        }
        field(69513; "P_No"; Code[30])
        {
        }
        field(69514; "Mid-Month Advance"; Decimal)
        {
        }
        field(69515; "Bonus Recovery"; Decimal) { }
        field(69516; "Qualifying Deposits"; Decimal)
        {
        }
        field(695167; "Qualifying share Capital"; Decimal)
        {
        }

    }
    keys
    {
        key(Key235; "Customer Posting Group")
        {
        }
        key(key236; Status)
        { }

    }



}

