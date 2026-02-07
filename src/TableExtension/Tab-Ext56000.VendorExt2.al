tableextension 56000 VendorExt2 extends Vendor
{
    fields
    {
        field(689901; "Personal No."; Code[20])
        {
        }
        field(68002; "ID No."; Code[50])
        {
        }
        field(68003; "Last Maintenance Date"; Date)
        {
        }
        field(68004; "Activate Sweeping Arrangement"; Boolean)
        {
        }
        field(68005; "Sweeping Balance"; Decimal)
        {
        }
        field(68006; "Sweep To Account"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(68007; "Fixed Deposit Status"; Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(68008; "Call Deposit"; Boolean)
        {

            trigger OnValidate()
            begin
                if AccountTypes.Get("Account Type") then begin
                    if AccountTypes."Fixed Deposit" = false then
                        Error('Call deposit only applicable for Fixed Deposits.');
                end;
            end;
        }
        field(68009; "Mobile Phone No"; Code[30])
        {

            trigger OnValidate()
            begin

                // Vend.Reset;
                // Vend.SetRange(Vend."Personal No.", "Personal No.");
                // if Vend.Find('-') then
                // Vend.ModifyAll(Vend."Mobile Phone No", "Mobile Phone No");

            end;
        }
        field(68010; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Devorced,Widower,Separated';
            OptionMembers = " ",Single,Married,Devorced,Widower,Separated;
        }
        field(68011; "Registration Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Account Type" = 'FIXED' then begin
                    TestField("Registration Date");
                    "FD Maturity Date" := CalcDate("Fixed Duration", "Registration Date");
                end;
            end;
        }
        field(68012; "BOSA Account No"; Code[20])
        {
        }
        field(68013; Signature; Media)
        {
            Caption = 'Signature';
        }
        field(68014; "Passport No."; Code[20])
        {
        }
        field(68015; "Employer Code"; Code[50])
        {
            Editable = true;
            Enabled = true;
        }
        field(68016; Status; Option)
        {
            OptionCaption = 'Active,Frozen,Closed,Archived,New,Dormant,Deceased,Retired';
            OptionMembers = Active,Frozen,Closed,Archived,New,Dormant,Deceased,Retired;

            trigger OnValidate()
            begin
                if (Status = Status::Active) or (Status = Status::New) then
                    Blocked := Blocked::" "
                else
                    Blocked := Blocked::All
            end;
        }
        field(68017; "Account Type"; Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            begin
                if AccountTypes.Get("Account Type") then begin
                    AccountTypes.TestField(AccountTypes."Posting Group");
                    "Vendor Posting Group" := AccountTypes."Posting Group";
                    "Call Deposit" := false;
                end;
            end;
        }
        field(68018; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Branch,Project';
            OptionMembers = Single,Joint,Corporate,Group,Branch,Project;
        }
        field(68019; "FD Marked for Closure"; Boolean)
        {
        }
        field(68020; "Last Withdrawal Date"; Date)
        {
        }
        field(68021; "Last Overdraft Date"; Date)
        {
        }
        field(68022; "Last Min. Balance Date"; Date)
        {
        }
        field(68023; "Last Deposit Date"; Date)
        {
        }
        field(68024; "Last Transaction Posting Date"; Date)
        {
        }
        field(68025; "Date Closed"; Date)
        {
        }
        field(68026; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                "Loan product Type" = const('24'),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68027; "Expected Maturity Date"; Date)
        {
        }
        field(68028; "ATM Transactions"; Decimal)
        {
            CalcFormula = sum("ATM Transactions".Amount where("Account No" = field("No."),
                                                               Posted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68029; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin

            end;
        }
        field(68030; "Last Transaction Date"; Date)
        {
            AutoFormatType = 1;
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" where("Vendor No." = field("No.")));
            Caption = 'Last Transaction Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68032; "E-Mail (Personal)"; Text[20])
        {
        }
        field(68033; Section; Code[20])
        {
            TableRelation = "Member Section"."No.";
        }
        field(68034; "Card No."; Code[20])
        {
        }
        field(68035; "Home Address"; Text[40])
        {
        }
        field(68036; Location; Text[20])
        {
        }
        field(68037; "Sub-Location"; Text[20])
        {
        }
        field(68038; District; Text[20])
        {
        }
        field(68039; "Resons for Status Change"; Text[25])
        {
        }
        field(68040; "Closure Notice Date"; Date)
        {
        }
        field(68041; "Fixed Deposit Type"; Code[20])
        {
            TableRelation = "Fixed Deposit Type".Code;

            trigger OnValidate()
            begin
                /*IF "Account Type"='FIXED' THEN BEGIN
                  IF FDType.GET("Fixed Deposit Type") THEN BEGIN
                    "FD Maturity Date":=CALCDATE(FDType.Duration,"Fixed Deposit Start Date");
                    "Fixed Deposit Status":="Fixed Deposit Status"::Active;
                
                    IF interestCalc.GET(interestCalc.Code) THEN
                      "Interest rate":=interestCalc."Interest Rate";
                    END;
                  END;
                
                IF "Account Type"='CALLDEPOSIT' THEN BEGIN
                  IF FDType.GET("Fixed Deposit Type") THEN BEGIN
                    "FD Maturity Date":=CALCDATE(FDType.Duration,"Fixed Deposit Start Date");
                    "Fixed Deposit Status":="Fixed Deposit Status"::Active;
                
                    IF interestCalc.GET(interestCalc.Code) THEN
                      "Interest rate":=interestCalc."On Call Interest Rate";
                    END;
                  END;*/

                //TESTFIELD("Registration Date");
                if FDType.Get("Fixed Deposit Type") then
                    "FD Maturity Date" := CalcDate(FDType.Duration, "Fixed Deposit Start Date");
                "Fixed Duration" := FDType.Duration;
                "Fixed duration2" := FDType."No. of Months";
                "FD Duration" := FDType."No. of Months";
                "Fixed Deposit Status" := "fixed deposit status"::Active;

                if interestCalc.Get(interestCalc.Code) then
                    "Interest rate" := interestCalc."Interest Rate";

            end;
        }
        field(68042; "Interest Earned"; Decimal)
        {
            CalcFormula = sum("Interest Buffer"."Interest Amount" where("Account No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68043; "Untranfered Interest"; Decimal)
        {
            CalcFormula = sum("Interest Buffer"."Interest Amount" where("Account No" = field("No."),
                                                                         Transferred = filter(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68044; "FD Maturity Date"; Date)
        {

            trigger OnValidate()
            begin
                /*"FD Duration":="FD Maturity Date"-"Registration Date";
                 "FD Duration":=ROUND("FD Duration"/30,1);
                MODIFY;
                */

            end;
        }
        field(68045; "Savings Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(68046; "Old Account No."; Code[20])
        {
        }
        field(68047; "Salary Processing"; Boolean)
        {
        }
        field(68048; "Amount to Transfer"; Decimal)
        {

            trigger OnValidate()
            begin
                CalcFields(Balance);
                //TESTFIELD("Registration Date");
                /*
                
                IF AccountTypes.GET("Account Type") THEN BEGIN
                IF "Account Type" = 'MUSTARD' THEN BEGIN
                IF "Last Withdrawal Date" = 0D THEN BEGIN
                "Last Withdrawal Date" :="Registration Date";
                MODIFY;
                END;
                
                IF (CALCDATE(AccountTypes."Savings Duration","Last Withdrawal Date") > TODAY) THEN BEGIN
                ERROR('You can only withdraw from this account once in %1.',AccountTypes."Savings Duration")
                END ELSE BEGIN
                IF "Amount to Transfer" > (Balance*0.25) THEN
                ERROR('Amount cannot be more than 25 Percent of the balance. i.e. %1',(Balance*0.25));
                
                END;
                
                END ELSE BEGIN
                IF AccountTypes."Savings Withdrawal penalty" > 0 THEN BEGIN
                IF (CALCDATE(AccountTypes."Savings Duration","Registration Date") > TODAY) THEN BEGIN
                IF ("Amount to Transfer"+ROUND(("Amount to Transfer"*(AccountTypes."Savings Withdrawal penalty")),1,'>')) > Balance THEN
                ERROR('You cannot transfer more than %1.',Balance-ROUND((Balance*(AccountTypes."Savings Withdrawal penalty")),1,'>'));
                
                END;
                
                END ELSE BEGIN
                IF "Amount to Transfer" > Balance THEN
                MESSAGE('Amount cannot be more than the balance.');
                
                END;
                END;
                END;
                  */
                //"Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*"Interest rate"/100)/12)*FDDuration,1);

                if "Account Type" = 'FIXED' then begin
                    interestCalc.Reset;
                    interestCalc.SetRange(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SetRange(interestCalc.Duration, "Fixed Duration");
                    if interestCalc.Find('-') then begin
                        GenSetUp.Get();
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * "Interest rate" / 100) / 365) * FDDuration, 1);
                        "Expected Interest On Term Dep" := "Expected Interest On Term Dep" - ("Expected Interest On Term Dep" * (GenSetUp."Withholding Tax (%)" / 100));
                        if ("Amount to Transfer" < interestCalc."Minimum Amount") or ("Amount to Transfer" > interestCalc."Maximum Amount") then
                            Error('You Cannot Deposit More OR less than the limits');
                    end;
                end;

            end;
        }
        field(68049; Proffesion; Text[20])
        {
        }
        field(68050; "Signing Instructions"; Text[25])
        {
        }
        field(68051; Hide; Boolean)
        {
        }
        field(68052; "Monthly Contribution"; Decimal)
        {
        }
        field(68053; "Not Qualify for Interest"; Boolean)
        {
        }
        field(68054; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(68055; "Fixed Duration"; DateFormula)
        {
            TableRelation = "FD Interest Calculation Crite".Duration where(Code = field("Fixed Deposit Type"));

            trigger OnValidate()
            begin
                if "Account Type" = 'FIXED' then begin
                    //TESTFIELD("Registration Date");
                    //"FD Maturity Date":=CALCDATE("Fixed Duration","Registration Date");
                    "FD Maturity Date" := CalcDate("Fixed Duration", "Fixed Deposit Start Date");
                    //"FD Duration":=FDType.Duration;
                end;



                if "Account Type" = 'FIXED' then begin
                    interestCalc.Reset;
                    interestCalc.SetRange(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SetRange(interestCalc.Duration, "Fixed Duration");
                    if interestCalc.Find('-') then begin
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * interestCalc."Interest Rate" / 100) / 12) * interestCalc."No of Months", 1);
                    end;
                end;

                if "Account Type" = 'CALLDEPOSIT' then begin
                    interestCalc.Reset;
                    interestCalc.SetRange(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SetRange(interestCalc."No of Months", "FD Duration");
                    if interestCalc.Find('-') then begin
                        "Interest rate" := interestCalc."On Call Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * interestCalc."On Call Interest Rate" / 100) / 12) * interestCalc."No of Months", 1);
                    end;
                end;
            end;
        }
        field(68056; "System Created"; Boolean)
        {
        }
        field(68057; "External Account No"; Code[20])
        {
        }
        field(68058; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(68059; Enabled; Boolean)
        {
        }
        field(68060; "Current Salary"; Decimal)
        {
            CalcFormula = sum("Salary Processing Lines".Amount where("Account No." = field("No."),
                                                                      Date = field("Date Filter"),
                                                                      Processed = const(true)));
            FieldClass = FlowField;
        }
        field(68061; "Defaulted Loans Recovered"; Boolean)
        {
        }
        field(68062; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(68063; "EFT Transactions"; Decimal)
        {
            CalcFormula = sum("EFT Details".Amount where("Account No" = field("No."),
                                                          "Not Available" = const(true),
                                                          Transferred = const(false)));
            FieldClass = FlowField;
        }
        field(68064; "Formation/Province"; Code[20])
        {

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."Personal No.", "Personal No.");
                if Vend.Find('-') then begin
                    repeat
                        Vend."Formation/Province" := "Formation/Province";
                        Vend.Modify;
                    until Vend.Next = 0;
                end;
            end;
        }
        field(68065; "Division/Department"; Code[20])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68066; "Station/Sections"; Code[20])
        {
            TableRelation = "Member Section"."No.";
        }
        field(68067; "Neg. Interest Rate"; Decimal)
        {
        }
        field(68068; "Date Renewed"; Date)
        {
        }
        field(68069; "Last Interest Date"; Date)
        {
            CalcFormula = max("Interest Buffer"."Interest Date" where("Account No" = field("No.")));
            Description = 'Check the flowfield';
            FieldClass = FlowField;
        }
        field(68070; "Don't Transfer to Savings"; Boolean)
        {
        }
        field(68071; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other;
        }
        field(68072; "Source Of Funds"; Option)
        {
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(68073; "S-Mobile No"; Code[20])
        {
        }
        field(68074; "FOSA Default Dimension"; Integer)
        {
            CalcFormula = count("Default Dimension" where("Table ID" = const(23),
                                                           "No." = field("No."),
                                                           "Dimension Value Code" = const('FOSA')));
            FieldClass = FlowField;
        }
        field(68094; "ATM Prov. No"; Code[18])
        {
        }
        field(68095; "ATM Approve"; Boolean)
        {

            trigger OnValidate()
            begin
                // if "ATM Approve" = true then begin
                //     StatusPermissions.Reset;
                //     StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                //     StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"ATM Approval");
                //     if StatusPermissions.Find('-') = false then
                //         Error('You do not have permissions to do an Atm card approval');
                //     "Card No." := "ATM Prov. No";
                //     "Atm card ready" := false;
                //     Modify;
                // end;
            end;
        }
        field(68096; "Dividend Paid"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = field("Currency Filter"),
                                                                                   "Document No." = const('DIVIDEND')));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68120; "Force No."; Code[10])
        {
        }
        field(68121; "Card Expiry Date"; Date)
        {
        }
        field(68122; "Card Valid From"; Date)
        {
        }
        field(68123; "Card Valid To"; Date)
        {
        }
        field(69002; Service; Text[10])
        {
        }
        field(69005; Reconciled; Boolean)
        {
        }
        field(69010; "Employer P/F"; Code[10])
        {
        }
        field(69017; "Outstanding Balance"; Decimal)
        {
        }
        field(69018; "Atm card ready"; Boolean)
        {

            trigger OnValidate()
            begin
                // if "Atm card ready" = true then begin
                //     StatusPermissions.Reset;
                //     StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                //     StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Atm card ready");
                //     if StatusPermissions.Find('-') = false then
                //         Error('You do not have permission to change atm status');
                // end;
            end;
        }
        field(69019; "Current Shares"; Decimal)
        {
        }
        field(69020; "Debtor Type"; Option)
        {
            OptionCaption = 'FOSA Account,Micro Finance';
            OptionMembers = "FOSA Account","Micro Finance";
        }
        field(69021; "Group Code"; Code[20])
        {
        }
        field(69022; "Group Account"; Boolean)
        {
        }
        field(69023; "Shares Recovered"; Boolean)
        {
        }
        field(69024; "Group Balance"; Decimal)
        {
        }
        field(69025; "Old Bosa Acc no"; Code[20])
        {
        }
        field(69026; "Group Loan Balance"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter("Loan Repayment" | "Loan Adjustment"),
                                                                   "Group Code" = field("Group Code")));
            FieldClass = FlowField;
        }
        field(69027; CodeDelete; Code[20])
        {
        }
        field(69028; "ContactPerson Occupation"; Code[20])
        {
        }
        field(69029; "ContacPerson Phone"; Text[20])
        {
        }
        field(69031; "ClassB Shares"; Decimal)
        {
        }
        field(69032; "Date ATM Linked"; Date)
        {
        }
        field(69033; "ATM No."; Code[30])
        {
        }
        field(69034; "Reason For Blocking Account"; Text[40])
        {
        }
        field(69035; "Uncleared Loans"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Net Payment to FOSA" where("Account No" = field("No."),
                                                                            Posted = filter(true),
                                                                            "Processed Payment" = filter(false)));
            FieldClass = FlowField;
        }
        field(69036; NetDis; Decimal)
        {
            CalcFormula = sum("Loans Register"."Net Payment to FOSA" where("Account No" = field("No."),
                                                                            "Processed Payment" = filter(false)));
            FieldClass = FlowField;
        }
        field(69037; "Transfer Amount to Savings"; Decimal)
        {
        }
        field(69038; "Notice Date"; Date)
        {
        }
        field(69039; "Account Frozen"; Boolean)
        {
            Editable = false;
        }
        field(69040; "Interest rate"; Decimal)
        {
        }
        field(69041; "Fixed duration2"; Integer)
        {
        }
        field(69042; "FDR Deposit Status Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,New,Renewed,Terminated';
            OptionMembers = " ",New,Renewed,Terminated;
        }
        field(69043; "ATM Expiry Date"; Date)
        {
        }
        field(69044; "ATM Issued"; Boolean)
        {
        }
        field(69045; "ATM Self Picked"; Boolean)
        {
        }
        field(69046; "ATM Collector Name"; Text[20])
        {
        }
        field(69047; "ATM Collector's ID"; Text[20])
        {
        }
        field(69048; "ATM Collector's Mobile"; Text[20])
        {
        }
        field(69049; Test; Code[10])
        {
        }

        field(69082; "Sacco Lawyer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69069; "Modified By"; Code[45])
        {
        }
        field(69050; "Outstanding Loans"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("FOSA Account No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment" | "Loan Adjustment"),
                                                                  "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69051; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("FOSA Account No." = field("No."),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69052; "Cheque Acc. No"; Code[20])
        {
        }
        field(69053; "Home Postal Code"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(69090; "Postal Code 2"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(69091; "Town 2"; Code[20])
        {
        }
        field(69092; "Passport 2"; Code[20])
        {
        }
        field(69093; "Member Parish 2"; Code[20])
        {
        }
        field(69094; "Member Parish Name 2"; Text[20])
        {
        }
        field(69095; "Name of the Group/Corporate"; Text[30])
        {
        }
        field(69096; "Date of Registration"; Date)
        {
        }
        field(69097; "No of Members"; Integer)
        {
        }
        field(69098; "Group/Corporate Trade"; Code[20])
        {
        }
        field(69099; "Certificate No"; Code[20])
        {
        }
        field(69100; "ID No.2"; Code[20])
        {
        }
        field(69101; "Picture 2"; Blob)
        {
            SubType = Bitmap;
        }
        field(69102; "Signature  2"; Blob)
        {
            SubType = Bitmap;
        }
        field(69103; Title2; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69104; "Mobile No. 3"; Code[20])
        {
        }
        field(69105; "Date of Birth2"; Date)
        {

            trigger OnValidate()
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
        field(69106; "Marital Status2"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69107; Gender2; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(69108; "Address3-Joint"; Code[20])
        {
        }
        field(69109; "Home Postal Code2"; Code[20])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                /*PostCode.RESET;
                PostCode.SETRANGE(PostCode.Code,"Home Postal Code2");
                IF PostCode.FIND('-') THEN BEGIN
                "Home Town":=PostCode.City
                END;
                */

            end;
        }
        field(69110; "Home Town2"; Text[20])
        {
        }
        field(69111; "Payroll/Staff No2"; Code[20])
        {
        }
        field(69112; "Employer Code2"; Code[20])
        {
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                /*Employer.GET("Employer Code");
                "Employer Name":=Employer.Description;
                */

            end;
        }
        field(69113; "Employer Name2"; Code[20])
        {
        }
        field(69114; "E-Mail (Personal2)"; Text[20])
        {
        }
        field(69115; "Contact Person Phone"; Code[20])
        {
        }
        field(69116; "ContactPerson Relation"; Code[20])
        {
            TableRelation = "Relationship Types";
        }
        field(69117; "Recruited By"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                /*ve.RESET;
                Cust.SETRANGE(Cust."No.","Recruited By");
                IF Cust.FIND('-') THEN BEGIN
                "Recruiter Name":=Cust.Name;
               END;
               */

            end;
        }
        field(69119; Dioces; Code[10])
        {
        }
        field(69120; "Mobile No. 2"; Code[20])
        {
        }
        field(69121; "Employer Name"; Code[50])
        {
        }
        field(69122; Title; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69123; Town; Code[20])
        {
        }
        field(69124; "Received 1 Copy Of ID"; Boolean)
        {
        }
        field(69125; "Received 1 Copy Of Passport"; Boolean)
        {
        }
        field(69126; "Specimen Signature"; Boolean)
        {
        }
        field(69128; Created; Boolean)
        {
        }
        field(69129; "Incomplete Application"; Boolean)
        {
        }
        field(69130; "Created By"; Text[20])
        {
        }
        field(69131; "Assigned No."; Code[40])
        {
            CalcFormula = lookup(Customer."No." where("ID No." = field("ID No.")));
            FieldClass = FlowField;
        }
        field(69132; "Home Town"; Text[20])
        {
        }
        field(69133; "Recruiter Name"; Text[20])
        {
        }
        field(69134; "Copy of Current Payslip"; Boolean)
        {
        }
        field(69135; "Member Registration Fee Receiv"; Boolean)
        {
        }
        field(69137; "Copy of KRA Pin"; Boolean)
        {
        }
        field(69138; "Contact person age"; Date)
        {

            trigger OnValidate()
            begin
                /* IF "Contact person age" > TODAY THEN
                 ERROR('Age cannot be greater than today');
                
                
                IF "Contact person age" <> 0D THEN BEGIN
                IF GenSetUp.GET() THEN BEGIN
                IF CALCDATE(GenSetUp."Min. Member Age","Contact person age") > TODAY THEN
                ERROR('Contact person should be atleast 18years and above %1',GenSetUp."Min. Member Age");
                END;
                END;  */

            end;
        }
        field(69139; "First member name"; Text[20])
        {
        }
        field(69140; "Date Establish"; Date)
        {
        }
        field(69141; "Registration No"; Code[20])
        {
        }
        field(69142; "Self Recruited"; Boolean)
        {
        }
        field(69143; "Relationship With Recruiter"; Code[20])
        {
        }
        field(69144; "Application Category"; Option)
        {
            OptionCaption = 'New Application,Rejoining,Transfer';
            OptionMembers = "New Application",Rejoining,Transfer;
        }
        field(69145; "Members Parish"; Code[15])
        {
            TableRelation = "Member's Parishes".Code;

            trigger OnValidate()
            begin
                Parishes.Reset;
                Parishes.SetRange(Parishes.Code, "Members Parish");
                if Parishes.Find('-') then begin
                    "Parish Name" := Parishes.Description;
                end;
            end;
        }
        field(69146; "Parish Name"; Text[20])
        {
        }
        field(69147; "Employment Info"; Option)
        {
            OptionCaption = ' ,Employed,UnEmployed,Contracting,Others';
            OptionMembers = " ",Employed,UnEmployed,Contracting,Others;
        }
        field(69148; "Contracting Details"; Text[20])
        {
        }
        field(69149; "Others Details"; Text[20])
        {
        }
        field(69150; "Contact Person"; Code[20])
        {
        }
        field(69151; "Office Telephone No."; Code[10])
        {
        }
        field(69152; "Extension No."; Code[10])
        {
        }
        field(69153; "On Term Deposit Maturity"; Option)
        {

            OptionMembers = " ","Pay to Current_ Deposit+Interest","Roll Back Deposit+Interest","Roll Back Deposit Only ";
        }
        field(69154; "Member's Residence"; Code[30])
        {
        }
        field(69155; "Joint Account Name"; Code[25])
        {
        }
        field(69156; "Postal Code 3"; Code[20])
        {
            TableRelation = "Post Code";
        }
        field(69157; "Town 3"; Code[20])
        {
        }
        field(69158; "Passport 3"; Code[20])
        {
        }
        field(69159; "Member Parish 3"; Code[20])
        {
        }
        field(69160; "Member Parish Name 3"; Text[15])
        {
        }
        field(69161; "Picture 3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69162; "Signature  3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69163; Title3; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69164; "Mobile No. 3-Joint"; Code[15])
        {
        }
        field(69165; "Date of Birth3"; Date)
        {

            trigger OnValidate()
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
        field(69166; "Marital Status3"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69167; Gender3; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(69168; Address3; Code[15])
        {
        }
        field(69169; "Home Postal Code3"; Code[15])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Home Postal Code");
                if PostCode.Find('-') then begin
                    "Home Town" := PostCode.City
                end;
            end;
        }
        field(69170; "Home Town3"; Text[15])
        {
        }
        field(69171; "Payroll/Staff No3"; Code[15])
        {
        }
        field(69172; "Employer Code3"; Code[20])
        {
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                /*Employer.GET("Employer Code");
                "Employer Name":=Employer.Description;
                */

            end;
        }
        field(69173; "Employer Name3"; Code[15])
        {
        }
        field(69174; "E-Mail (Personal3)"; Text[15])
        {
        }
        field(69175; "Name 3"; Code[20])
        {
        }
        field(69176; "ID No.3"; Code[15])
        {
        }
        field(69177; "Mobile No. 4"; Code[15])
        {
        }
        field(69178; Address4; Code[15])
        {
        }
        field(69179; "Expected Interest On Term Dep"; Decimal)
        {
        }
        field(69180; "Current Account Balance"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("Savings Account No."),
                                                                                   "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = field("Currency Filter")));
            FieldClass = FlowField;
        }
        field(69181; "Allowable Cheque Discounting %"; Decimal)
        {
        }
        field(69182; "Cheque Discounted"; Decimal)
        {
        }
        field(69183; "Mobile Transactions"; Decimal)
        {
            CalcFormula = sum("Mobile Transactions".Amount where("Account No" = field("No."),
                                                                  Posted = filter(false),
                                                                  Status = filter(Pending | Completed)));
            FieldClass = FlowField;
        }
        field(69184; "Staff Account"; Boolean)
        {
        }
        field(69185; "Debt Collector"; Boolean)
        {
        }
        field(69186; "Debt Collector %"; Decimal)
        {
        }
        field(69187; "Comission On Cheque Discount"; Decimal)
        {
        }
        field(69188; "Fixed Deposit Start Date"; Date)
        {
        }
        field(69189; "Prevous Fixed Deposit Type"; Code[15])
        {
        }
        field(69190; "Prevous FD Start Date"; Date)
        {
        }
        field(69191; "Prevous Fixed Duration"; DateFormula)
        {
        }
        field(69192; "Prevous Expected Int On FD"; Decimal)
        {
        }
        field(69193; "Prevous FD Maturity Date"; Date)
        {
        }
        field(69194; "Prevous FD Deposit Status Type"; Option)
        {
            OptionMembers = Matured;
        }
        field(69195; "Prevous Interest Rate FD"; Decimal)
        {
        }
        field(69196; "Last Interest Earned Date"; Date)
        {
            CalcFormula = max("Interest Buffer"."Interest Date" where("Account No" = field("No.")));
            FieldClass = FlowField;
        }
        field(69197; "Last Salary Earned"; Decimal)
        {
        }
        field(69198; "Reason for Freezing Account"; Code[15])
        {
        }
        field(69199; "Account Frozen By"; Code[15])
        {
        }
        field(69200; "Fixed Deposit Certificate No."; Code[15])
        {
        }
        field(69201; "E-Loan Qualification Amount"; Decimal)
        {
        }
        field(69202; "Pension No"; Code[15])
        {
        }
        field(69203; "Doublicate Accounts"; Boolean)
        {
        }
        field(69204; "Assigned System ID"; Code[15])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(69205; "Prevous Blocked Status"; Option)
        {
            OptionCaption = ' ,Payment,All';
            OptionMembers = " ",Payment,All;
        }
        field(69206; "Untransfered interest Savings"; Decimal)
        {
            CalcFormula = sum("Interest Buffer Savings"."Interest Amount" where("Account No" = field("No."),
                                                                                 Transferred = filter(false)));
            FieldClass = FlowField;
        }
        field(69207; "Sacco No"; Code[30])
        {
        }
        field(69208; "Account Book Balance"; Decimal)
        {
            CalcFormula = sum("Detailed Vendor Ledg. Entry".Amount where("Vendor No." = field("No."),
                                                                          "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69209; "Statement Page Nos"; Integer)
        {
        }
        field(69210; "Activated By"; Code[10])
        {
        }
        field(69211; "Outstanding Loan FOSA"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "FOSA Account No." = field("No."),
                                                                  "Loan No" = filter('F*')));
            FieldClass = FlowField;
        }
        field(69212; "Outstanding Interest FOSA"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("FOSA Account No." = field("No."),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Loan No" = filter('F*')));
            FieldClass = FlowField;
        }
        field(69213; "Member Position"; Option)
        {
            OptionCaption = 'Member,Director,Supervisory Committee,Management Staff';
            OptionMembers = Member,Director,"Supervisory Committee","Management Staff";
        }
        field(69214; "Pension Processiong"; Boolean)
        {
        }
        field(69215; "Dormant Date"; Date)
        {
        }
        field(69216; "Dormant Time"; Time)
        {
        }
        field(69217; "Dormancy Date"; Date)
        {
        }
        field(69218; "Salary Account"; Boolean)
        {
            CalcFormula = exist("Salary Processing Lines" where("Account No." = field("No.")));
            FieldClass = FlowField;
        }
        field(51516066; "Account Balance"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907002; "FOSA Balance"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter"), "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6927905; "Total Active Loans"; Integer)
        {
            CalcFormula = count("Loans Register" WHERE("Account No" = FIELD("No."), "Total Loan" = filter(<> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(690906; "Total Debits"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Debit Amount" WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter"), "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907007; "Total Credits"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Credit Amount" WHERE("Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter"), "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907008; "Amount Transfered?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6907009; "Date Transfered"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6907010; "Transferred By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6907011; Revoked; Boolean)
        {
            Editable = false;
        }
        field(6907012; "FD Interest Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6907013; "Fixed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6907014; "Duration"; DateFormula)
        {

            Editable = false;

        }
        field(6907015; "Withdrawal Before Maturity Charges"; Decimal)
        {

            Editable = false;

        }
        field(6907016; "Tax Rate %"; Decimal)
        {

            Editable = false;

        }
        field(6907017; "Upon Maturity"; Option)
        {
            OptionCaption = ' ,Close the FXD against the Account,Roll-over the FXD and refix the Principal,Roll-over the FXD and refix the Principal and Interest';
            OptionMembers = " ","Close the FXD against the Account","Roll-over the FXD and refix the Principal","Roll-over the FXD and refix the Principal and Interest";
        }
        field(6907018; "Computed Interest"; Decimal)
        {

            Editable = false;

        }
        field(6907019; "Tax"; Decimal)
        {

            Editable = false;

        }
        field(69230; "Full Name"; Text[100])
        {

        }
        field(69231; "First Name"; Text[100])
        {

        }
        field(69232; "Middle Name"; Text[100])
        {

        }
        field(69233; "Last Name"; Text[100])
        {

        }
        field(69234; "Country of Residence"; Text[100])
        {

        }
        field(69235; "County of Residence"; Text[100])
        {

        }
        field(69236; "Sub County"; Text[100])
        {

        }
        field(69237; "Identity Type"; Enum "Member Identity Type")
        {
            NotBlank = true;
            trigger OnValidate()
            begin

            end;
        }
        field(69240; "How Did you know about us ?"; enum HowDidYouKnowUs)
        {
        }
        field(69241; "Registration Type"; enum "Application Category")
        {
            trigger OnValidate()
            begin

            end;
        }

        field(69242; "Receive Notifications"; Boolean)
        {
        }
        field(69243; "Type Of Employment"; enum "Type Of Employment")
        {
        }
        field(69244; Account; enum AccountTypeToOpen)
        {
            trigger OnValidate()
            begin

            end;
        }
        field(69245; "Birth Certificate No"; Code[50])
        {
            NotBlank = true;
            trigger OnValidate()
            begin

            end;
        }
        field(69246; "IPRS Status"; Enum "IPRS Verifications Status's")
        {

        }
        field(69247; "IPRS Significance"; Integer)
        {

        }
        field(69070110; "Net Interest"; Decimal)
        {

            Editable = false;

        }
        field(69070111; "Exempted From Tax"; Boolean)
        {

        }
        field(69070112; "FD Duration"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                interestCalc: Record "FD Interest Calculation Crite";
                FDDuration: Integer;
            begin
                /* IF "Account Type"='FIXED' THEN
                  "FD Maturity Date":="Registration Date"+("FD Duration"*30);
                  MODIFY;*/
                /*
               interestCalc.RESET;
               interestCalc.SETRANGE(interestCalc.Code,"Fixed Deposit Type");
               interestCalc.SETRANGE(interestCalc."No of Months","FD Duration");
               IF interestCalc.FIND('-') THEN BEGIN
               "Interest rate":=interestCalc."Interest Rate";
               END;
               */
                IF "Account Type" = 'FIXED' THEN BEGIN
                    TESTFIELD("Registration Date");
                    "FD Maturity Date" := CALCDATE(format("FD Duration") + 'M', TODAY);
                    //"FD Maturity Date":=CALCDATE("FD Duration",TODAY);
                END;


                IF "Account Type" = 'FIXED' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc."No of Months", "FD Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        "Expected Interest On Term Dep" := ROUND((("Amount to Transfer" * interestCalc."Interest Rate" / 100) / 12) * interestCalc."No of Months", 1);
                    END;
                END;

                IF "Account Type" = 'CALLDEPOSIT' THEN BEGIN
                    interestCalc.RESET;
                    interestCalc.SETRANGE(interestCalc.Code, "Fixed Deposit Type");
                    interestCalc.SETRANGE(interestCalc."No of Months", "FD Duration");
                    IF interestCalc.FIND('-') THEN BEGIN
                        "Interest rate" := interestCalc."On Call Interest Rate";
                        FDDuration := interestCalc."No of Months";
                        //"Expected Interest On Term Dep":=ROUND((("Amount to Transfer"*interestCalc."On Call Interest Rate"/100)/12)*interestCalc."No of Months",1);
                    END;
                END;

            end;
        }
        //......... .........
        field(69070113; "Outstanding BOSA Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Customer No." = field("BOSA Account No"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69070114; "Outstanding BOSA Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                          "Transaction Type" = filter("Interest Paid" | "Interest Due"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(68083; "FOSA Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"), Reversed = const(false), "Loan Type" = filter(<> 'GROUPLOAN')));
            FieldClass = FlowField;
        }
        field(68084; "FOSA Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"), Reversed = const(false), "Loan Type" = filter(<> 'GROUPLOAN')));
            FieldClass = FlowField;
        }
        field(68226; "MICRO Outstanding Principle"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Customer No." = field("No."), "Loan Type" = filter('GROUPLOAN')));
            FieldClass = FlowField;
        }
        field(68227; "MICRO Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Customer No." = field("No."), "Loan Type" = filter('GROUPLOAN')));
            FieldClass = FlowField;
        }
        field(68228; "Member Shares Retained"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                   "Transaction Type" = const("Share Capital"),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Share Capital';
        }
        field(68229; "Member Deposits"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"),
                                                                   "Transaction Type" = const("Deposit Contribution"),
                                                                   "Posting Date" = field("Date Filter"), Reversed = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        // field(50100; "Balance (LCY, Excl. Reversed)"; Decimal)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where(
        //         "Vendor No." = field("No."),
        //         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
        //         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
        //         "Currency Code" = field("Currency Filter"),
        //         Reversed = const(false)));   // 👈 exclude reversed
        //     Caption = 'Balance (LCY, Excl. Reversed)';
        //     Editable = false;
        // }
    }

    fieldgroups
    {
        addlast(DropDown; "ID No.", "Mobile Phone No")
        {

        }

    }
    VAR
        FDType: Record "Fixed Deposit Type";
        ReplCharge: Decimal;
        Vends: Record Vendor;
        gnljnlLine: Record "Gen. Journal Line";
        FOSAAccount: Record Vendor;
        Member: Record Customer;
        Vend: Record Vendor;
        Loans: Record "Loans Register";
        StatusPermissions: Record "Status Change Permision";
        interestCalc: Record "FD Interest Calculation Crite";
        GenSetUp: Record "Sacco General Set-Up";
        Parishes: Record "Member's Parishes";
        FDDuration: Integer;
        AccountTypes: record "Account Types-Saving Products";
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.';
        Text002: label 'You have set %1 to %2. Do you want to update the %3 price list accordingly?';
        Text003: label 'Do you wish to create a contact for %1 %2?';
        PurchSetup: Record "Purchases & Payables Setup";
        CommentLine: Record "Comment Line";
        PostCode: Record "Post Code";
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        RMSetup: Record "Marketing Setup";
        ServiceItem: Record "Service Item";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        Text004: label 'Contact %1 %2 is not related to vendor %3 %4.';
        Text005: label 'post';
}
