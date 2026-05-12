#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50199 "HR Employee-List PR"
{
    Editable = false;
    PageType = List;
    SourceTable = "HR Employees";
    SourceTableView = sorting("No.")
                      order(ascending)
                      where(Status = filter(Active));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = Basic;
                }
                field("Length Of Service"; Rec."Length Of Service")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = Basic;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address2"; Rec."Postal Address2")
                {
                    ApplicationArea = Basic;
                }
                field("Postal Address3"; Rec."Postal Address3")
                {
                    ApplicationArea = Basic;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = Basic;
                }
                field("Residential Address2"; Rec."Residential Address2")
                {
                    ApplicationArea = Basic;
                }
                field("Residential Address3"; Rec."Residential Address3")
                {
                    ApplicationArea = Basic;
                }
                field("Post Code2"; Rec."Post Code2")
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
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Ext."; Rec."Ext.")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic;
                }
                field("Union Code"; Rec."Union Code")
                {
                    ApplicationArea = Basic;
                }
                field("UIF Number"; Rec."UIF Number")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = Basic;
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Office; Rec.Office)
                {
                    ApplicationArea = Basic;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ApplicationArea = Basic;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Known As"; Rec."Known As")
                {
                    ApplicationArea = Basic;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Basic;
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Union Member?"; Rec."Union Member?")
                {
                    ApplicationArea = Basic;
                }
                field("Shift Worker?"; Rec."Shift Worker?")
                {
                    ApplicationArea = Basic;
                }
                field("Contracted Hours"; Rec."Contracted Hours")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Period"; Rec."Pay Period")
                {
                    ApplicationArea = Basic;
                }
                field("Cost Code"; Rec."Cost Code")
                {
                    ApplicationArea = Basic;
                }
                field("UIF Contributor?"; Rec."UIF Contributor?")
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    ApplicationArea = Basic;
                }
                field("First Language (R/W/S)"; Rec."First Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                }
                field("Driving Licence"; Rec."Driving Licence")
                {
                    ApplicationArea = Basic;
                }
                field("Vehicle Registration Number"; Rec."Vehicle Registration Number")
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
                field("Health Assesment Date"; Rec."Health Assesment Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Scheme Join"; Rec."Pension Scheme Join")
                {
                    ApplicationArea = Basic;
                }
                field("Time Pension Scheme"; Rec."Time Pension Scheme")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme Join"; Rec."Medical Scheme Join")
                {
                    ApplicationArea = Basic;
                }
                field("Time Medical Scheme"; Rec."Time Medical Scheme")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ApplicationArea = Basic;
                }
                field(Paterson; Rec.Paterson)
                {
                    ApplicationArea = Basic;
                }
                field(Peromnes; Rec.Peromnes)
                {
                    ApplicationArea = Basic;
                }
                field(Hay; Rec.Hay)
                {
                    ApplicationArea = Basic;
                }
                field(Castellion; Rec.Castellion)
                {
                    ApplicationArea = Basic;
                }
                field("Allow Overtime"; Rec."Allow Overtime")
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
                field("Number Of Dependants"; Rec."Number Of Dependants")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Scheme Name"; Rec."Medical Scheme Name")
                {
                    ApplicationArea = Basic;
                }
                field("Receiving Car Allowance ?"; Rec."Receiving Car Allowance ?")
                {
                    ApplicationArea = Basic;
                }
                field("Second Language (R/W/S)"; Rec."Second Language (R/W/S)")
                {
                    ApplicationArea = Basic;
                }
                field("Additional Language"; Rec."Additional Language")
                {
                    ApplicationArea = Basic;
                }
                field("Cell Phone Reimbursement?"; Rec."Cell Phone Reimbursement?")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Reimbursed"; Rec."Amount Reimbursed")
                {
                    ApplicationArea = Basic;
                }
                field("UIF Country"; Rec."UIF Country")
                {
                    ApplicationArea = Basic;
                }
                field("Direct/Indirect"; Rec."Direct/Indirect")
                {
                    ApplicationArea = Basic;
                }
                field("Primary Skills Category"; Rec."Primary Skills Category")
                {
                    ApplicationArea = Basic;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = Basic;
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    ApplicationArea = Basic;
                }
                field("Job Specification"; Rec."Job Specification")
                {
                    ApplicationArea = Basic;
                }
                field(DateOfBirth; Rec.DateOfBirth)
                {
                    ApplicationArea = Basic;
                }
                field(DateEngaged; Rec.DateEngaged)
                {
                    ApplicationArea = Basic;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = Basic;
                }
                field("Name Of Manager"; Rec."Name Of Manager")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Disabling Details"; Rec."Disabling Details")
                {
                    ApplicationArea = Basic;
                }
                field("Disability Grade"; Rec."Disability Grade")
                {
                    ApplicationArea = Basic;
                }
                field("Passport Number"; Rec."Passport Number")
                {
                    ApplicationArea = Basic;
                }
                field("2nd Skills Category"; Rec."2nd Skills Category")
                {
                    ApplicationArea = Basic;
                }
                field("3rd Skills Category"; Rec."3rd Skills Category")
                {
                    ApplicationArea = Basic;
                }
                field(PensionJoin; Rec.PensionJoin)
                {
                    ApplicationArea = Basic;
                }
                field(DateLeaving; Rec.DateLeaving)
                {
                    ApplicationArea = Basic;
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*
        IF (DepCode <> '') THEN
           SETFILTER("Department Code", ' = %1', DepCode);
        IF (OfficeCode <> '') THEN
           SETFILTER(Office, ' = %1', OfficeCode);
             */

    end;

    var
        Mail: Codeunit Mail;
        PictureExists: Boolean;
        DepCode: Code[10];
        OfficeCode: Code[10];


    procedure SetNewFilter(var DepartmentCode: Code[10]; var "Office Code": Code[10])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;
}

