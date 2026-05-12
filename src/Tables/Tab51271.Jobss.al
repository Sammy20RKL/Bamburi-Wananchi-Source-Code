#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51271 Jobss
{
    Caption = 'Job';
    DataCaptionFields = "No.", Description;
    // DrillDownPageID = 53926;
    // LookupPageID = 53926;


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin

            end;
        }
        field(2; "Search Description"; Code[250])
        {
            Caption = 'Search Description';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := Description;
                TestField("Approval Status", "approval status"::Open);
            end;
        }
        field(4; "Description 2"; Text[80])
        {
            Caption = 'Description 2';
        }
        field(5; "Bill-to Partner No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';

            trigger OnValidate()
            begin
                if ("Bill-to Partner No." = '') or ("Bill-to Partner No." <> xRec."Bill-to Partner No.") then
                    if JobLedgEntryExist or JobPlanningLineExist then
                        Error(Text000, FieldCaption("Bill-to Partner No."), TableCaption);
                //UpdateCust;
            end;
        }
        field(12; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(13; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                //CheckDate;
            end;
        }
        field(14; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                if "Period of Performance" = "period of performance"::"Open Ended" then Error('You cannot insert and end date if status is open ended');
                //CheckDate;
            end;
        }
        field(19; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Concept Formulation,Proposal,Contract,Project,Completed';
            OptionMembers = "Concept Formulation",Proposal,Contract,Project,Completed;

            trigger OnValidate()
            var
            begin
                if xRec.Status <> Status then begin
                    if Status = Status::Project then
                        Validate(Complete, true);
                    if xRec.Status = xRec.Status::Project then begin
                        if Dialog.Confirm(Text004) then
                            Validate(Complete, false)
                        else begin
                            Status := xRec.Status;
                        end;
                    end;
                end;
            end;
        }
        field(20; "Person Responsible"; Code[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource;
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
                Modify;
            end;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
                Modify;
            end;
        }
        field(23; "Job Posting Group"; Code[10])
        {
            Caption = 'Kind of Program';
            TableRelation = "Job-Posting Group";
        }
        field(24; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Posting,All';
            OptionMembers = " ",Posting,All;
        }
        field(29; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(16), "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(32; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(49; "Scheduled Res. Qty."; Decimal)
        {
            Caption = 'Scheduled Res. Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(51; "Posting Date Filter"; Date)
        {
            Caption = 'Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(55; "Resource Gr. Filter"; Code[20])
        {
            Caption = 'Resource Gr. Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(56; "Scheduled Res. Gr. Qty."; Decimal)
        {
            Caption = 'Scheduled Res. Gr. Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(58; "Bill-to Name"; Text[100])
        {
            Caption = 'Bill-to Name';
        }
        field(59; "Bill-to Address"; Text[50])
        {
            Caption = ' Address';
        }
        field(60; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Email Address';
            ExtendedDatatype = EMail;
        }
        field(61; "Bill-to City"; Text[50])
        {
            Caption = 'Bill-to City';
        }
        field(63; County; Text[30])
        {
            CalcFormula = lookup(Customer.County where("No." = field("Bill-to Partner No.")));
            Caption = 'County';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(66; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(67; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            Editable = true;
            TableRelation = "Country/Region";
        }
        field(68; "Bill-to Name 2"; Text[50])
        {
            CalcFormula = lookup(Customer."Name 2" where("No." = field("Bill-to Partner No.")));
            Caption = 'Bill-to Name 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000; Contractor; Option)
        {
            Caption = 'Contractor';
            OptionCaption = ' ,Prime Contractor,Sub Contractor';
            OptionMembers = " ","Prime Contractor","Sub Contractor";
        }
        field(1001; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Currency Code" <> xRec."Currency Code" then
                    if not JobLedgEntryExist then
                        CurrencyUpdatePlanningLines
                    else
                        Error(Text000, FieldCaption("Currency Code"), TableCaption);

                TestField("Approval Status", "approval status"::Open);
            end;
        }
        field(1002; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';

            trigger OnLookup()
            begin
                if ("Bill-to Partner No." <> '') and Cont.Get("Bill-to Contact No.") then
                    Cont.SetRange("Company No.", Cont."Company No.")
                else
                    if Cust.Get("Bill-to Partner No.") then begin
                        ContBusinessRelation.Reset;
                        ContBusinessRelation.SetCurrentkey("Link to Table", "No.");
                        ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."link to table"::Customer);
                        ContBusinessRelation.SetRange("No.", "Bill-to Partner No.");
                        if ContBusinessRelation.Find('-') then
                            Cont.SetRange("Company No.", ContBusinessRelation."Contact No.");
                    end else
                        Cont.SetFilter("Company No.", '<>''''');

                if "Bill-to Contact No." <> '' then
                    if Cont.Get("Bill-to Contact No.") then;
            end;

            trigger OnValidate()
            begin
                if Blocked >= Blocked::Posting then
                    Error(Text000, FieldCaption("Bill-to Contact No."), TableCaption);

                if ("Bill-to Contact No." <> xRec."Bill-to Contact No.") and
                   (xRec."Bill-to Contact No." <> '')
                then begin
                    if ("Bill-to Contact No." = '') and ("Bill-to Partner No." = '') then begin
                        Init;
                        "No. Series" := xRec."No. Series";
                        Validate(Description, xRec.Description);
                    end;
                end;

                if ("Bill-to Partner No." <> '') and ("Bill-to Contact No." <> '') then begin
                    Cont.Get("Bill-to Contact No.");
                    ContBusinessRelation.Reset;
                    ContBusinessRelation.SetCurrentkey("Link to Table", "No.");
                    ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."link to table"::Customer);
                    ContBusinessRelation.SetRange("No.", "Bill-to Partner No.");
                    if ContBusinessRelation.Find('-') then
                        if ContBusinessRelation."Contact No." <> Cont."Company No." then
                            Error(Text005, Cont."No.", Cont.Name, "Bill-to Partner No.");
                end;
                UpdateBillToCust("Bill-to Contact No.");
            end;
        }
        field(1003; "Bill-to Contact"; Text[50])
        {
            Caption = 'Bill-to Contact';
        }
        field(1004; "Planning Date Filter"; Date)
        {
            Caption = 'Planning Date Filter';
            FieldClass = FlowFilter;
        }
        field(1005; "Total WIP Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total WIP Cost Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1006; "Total WIP Cost G/L Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total WIP Cost G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1007; "WIP Posted To G/L"; Boolean)
        {
            Caption = 'WIP Posted To G/L';
            Editable = false;
        }
        field(1008; "WIP Posting Date"; Date)
        {
            Caption = 'WIP Posting Date';
            Editable = false;
        }
        field(1009; "WIP G/L Posting Date"; Date)
        {
            Caption = 'WIP G/L Posting Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1010; "Posted WIP Method Used"; Option)
        {
            Caption = 'Posted WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(1011; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            TableRelation = Currency;
        }
        field(1012; "Exch. Calculation (Cost)"; Option)
        {
            Caption = 'Exch. Calculation (Cost)';
            OptionCaption = 'Fixed LCY,Fixed FCY';
            OptionMembers = "Fixed LCY","Fixed FCY";
        }
        field(1013; "Exch. Calculation (Price)"; Option)
        {
            Caption = 'Exch. Calculation (Price)';
            OptionCaption = 'Fixed FCY,Fixed LCY';
            OptionMembers = "Fixed FCY","Fixed LCY";
        }
        field(1014; "Allow Schedule/Contract Lines"; Boolean)
        {
            Caption = 'Allow Schedule/Contract Lines';
        }
        field(1015; Complete; Boolean)
        {
            Caption = 'Complete';

            trigger OnValidate()
            begin
                if Complete <> xRec.Complete then
                    ChangeJobCompletionStatus;
            end;
        }
        field(1016; "Calc. WIP Method Used"; Option)
        {
            Caption = 'Calc. WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(1017; "Amount Awarded"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Awarded';
            Editable = true;
            FieldClass = Normal;
        }
        field(1018; "Recog. Sales G/L Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recog. Sales G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1019; "Recog. Costs Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recog. Costs Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1020; "Recog. Costs G/L Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recog. Costs G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1021; "Total WIP Sales Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total WIP Sales Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1022; "Total WIP Sales G/L Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total WIP Sales G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1023; "Completion Calculated"; Boolean)
        {
            Caption = 'Completion Calculated';
            FieldClass = FlowField;
        }
        field(1024; "Next Invoice Date"; Date)
        {
            Caption = 'Next Invoice Date';
            FieldClass = FlowField;
        }
        field(50000; "Grant Phases"; Code[10])
        {
        }
        field(50001; "Approval Status"; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50002; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center BR";
        }
        field(50003; "Total Cost"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Total Cost(LCY)"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Contract Description"; Text[150])
        {
        }
        field(50006; "Contract Type"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(50007; "Disbursed Amount"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50008; "Allow OverExpenditure"; Boolean)
        {
        }
        field(50009; "Accounted Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Received Amount"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50011; "Proposal No"; Code[20])
        {
            Editable = false;
            TableRelation = Jobs."No." where("No." = field("Proposal No"), Status = const(Proposal));
        }
        field(50012; "Converted To Proposal"; Boolean)
        {
            Editable = false;
        }
        field(50013; "Project No"; Code[20])
        {
            Editable = true;
            TableRelation = Jobs."No." where("No." = field("Project No"), Status = const(Contract));
        }
        field(50014; "Converted To Project"; Boolean)
        {
            Editable = true;
        }
        field(50015; "Concept Number"; Code[20])
        {
        }
        field(50016; Objective; Text[150])
        {
        }
        field(50017; "Contract No"; Code[20])
        {
        }
        field(50018; "Reporting dates generated"; Boolean)
        {

        }
        field(50019; "Condition for budget realloca"; Code[10])
        {
        }
        field(50020; "Principal Investigator"; Text[100])
        {
            TableRelation = Resource;

            trigger OnValidate()
            begin

            end;
        }
        field(50021; "Expected Receipt Amount"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50022; Partners; Boolean)
        {
            Caption = 'Collaborative Grants';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "Project Location"; Text[70])
        {
        }
        field(50024; "Income Account"; Code[10])
        {
        }
        field(50025; "Concept Approval Date"; DateTime)
        {
            Editable = false;
        }
        field(50026; "Project Filter"; Code[10])
        {
            FieldClass = Normal;
        }
        field(50027; Title; Text[30])
        {
        }
        field(50028; "Project Coordinator"; Text[100])
        {
            TableRelation = Resource;
        }
        field(50029; Task; Option)
        {
            OptionCaption = ' ,Research,Service';
            OptionMembers = " ",Research,Service;
        }
        field(50030; "Project Status"; Option)
        {
            OptionCaption = 'Setup,In Progress,Halted,Completed';
            OptionMembers = Setup,"In Progress",Halted,Completed;
        }
        field(50031; "Audit Indicator"; Boolean)
        {
        }
        field(50032; "Approved Funding Start Date"; Date)
        {
        }
        field(50033; "Approved Funding End Date"; Date)
        {
        }
        field(50034; "Justification Narration"; Text[200])
        {
            Description = 'Narrations defined esp. when modifying  the project/contract info';
        }
        field(50035; "Amount Invoiced"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(50036; "Grant Level"; Option)
        {
            OptionCaption = 'Grant,Sub-Grant';
            OptionMembers = Grant,"Sub-Grant";
        }
        field(50037; "RSPO No."; Code[30])
        {
        }
        field(50038; "Alert sent"; Boolean)
        {
        }
        field(50039; "Proposal Application due Date"; Date)
        {
        }
        field(50040; Submission; Option)
        {
            OptionCaption = ' ,Paper Submission,Electronic Submission';
            OptionMembers = " ","Paper Submission","Electronic Submission";
        }
        field(50041; "PI Name"; Text[100])
        {
            Caption = 'PI At Collaborative Institution';
            TableRelation = "PI Master";

            trigger OnValidate()
            begin

            end;
        }
        field(50042; "PI Address"; Text[30])
        {
        }
        field(50043; "PI Telephone"; Text[30])
        {
        }
        field(50044; "PI EMail"; Text[30])
        {
            ExtendedDatatype = EMail;
        }
        field(50045; "Collaborative Grant"; Boolean)
        {
        }
        field(50046; "IREC Approval"; Option)
        {
            OptionCaption = 'Pending Approval,Approved,Exempt';
            OptionMembers = "Pending Approval",Approved,Exempt;
        }
        field(50047; "IREC Approval Date"; Date)
        {
        }
        field(50048; "Cost Share"; Boolean)
        {
        }
        field(50049; "Cost Share Details"; Text[100])
        {
        }
        field(50050; Matching; Boolean)
        {
        }
        field(50051; "Matching Details"; Text[150])
        {
        }
        field(50052; "Application disposition Status"; Option)
        {
            OptionCaption = ' ,Signed By Institutions Authorities,Returned to PI,Forwarded to funding Agency';
            OptionMembers = " ","Signed By Institutions Authorities","Returned to PI","Forwarded to funding Agency";
        }
        field(50053; "SubAward No."; Code[20])
        {
            Description = 'Project Sub award';
        }
        field(50054; "Payment Methods"; Code[20])
        {
            TableRelation = "Payment Method".Code;
        }
        field(50055; Schools; Code[10])
        {
            Caption = 'Kind of Program';
        }
        field(50056; "Application Due Date"; Date)
        {
        }
        field(50057; "Funding Request"; Boolean)
        {
        }
        field(50058; Budget; Boolean)
        {
        }
        field(50059; "Budget Justification"; Boolean)
        {
        }
        field(50060; "Project Summary Abstract"; Boolean)
        {
        }
        field(50061; "RSPO Completion List"; Boolean)
        {
        }
        field(50062; Donors; Boolean)
        {
            FieldClass = FlowField;
        }
        field(50063; Workplan; Boolean)
        {
            FieldClass = FlowField;
        }
        field(50064; "Period of Performance"; Option)
        {
            OptionMembers = "Multiple Years","One Year","Open Ended";

            trigger OnValidate()
            begin
                if "Period of Performance" = "period of performance"::"Open Ended" then "Ending Date" := 0D;
            end;
        }
        field(50065; "Principal Investigator name"; Text[100])
        {
        }
        field(50066; "Response To fund Opportunity"; Boolean)
        {
        }
        field(50067; "Main Donor"; Code[50])
        {
        }
        field(50068; "Main Sub"; Code[50])
        {
        }
        field(50069; "Special Contract Provision"; Text[250])
        {
        }
        field(50070; "Funding Agency No."; Code[20])
        {
        }
        field(50071; "Type Of Funding"; Option)
        {
            OptionCaption = ',Discretionary,Donations,Supplimental Funds,Others';
            OptionMembers = ,Discretionary,Donations,"Supplimental Funds",Others;
        }
        field(50072; "Responsible Officer"; Code[50])
        {
            TableRelation = "HR Employees"."No." where("Grant/Compliance Officer" = const(true));
        }
        field(50073; "RFA/A Receipt Date"; Date)
        {
        }
        field(50074; "Project Team"; Code[20])
        {
            TableRelation = "Resource Group"."No.";
        }
        field(50075; Institution; Option)
        {
            OptionCaption = ' ,MTRH,MU,OTHERS';
            OptionMembers = " ",MTRH,MU,OTHERS;
        }
        field(50076; "Moi/MTRH Collaborator"; Boolean)
        {
            Caption = 'Do you have a previous Collaboration with Moi/MTRH ?';
        }
        field(50077; "AMPATH Affiliation Consortium"; Boolean)
        {
        }
        field(50078; "Previous MU Consortium School?"; Boolean)
        {
        }
        field(50079; "Which MU Consortium School"; Text[50])
        {
        }
        field(50080; "ASANTE Collaborator?"; Boolean)
        {
        }
        field(50081; "ASANTE Collaborator Details"; Text[50])
        {
        }
        field(50082; "Assist identifying Collabotor?"; Boolean)
        {
        }
        field(50083; "Study Type"; Option)
        {
            OptionCaption = ' ,Retrospective Cohort,Propective Cohort,Clinical trial,Others';
            OptionMembers = " ","Retrospective Cohort","Propective Cohort","Clinical trial",Others;
        }
        field(50084; "Study Type Details"; Text[50])
        {
        }
        field(50085; "Brief Description of Study"; Text[20])
        {
        }
        field(50086; "Study Funded"; Boolean)
        {
        }
        field(50087; "Funding Source/Funding Sought"; Text[50])
        {
        }
        field(50088; "Application Deadline"; Date)
        {
        }
        field(50089; "Lab Services"; Boolean)
        {

            trigger OnValidate()
            begin

            end;
        }
        field(50090; "AMPATH Data Mgt Core Required"; Boolean)
        {
        }
        field(50091; "Contracted To"; Text[150])
        {
            Description = 'Added:'' for capturing details of subs in commas form  -came up during data import';
        }
        field(50092; "Biostats Core Required"; Boolean)
        {
        }
        field(50093; "Prime Institution"; Code[50])
        {
            Description = 'Added:'' for capturing details prime institution -came up during data import';
        }
        field(50094; "Workgroup Recomendation"; Option)
        {
            OptionCaption = ' ,Do not support further Development,Support further Development,Support Study and feel no further input is needed';
            OptionMembers = " ","Do not support further Development","Support further Development","Support Study and feel no further input is needed";
        }
        field(50095; "Recomendation Description"; Text[50])
        {
        }
        field(50096; "Approved Budget Start Date"; Date)
        {
        }
        field(50097; "Approved Budget End Date"; Date)
        {
        }
        field(50098; "Financial Reporting Due Date"; DateFormula)
        {
        }
        field(50099; "Technical  Reporting Due Date"; DateFormula)
        {
        }
        field(50100; "Obligated Amount"; Decimal)
        {
            CalcFormula = sum(Committment.Amount where("Shortcut Dimension 2 Code" = field("No.")));
            Description = 'An alert to be provided when the grant expenditure is 95% of the project expenditure';
            FieldClass = FlowField;
        }
        field(50101; "Re:"; Text[100])
        {
        }
        field(50102; "System Contract No"; Code[20])
        {
        }
        field(50103; "Converted To Contract"; Boolean)
        {
        }
        field(50104; "Indirect Cost"; Boolean)
        {
        }
        field(50105; "Allowed Indirect Cost"; Decimal)
        {
        }
        field(50106; "Consistence with inst. Objs."; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Description")
        {
        }
        key(Key3; "Bill-to Partner No.")
        {
        }
        key(Key4; Description)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
    begin

    end;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        TestField("Approval Status", "approval status"::Open);
    end;

    var
        Text000: label 'You cannot change %1 because one or more entries are associated with this %2.';

        PostCode: Record "Post Code";
        Cust: Record Customer;
        Cont: Record Contact;
        ContBusinessRelation: Record "Contact Business Relation";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        Text003: label 'You must run the %1 and %2 functions to create and post the completion entries for this job.';
        Text004: label 'This will delete any unposted WIP entries for this job and allow you to reverse the completion postings for this job.\\Do you wish to continue?';
        Text005: label 'Contact %1 %2 is related to a different company than customer %3.';
        Text006: label 'Contact %1 %2 is not related to customer %3.';
        Text007: label 'Contact %1 %2 is not related to a customer.';
        Text008: label '%1 %2 must not be blocked with type %3.';
        Text009: label 'You must run the %1 function to reverse the completion entries that have already been posted for this job.';
        MoveEntries: Codeunit MoveEntries;
        Text010: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text011: label '%1 must be equal to or earlier than %2.';

        LastEntryNo: Integer;
        JobEntryNo: Record "Job Entry No.";
        ApprovalEntries: Record "Approval Entry";
        ApprovalDate: DateTime;
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        ProjectCode: Code[10];
        objReso: Record Resource;





    procedure ValidateShortcutDimCode(FieldNumber: Integer; ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Jobs, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;


    procedure UpdateBillToCont(CustomerNo: Code[20])
    var
        ContBusRel: Record "Contact Business Relation";
        Cust: Record Customer;
    begin
        if Cust.Get(CustomerNo) then begin
            if Cust."Primary Contact No." <> '' then
                "Bill-to Contact No." := Cust."Primary Contact No."
            else begin
                ContBusRel.Reset;
                ContBusRel.SetCurrentkey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
                ContBusRel.SetRange("No.", "Bill-to Partner No.");
                if ContBusRel.Find('-') then
                    "Bill-to Contact No." := ContBusRel."Contact No.";
            end;
            "Bill-to Contact" := Cust.Contact;
        end;
    end;

    local procedure JobLedgEntryExist(): Boolean
    var
    begin

    end;

    local procedure JobPlanningLineExist(): Boolean
    var
    begin

    end;


    procedure UpdateBillToCust(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Cust: Record Customer;
        Cont: Record Contact;
    begin
        if Cont.Get(ContactNo) then begin
            "Bill-to Contact No." := Cont."No.";
            if Cont.Type = Cont.Type::Person then
                "Bill-to Contact" := Cont.Name
            else
                if Cust.Get("Bill-to Partner No.") then
                    "Bill-to Contact" := Cust.Contact
                else
                    "Bill-to Contact" := '';
        end else begin
            "Bill-to Contact" := '';
            exit;
        end;

        ContBusinessRelation.Reset;
        ContBusinessRelation.SetCurrentkey("Link to Table", "Contact No.");
        ContBusinessRelation.SetRange("Link to Table", ContBusinessRelation."link to table"::Customer);
        ContBusinessRelation.SetRange("Contact No.", Cont."Company No.");
        if ContBusinessRelation.Find('-') then begin
            if "Bill-to Partner No." = '' then
                Validate("Bill-to Partner No.", ContBusinessRelation."No.")
            else
                if "Bill-to Partner No." <> ContBusinessRelation."No." then
                    Error(Text006, Cont."No.", Cont.Name, "Bill-to Partner No.");
        end else
            Error(Text007, Cont."No.", Cont.Name);
    end;


    procedure UpdateCust()
    begin
        if "Bill-to Partner No." <> '' then begin
            Cust.Get("Bill-to Partner No.");
            Cust.TestField("Customer Posting Group");
            Cust.TestField("Bill-to Customer No.", '');
            "Bill-to Name" := Cust.Name;
            "Bill-to Name 2" := Cust."Name 2";
            "Bill-to Address" := Cust.Address;
            "Bill-to Address 2" := Cust."Address 2";
            "Bill-to City" := Cust.City;
            "Bill-to Post Code" := Cust."Post Code";
            "Bill-to Country/Region Code" := Cust."Country/Region Code";
            "Currency Code" := Cust."Currency Code";
            "Customer Disc. Group" := Cust."Customer Disc. Group";
            "Customer Price Group" := Cust."Customer Price Group";
            "Language Code" := Cust."Language Code";
            County := Cust.County;
            UpdateBillToCont("Bill-to Partner No.");
        end else begin
            "Bill-to Name" := '';
            "Bill-to Name 2" := '';
            "Bill-to Address" := '';
            "Bill-to Address 2" := '';
            "Bill-to City" := '';
            "Bill-to Post Code" := '';
            "Bill-to Country/Region Code" := '';
            "Currency Code" := '';
            "Customer Disc. Group" := '';
            "Customer Price Group" := '';
            "Language Code" := '';
            County := '';
            Validate("Bill-to Contact No.", '');
        end;
    end;


    procedure InitWIPFields()
    begin
        "WIP Posted To G/L" := false;
        "WIP Posting Date" := 0D;
        "WIP G/L Posting Date" := 0D;
        "Posted WIP Method Used" := 0;
    end;


    procedure TestBlocked()
    begin
        if Blocked = Blocked::" " then
            exit;
        Error(Text008, TableCaption, "No.", Blocked);
    end;


    procedure CurrencyUpdatePlanningLines()
    var
    begin

    end;


    procedure ChangeJobCompletionStatus()
    var

    begin

    end;


    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.Find('-') then
            MapMgt.MakeSelection(Database::Jobs, GetPosition)
        else
            Message(Text010);
    end;


    procedure GetQuantityAvailable(ItemNo: Code[20]; LocationCode: Code[10]; VariantCode: Code[10]; InEntryType: Option Usage,Sale,Both; Direction: Option Possitive,Negative,Both) QtyBase: Decimal
    var
    begin

    end;

    local procedure CheckDate()
    begin
        if ("Starting Date" > "Ending Date") and ("Ending Date" <> 0D) then
            Error(Text011, FieldCaption("Starting Date"), FieldCaption("Ending Date"));
    end;


    procedure ChangeProjectStatus()
    begin

    end;
}

