page 56110 "Member Application Card"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Membership Applications";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            field("Account Type"; Rec."Account Category")
            {
                ApplicationArea = Basic;
                Caption = 'Account Type';
                // Enabled = membertypeEditable;
                ShowMandatory = true;
                ColumnSpan = 0;
                RowSpan = 0;

                Editable = TitleEditable;
                Visible = true;

                trigger OnValidate()
                begin
                    UpdateControls();
                end;
            }
            group(General)
            {
                Caption = 'General';
                Visible = Individual;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned No"; Rec."Assigned No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                    Caption = 'Assigned No';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic;
                    Editable = TitleEditable;
                    ShowMandatory = true;
                }

                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = FistnameEditable;


                    trigger OnValidate()
                    begin

                        Rec.Name := Rec."First Name";
                    end;

                }

                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = FistnameEditable;


                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name";
                    end;

                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = FistnameEditable;


                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                    end;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;


                    ShowMandatory = true;
                }
                field("Registration No"; Rec."Registration No")
                {
                    ApplicationArea = Basic;
                    Editable = FistnameEditable;
                    Visible = false;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = AddressEditable;

                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostalCodeEditable;
                    Importance = Promoted;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = Basic;
                    Editable = CityEditable;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        If Rec.Nationality = Rec.Nationality::Kenyan then
                            NationalRe := false
                        else
                            NationalRe := true;
                    end;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = CityEditable;
                }
                field(IPRS; Rec.IPRS)
                {
                    ApplicationArea = Basic;
                    Caption = 'IPRS';
                    Editable = CityEditable;
                    Visible = false;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = PhoneEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Mobile Phone No") <> 10 then
                            Error('Mobile No. Can not be more or less than 10 Characters');
                    end;
                }
                field("Mobile Phone No 2"; Rec."Mobile No. 2")
                {
                    ApplicationArea = Basic;
                    Editable = PhoneEditable;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Mobile No. 2") <> 10 then
                            Error('Mobile No. Can not be more or less than 15 Characters');
                    end;
                }
                field("Identity Type"; Rec."Identification Document")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = all;

                    Editable = IDNoEditable;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Enabled = DOBEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        DateofRetirement: Date;
                    begin
                        Rec.Age := Dates.DetermineAge(Rec."Date of Birth", Today);
                        GenSetUp.Get();
                        DateofRetirement := CalcDate(GenSetUp."Retirement Age", Rec."Date of Birth");
                        Message('Date of Retiremtn %1', DateofRetirement);
                    end;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = ageEditable;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = GenderEditable;
                    ShowMandatory = true;
                }
                field("KRA Pin"; Rec."KRA Pin")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                    Editable = NameEditable;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalstatusEditable;
                }
                // field("Employer Code"; "Employer Code")
                // {
                //     ApplicationArea = Basic;
                //     Editable = EmployerCodeEditable;
                // }
                // field("Employer Name"; "Employer Name")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                // field("Payroll/Staff No"; "Payroll/Staff No")
                // {
                //     ApplicationArea = Basic;
                //     Editable = NameEditable;
                // }
                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
                    ShowMandatory = false;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Location';
                    ShowMandatory = true;
                    Editable = NameEditable;
                }
                field("Received 1 Copy Of ID"; Rec."Received 1 Copy Of ID")
                {
                    ApplicationArea = Basic;
                    Editable = CopyOFIDEditable;
                    ShowMandatory = true;
                }

                field("Copy of KRA Pin"; Rec."Copy of KRA Pin")
                {
                    ApplicationArea = Basic;
                    Editable = CopyofKRAPinEditable;
                }
                field("AutoFill Mobile Details"; Rec."AutoFill Mobile Details")
                {
                    ApplicationArea = Basic;
                    Editable = CopyofKRAPinEditable;
                    ShowMandatory = true;
                    Visible = false;
                }
                field("AutoFill Agency Details"; Rec."AutoFill Agency Details")
                {
                    ApplicationArea = Basic;
                    Editable = CopyofKRAPinEditable;
                    ShowMandatory = true;
                    Visible = false;
                }
            }
            group(Business)
            {
                Visible = BusinessAccount;
                Caption = 'Business Details';
                field("Business No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Business Account Application Number';
                }
                field("Assigned No."; Rec."Assigned No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Assigned No';
                }
                field("Business Name"; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = BusinessAccount;
                    Caption = 'Business Name';
                    ShowMandatory = true;
                }
                field(BusinessEmail; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
                    caption = 'Group Email';
                    ShowMandatory = true;
                }
                field(BusinessKRAPin; Rec."KRA Pin")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                    Editable = NameEditable;
                    Caption = 'Group KRA Pin';
                }
                field("Mobile Phone No Business"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = PhoneEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Mobile Phone No") <> 10 then
                            Error('Mobile No. Can not be more or less than 10 Characters');
                    end;
                }
                field("Mobile Phone No 2 Business"; Rec."Mobile No. 2")
                {
                    ApplicationArea = Basic;
                    Editable = PhoneEditable;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Mobile No. 2") <> 10 then
                            Error('Mobile No. Can not be more or less than 15 Characters');
                    end;
                }
                field(BusinessAddress; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = RecruitedEditable;
                }
                field("Nature of Business."; Rec."Nature of Business")
                {
                    Caption = 'Group Nature of Business';
                    ApplicationArea = Basic;
                    Editable = RecruitedEditable;
                }
                field("Business Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                    Editable = RecruitedEditable;
                }
                field("Business Recruiter Name"; Rec."Recruiter Name")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }
            }
            group(Junior)
            {

                Visible = Junior;
                field("JuniorNo."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Junior Account Application Number';
                }

                field("JuniorFirst Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = FistnameEditable;


                    trigger OnValidate()
                    begin

                        Rec.Name := Rec."First Name";
                    end;

                }

                field("JuniorSecond Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = FistnameEditable;


                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name";
                    end;

                }
                field("JuniorLast Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = FistnameEditable;


                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                    end;

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
                    Editable = FistnameEditable;
                }
                field("Guardian No."; Rec."Guardian No.")
                {
                    ApplicationArea = all;
                    Editable = FistnameEditable;
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }
            group(JointAccountOne)
            {
                Visible = Jooint;
                Caption = 'Director One Details';
                field("JointNo."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Joint No.';
                }
                field("Assigned J No."; Rec."Assigned No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Assigned No';
                }
                field(JointTitle; Rec.Title)
                {
                    ApplicationArea = Basic;
                    Editable = TitleEditable;
                    ShowMandatory = true;
                }
                field(JoointName; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = gender2editable;
                    ShowMandatory = true;
                }
                field("JointID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = gender2editable;
                    ShowMandatory = true;
                }
                field("JointKRA Pin"; Rec."KRA Pin")
                {
                    ApplicationArea = Basic;
                    Editable = gender2editable;
                    ShowMandatory = true;
                }
                field(JointAddress; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = gender2editable;
                    ShowMandatory = true;
                }
                field("JointE-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = gender2editable;
                    ShowMandatory = true;

                }
                field(JoointGender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = gender2editable;
                    ShowMandatory = true;
                }
                field("JointDate of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = gender2editable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.Age := Dates.DetermineAge(Rec."Date of Birth", Today);
                        // if "Date of Birth" <> 0D then
                        //     Age := Round((Today - "Date of Birth") / 365, 1);
                    end;
                }
                field(JointAge; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = ageEditable;
                    // Visible = false;
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
                    Editable = Employername2Editable;
                }
                field("Share Of Ownership One"; Rec."Share Of Ownership One")
                {
                    ApplicationArea = Basic;
                    Editable = Employername2Editable;
                }
                field("Source of Income Member One"; Rec."Source of Income Member One")
                {
                    ApplicationArea = Basic;
                    Editable = Employername2Editable;
                }
            }
            group(JointAccountTwo)
            {
                Caption = 'Director Two Details';
                Visible = Jooint;
                field("Member Title"; Rec.Title2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Title';
                    Editable = title2Editable;
                    ShowMandatory = true;
                }
                field("Second Member Name"; Rec."Second Member Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = gender2editable;
                    ShowMandatory = true;
                }
                field("ID/Passport No"; Rec."ID NO/Passport 2")
                {
                    ApplicationArea = Basic;
                    Editable = passpoetEditable;
                    ShowMandatory = true;
                }
                field("Member Gender"; Rec.Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = gender2editable;
                    ShowMandatory = true;
                }
                field("Marital Status2"; Rec."Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = MaritalstatusEditable;
                    ShowMandatory = true;
                }
                field("Date of Birth2"; Rec."Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = gender2editable;
                    ShowMandatory = true;
                }
                field("Mobile No. 3"; Rec."Mobile No. 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = mobile3editable;
                    ShowMandatory = true;
                }
                field("E-Mail (Personal2)"; Rec."E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail Adress';
                    Editable = emailaddresEditable;
                }
                field(Address3; Rec.Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address';
                    Editable = address3Editable;
                }
                field("Home Postal Code2"; Rec."Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = ' Postal Code';
                    Editable = HomePostalCode2Editable;
                }
                field("Home Town2"; Rec."Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = town2Editable;
                }
                field("Payroll/Staff No2"; Rec."Payroll/Staff No2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll/Staff No';
                    Editable = payrollno2editable;
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
                    Editable = Employername2Editable;
                }
                field("Share Of Ownership Two"; Rec."Share Of Ownership Two")
                {
                    ApplicationArea = Basic;
                    Editable = Employername2Editable;
                }
                field("Source of IncomeMember Two"; Rec."Source of IncomeMember Two")
                {
                    ApplicationArea = Basic;
                    Editable = Employername2Editable;
                }
            }
            group("Joint Information")
            {
                Visible = Jooint;
                field("JointRecruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                    Editable = Employername2Editable;
                }
                field("JointRecruiter Name"; Rec."Recruiter Name")
                {
                    ApplicationArea = Basic;
                    Editable = Employername2Editable;
                }

                field(JointRelationship; Rec.JointRelationship)
                {
                    ApplicationArea = Basic;
                    Caption = 'Relationship';
                    Editable = Employername2Editable;
                }
                field(Reasontocreatingajointaccount; Rec.Reasontocreatingajointaccount)
                {
                    ApplicationArea = Basic;
                    Editable = Employername2Editable;
                    Caption = 'Reason to creating a joint account';
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
                    Editable = EmailEdiatble;
                    Caption = 'Group Name';
                    ShowMandatory = true;
                }
                field(GroupEmail; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
                    caption = ' Group Email';
                    ShowMandatory = true;
                }
                field(GroupKRAPin; Rec."KRA Pin")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                    Editable = NameEditable;
                    Caption = 'Group KRA Pin';
                }
                field("Mobile Phone No Group"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = PhoneEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Mobile Phone No") <> 10 then
                            Error('Mobile No. Can not be more or less than 10 Characters');
                    end;
                }
                field("Mobile Phone No 2 Group"; Rec."Mobile No. 2")
                {
                    ApplicationArea = Basic;
                    Editable = PhoneEditable;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Mobile No. 2") <> 10 then
                            Error('Mobile No. Can not be more or less than 15 Characters');
                    end;
                }
                field(GroupAddress; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = RecruitedEditable;
                }
                field("Nature of Business"; Rec."Nature of Business")
                {
                    Caption = 'Group Nature of Business';
                    ApplicationArea = Basic;
                    Editable = RecruitedEditable;
                }
                field("Group Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                    Editable = RecruitedEditable;
                }
                field("Group Recruiter Name"; Rec."Recruiter Name")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }


            }
            group("Bank Details")
            {

                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Code';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Name';
                    Editable = false;
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Employment Details")
            {
                Visible = Individual;
                field("Employment Info"; Rec."Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;

                    trigger OnValidate()
                    begin
                        if Rec."Employment Info" = Rec."Employment Info"::Employed then begin
                            employedMember := true;
                            selfEmployedMember := false;
                        end else
                            if Rec."Employment Info" = Rec."Employment Info"::" " then begin
                                employedMember := false;
                                selfEmployedMember := false;
                            end else
                                if Rec."Employment Info" = Rec."Employment Info"::Others then begin
                                    employedMember := false;
                                    selfEmployedMember := false;
                                end else
                                    if Rec."Employment Info" = Rec."Employment Info"::"Self Employed" then begin
                                        employedMember := false;
                                        selfEmployedMember := true;
                                    end else
                                        if Rec."Employment Info" = Rec."Employment Info"::UnEmployed then begin
                                            employedMember := false;
                                            selfEmployedMember := false;
                                        end;
                    end;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Income Levels"; Rec."Income Levels")
                {
                    Caption = 'Estimated Monthly Income Levels';
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                    Visible = not employedMember and not selfEmployedMember;
                    Caption = 'Source of Funds';
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;
                    trigger OnValidate()
                    begin
                        if Rec."Source of Funds" = Rec."Source of Funds"::Others then begin
                            otherFundsSource := true;
                        end else begin
                            otherFundsSource := false;
                        end;
                    end;
                }
                field("Specific Source of Funds"; Rec."Specific Source of Funds")
                {
                    Visible = otherFundsSource;
                    Caption = 'Specific Source of Funds';
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;
                    trigger OnValidate()
                    begin

                    end;
                }
                group("Self Employed")
                {
                    Visible = selfEmployedMember;//not employedMember;
                    field("Business Name."; Rec.Name)
                    {
                        ApplicationArea = Basic;
                        Editable = BusinessAccount;
                        Caption = 'Business Name';
                        ShowMandatory = true;
                    }
                    field("Street/Building/Estate"; Rec.Address)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Street/Building/Estate';
                        Editable = RecruitedEditable;
                    }
                    field("Office Number"; Rec."Mobile Phone No")
                    {
                        ApplicationArea = Basic;
                        Editable = PhoneEditable;
                        ShowMandatory = true;
                        Caption = 'Office Number';

                        trigger OnValidate()
                        begin
                            if StrLen(Rec."Mobile Phone No") <> 10 then
                                Error('Mobile No. Can not be more or less than 10 Characters');
                        end;
                    }
                    field("Nature of Busines"; Rec."Nature of Business")
                    {
                        Caption = 'Nature of Business';
                        ApplicationArea = Basic;
                        Editable = RecruitedEditable;
                    }
                }
            }
            group("Employed")
            {
                Visible = employedMember;
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }
                field("Office Branch"; Rec."Office Branch")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }
                field("Official Designation"; Rec."Official Designation")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
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
                field("Date Employed"; Rec."Date Employed")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }
                field("Terms of Employment"; Rec."Terms of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }
            }

            group("Other Information")
            {
                Caption = 'Other Information';
                field("How Did you know about us ?"; Rec."How Did you know of KANISA")
                {
                    ApplicationArea = Basic;
                    Caption = 'How Did you know about Us?';

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                }
                field("Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = Basic;
                    Editable = RecruitedEditable;
                }
                field("Recruiter Name"; Rec."Recruiter Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = StatusEditable;

                    /*  trigger OnValidate()
                     begin
                         UpdateControls();
                     end; */
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = true;// CustPostingGroupEdit;
                }
                field(" GroupGlobal Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Activity Code';
                }
                field("GroupGlobal Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Code';
                    Editable = true;
                }
                field("Sms Notification"; Rec."Sms Notification")
                {
                    ApplicationArea = Basic;
                }
                group("User Details")
                {
                    field("User ID"; Rec."User ID")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Registration Date"; Rec."Registration Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Client Computer Name"; Rec."Client Computer Name")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = false;
                    }
                }
            }
            group("Member Risk Ratings")
            {
                Visible = false;// Individual;
                group("Member Risk Rate")
                {
                    field("Individual Category"; Rec."Individual Category")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Member Residency Status"; Rec."Member Residency Status")
                    {
                        ApplicationArea = Basic;

                    }
                    field(Entities; Rec.Entities)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Industry Type"; Rec."Industry Type")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Length Of Relationship"; Rec."Length Of Relationship")
                    {
                        ApplicationArea = Basic;
                    }
                    field("International Trade"; Rec."International Trade")
                    {
                        ApplicationArea = Basic;

                    }
                }

                group("Product Risk Rating")
                {
                    Visible = Individual;
                    field("Electronic Payment"; Rec."Electronic Payment")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Accounts Type Taken"; Rec."Accounts Type Taken")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Cards Type Taken"; Rec."Cards Type Taken")
                    {
                        ApplicationArea = Basic;
                        Visible = false;

                    }
                    field("Others(Channels)"; Rec."Others(Channels)")
                    {
                        ApplicationArea = Basic;
                        Visible = false;

                    }
                    field("Member Risk Level"; Rec."Member Risk Level")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Risk Level';
                        Editable = false;
                        StyleExpr = CoveragePercentStyle;

                    }
                    field("Due Diligence Measure"; Rec."Due Diligence MeaSure")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        StyleExpr = CoveragePercentStyle;
                        Visible = false;
                    }
                }
                part(Control27; "Member Due Diligence MeaSure")
                {
                    Caption = 'Due Diligence Measure';
                    SubPageLink = "Member No" = field("No.");
                    SubPageView = sorting("Due Diligence No");
                    Visible = false;
                }
            }
        }
        //factbox
        area(factboxes)
        {
            part(Control149; "Applicant Picture")
            {

                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
                // Visible = Individual;
                Enabled = true;

            }
            part(Control150; "Applicant Document")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
                // Visible = Individual;
                Visible = false;
                Enabled = false;
            }
            part(Control151; "Applicant Signature")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
                //   Visible = (Individual) AND NOT (JuniourAccountType);
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
                    Image = Accounts;
                    RunObject = page "Membership App Products";// "Member Applied Products List";
                    RunPageLink = "Membership Applicaton No" = field("No.");
                    Enabled = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        //on opening page,make sure that the accounts set as default are automatically filled in start
                        AccoutTypes.RESET;
                        AccoutTypes.SETRANGE(AccoutTypes."Default Account", TRUE);
                        IF AccoutTypes.Find('-') THEN BEGIN
                            REPEAT
                                IF AccoutTypes."Default Account" = TRUE THEN BEGIN
                                    ObjProductsApp.Reset();
                                    ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", xRec."No.");
                                    ObjProductsApp.SetRange(ObjProductsApp."Product", AccoutTypes.Code);
                                    if ObjProductsApp.Find('-') = false then begin
                                        ObjProductsApp.INIT;
                                        ObjProductsApp."Membership Applicaton No" := xRec."No.";
                                        ObjProductsApp."Applicant Name" := xRec.Name;
                                        // ObjProductsApp."Applicant Age" := xRec.Age;
                                        ObjProductsApp."Applicant Gender" := xRec.Gender;
                                        ObjProductsApp."Applicant ID" := xRec."ID No.";
                                        ObjProductsApp."Product" := AccoutTypes.Code;
                                        ObjProductsApp."Product Name" := AccoutTypes.Description;
                                        ObjProductsApp."Product Category" := AccoutTypes."Activity Code";
                                        ObjProductsApp.INSERT;
                                        ObjProductsApp.VALIDATE(ObjProductsApp."Product");
                                        ObjProductsApp.MODIFY;
                                    end;
                                END;
                            UNTIL AccoutTypes.Next = 0;
                        END;
                        //on opening page,make sure that the accounts set as default are automatically filled in start


                    end;
                }
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin';
                    Image = Relationship;
                    RunObject = Page "Membership App Kin Details";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Member Nominees")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Nominees';
                    Image = Relationship;
                    RunObject = Page "Membership App Nominee Detail";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                    Visible = Jooint;
                }
                action("Group Account Members")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group Account Register';
                    Image = Group;
                    RunObject = Page "Bosa Group Members List";
                    RunPageLink = "Account No" = field("No.");
                    Visible = false;
                    //Visible = groupAcc;
                }
                separator(Action6)
                {
                    Caption = '-';
                }

                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Enabled = (not OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND (not RecordApproved);

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                    begin

                        if Rec."ID No." <> '' then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", Rec."ID No.");
                            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                            if Cust.Find('-') then begin
                                if (Cust."No." <> Rec."No.") and (Cust."Account Category" = Cust."account category"::Individual) then
                                    Error('Member has already been created. Kindly Confirm the ID Number to proceed.');
                            end;
                        end;

                        //*******************Check ID no.******************************
                        if (Rec."ID No." = '') then
                            Error('You must specify ID No for the applicant');
                        //*******************Check ID no.******************************


                        if (Rec."Account Category" = Rec."account category"::Individual) then begin
                            Rec.TestField(Name);
                            Rec.TestField("ID No.");
                            Rec.TestField("Mobile Phone No");
                            Rec.TestField(Picture);
                            Rec.TestField(Signature);
                            Rec.TestField(Gender);
                            Rec.TestField("Customer Posting Group");
                            Rec.TestField("Global Dimension 1 Code");
                            // Rec.TestField("Global Dimension 2 Code");
                        end else

                            if (Rec."Account Category" = Rec."account category"::Corporate) then begin
                                Rec.TestField(Name);
                                //TESTFIELD("Registration No");
                                //TESTFIELD("Copy of KRA Pin");
                                //TESTFIELD("Member Registration Fee Receiv");
                                ///TESTFIELD("Account Category");
                                Rec.TestField("Customer Posting Group");
                                Rec.TestField("Global Dimension 1 Code");
                                // Rec.TestField("Global Dimension 2 Code");
                                //TESTFIELD("Copy of constitution");

                            end;

                        if (Rec."Account Category" = Rec."account category"::Individual) then begin//end or (Rec."Account Category" = Rec."account category"::Junior) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                            NOkApp.Reset;
                            NOkApp.SetRange(NOkApp."Account No", Rec."No.");
                            if NOkApp.Find('-') = false then begin
                                Error('Please Insert Next 0f kin Information');
                            end;
                        end;

                        if (Rec."Account Category" = Rec."account category"::Corporate) then begin
                            AccountSignApp.Reset;
                            AccountSignApp.SetRange(AccountSignApp."Account No", Rec."No.");
                            if AccountSignApp.Find('-') = false then begin
                                Error('Please insert Account Signatories');
                            end;
                        end;



                        if Rec.Status <> Rec.Status::Open then
                            Error(Text001);

                        //................................

                        if confirm('Are you sure you want to send this Document for Approval', false) = true then begin
                            SrestepApprovalsCodeUnit.SendMembershipApplicationsRequestForApproval(rec."No.", Rec);

                            Logger.LogActivity(
                                'Created new Member Application',
                                Database::"Membership Applications",
                                Rec."No.",
                                0,//Rec.Amount,
                                StrSubstNo('Application No: %1, Trans. Type: %2', Rec."No.", Format(Rec."Registration Type"))
                            );

                            Message('Approval Request Sent!');
                            CurrPage.Close();
                        end;
                        //.................................

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Enabled = CanCancelApprovalForRecord;


                    trigger OnAction()
                    var
                    // Approvalmgt: Codeunit "Export F/O Consolidation";
                    begin
                        if Confirm('Cancel Approval?', false) = true then begin
                            SrestepApprovalsCodeUnit.CancelMembershipApplicationsRequestForApproval(rec."No.", Rec);

                            //Audit Entries
                            if (UserId <> 'MOBILE') and (UserId <> 'ATM') and (UserId.ToUpper() <> 'SWIZZSOFTADMIN') then begin
                                EntryNos := 0;
                                if Audit.FindLast then
                                    EntryNos := 1 + Audit."Entry No";
                                Audit.Init();
                                Audit."Entry No" := EntryNos;
                                Audit."Transaction Type" := 'Account Appplication Request Canceled';
                                Audit."Loan Number" := '';
                                Audit."Document Number" := Rec."No.";
                                Audit."Account Number" := Rec."No.";
                                Audit.UsersId := UserId;
                                Audit.Amount := 0;
                                Audit.Date := Today;
                                Audit.Time := Time;
                                Audit.Source := 'MEMBER APPLICATION';
                                Audit.Insert();
                                Commit();
                            end;
                        end;
                    end;
                }
                separator(Action2)
                {
                    Caption = '       -';
                }

                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Image = Customer;
                    Visible = true;
                    Enabled = CreateAccount;

                    trigger OnAction()
                    var
                        TheMessage: Codeunit "Email Message";
                        Email: Codeunit Email;

                        DialogBox: Dialog;
                        BOSAAccountNo: Code[50];
                        NewFOSAAccount: Code[50];

                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('This application has not been approved');
                        ///.................
                        if (Rec."ID No." = '') and (Rec."Account Category" <> Rec."Account Category"::Corporate) then begin
                            Error('ID No is Mandatory');
                        end;

                        if Rec."Global Dimension 2 Code" = '' then begin
                            Error('Branch Code is Mandatory');

                        end;
                        Cust.Reset;
                        Cust.SetRange(Cust."ID No.", Rec."ID No.");
                        Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                        if Cust.Find('-') then begin
                            if (Cust."No." <> Rec."No.") then
                                Error('Member has already been created');
                        end;
                        if Confirm('Are you sure you want to create account application?', false) = false then begin
                            Message('Aborted');
                            exit;
                        end ELSE begin
                            dialogBox.Open('Creating New BOSA Account for applicant ' + Format(Rec.Name));
                            BOSAAccountNo := FnCreateBOSAMemberAccounts();
                            dialogBox.Close();

                            // DialogBox.Open('Registering Mobile Wallet For  %1 ', Rec."Full Name");
                            // FnFOSAProducts(BOSAAccountNo);
                            // NewFOSAAccount := FnUpdateBOSAAccountToFOSAAccount(BOSAAccountNo);
                            // DialogBox.Close();

                            GenSetUp.Get;
                            if GenSetUp."Charge BOSA Registration Fee" = true then begin
                                dialogBox.Open('Posting Registration Fees for ' + Format(MembApp.Name));
                                FnPostRegistrationFees(BOSAAccountNo, GenSetUp."BOSA Registration Fee Amount");
                                dialogBox.Close();
                            end else begin
                                // Inform user using dialog instead of Message
                                dialogBox.Open('BOSA Registration Fee will NOT be posted as per system setup.');
                                dialogBox.Close();
                            end;



                            if GenSetUp."Auto Open FOSA Savings Acc." = true then begin
                                dialogBox.Open('Creating New M-Wallet Account for applicant ' + Format(MembApp.Name));
                                swizzMobile.CreateMWallet(BOSAAccountNo);
                                // swizzkash
                                dialogBox.Close();
                            end;

                            dialogBox.Open('Registering Next Of Kin for ' + Format(Rec.Name));
                            FnCreateNextOfKinDetails(Cust."No.");
                            dialogBox.Close();

                            dialogBox.Open('Registering Nominees for ' + Format(Rec.Name));
                            FnCreateNomineeDetails(Cust."No.");
                            dialogBox.Close();

                            dialogBox.Open('Registering Account Signatories for ' + Format(Rec.Name));
                            FnCreateAccountSignatories(Cust."No.");
                            dialogBox.Close();

                            dialogBox.Open('Registering Account Group Members for ' + Format(Rec.Name));
                            FnCreateGroupMembers();
                            dialogBox.Close();

                            //...............................Close The Card
                            //-----Send Email

                            SendMail(BOSAAccountNo);
                            //-----Send SMS
                            FnSendSMSOnAccountOpening();

                            //-----
                            Message('Account created successfully.');
                            Message('The Member Sacco no is %1', Cust."No.");

                            //...............................modify the status of the application to closed
                            rec.Status := Rec.Status::Closed;
                            rec.Modify(true);
                            //.............................................................................
                            //Audit Entries
                            if (UserId <> 'MOBILE') and (UserId <> 'SAMMY') and (UserId <> 'SWIZZSOFT') then begin
                                EntryNos := 0;
                                if Audit.FindLast then
                                    EntryNos := 1 + Audit."Entry No";
                                Audit.Init();
                                Audit."Entry No" := EntryNos;
                                Audit."Transaction Type" := 'Account Creation';
                                Audit."Loan Number" := '';
                                Audit."Document Number" := Rec."No.";
                                Audit."Account Number" := BOSAAccountNo;
                                Audit.UsersId := UserId;
                                Audit.Amount := 0;
                                Audit.Date := Today;
                                Audit.Time := Time;
                                Audit.Source := 'MEMBER APPLICATION';
                                Audit.Insert();
                                Commit();
                            end;
                        end;

                    end;
                }
                separator(Action3)
                {
                    Caption = '       -';
                }

                action("Member Risk Rating")
                {
                    Visible = false;
                    ApplicationArea = Basic;
                    Caption = 'Get Member Risk Rating';
                    Image = Reconcile;
                    RunObject = Page "Individual Member Risk Rating";
                    RunPageLink = "Membership Application No" = field("No.");

                    trigger OnAction()
                    VAR

                    begin
                        SFactory.FnGetMemberApplicationAMLRiskRating(Rec."No.");
                    end;
                }


            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref("Select Products_Promoted"; "Select Products")
                {
                }
                actionref("Next of Kin_Promoted"; "Next of Kin")
                {
                }
                actionref("Member Nominees_Promoted"; "Member Nominees")
                {
                }
                actionref("Account Signatories _Promoted"; "Account Signatories")
                {
                }
                actionref("Group Account Details Promoted"; "Group Account Members")
                {
                }

                actionref("Create Account_Promoted"; "Create Account")
                {
                }

                actionref(MemberRiskRating_Promoted; "Member Risk Rating")
                {
                }
                actionref("Send Approval Request_Promoted"; "Send Approval Request")
                {
                }
                actionref("Cancel Approval Request_Promoted"; "Cancel Approval Request")
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Approval', Comment = 'Generated from the PromotedActionCategories property index 3.';


            }
            group(Category_Category5)
            {
                Caption = 'Budgetary Control', Comment = 'Generated from the PromotedActionCategories property index 4.';
            }
            group(Category_Category6)
            {
                Caption = 'Cancellation', Comment = 'Generated from the PromotedActionCategories property index 5.';
            }
            group(Category_Category7)
            {
                Caption = 'Category7_caption', Comment = 'Generated from the PromotedActionCategories property index 6.';
            }
            group(Category_Category8)
            {
                Caption = 'Category8_caption', Comment = 'Generated from the PromotedActionCategories property index 7.';
            }
            group(Category_Category9)
            {
                Caption = 'Category9_caption', Comment = 'Generated from the PromotedActionCategories property index 8.';
            }
            group(Category_Category10)
            {
                Caption = 'Category10_caption', Comment = 'Generated from the PromotedActionCategories property index 9.';
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        RestrictInsert: ErrorInfo;
    begin
        Rec."Responsibility Centre" := UserMgt.GetSalesFilter;
        Rec."Monthly Contribution" := GenSetUp."Min. Contribution";
        Rec."User ID" := UserId;
        //rec.Reset();
        // Rec.SetRange(rec.Status, Rec.Status::Open);
        // Rec.SetRange(Rec."User ID", UserId);
        // Rec.SetFilter(Rec.Name, '');
        // if rec.Find('-') then begin
        //     if Rec.Count > 3 then begin
        //         Error('Please use the unfinished Member Numbers' +
        //         'Use can Edit or First finish the open applications');
        //         //RestrictInsert.Message:=StrSubstNo('Use can Edit or First finish the open applications');

        //     end;
        // end;
    end;

    trigger OnOpenPage()
    var
    begin
        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Centre", UserMgt.GetSalesFilter);
            Rec.FilterGroup(0);

        end;
        //Jooint := false;



    end;

    var
        Logger: Codeunit "Activity Logger";
        SFactory: Codeunit "Swizzsoft Factory";
        Audit: Record "Audit Entries";
        EntryNos: Integer;
        swizzMobile: Codeunit SwizzKashMobile;
        Individual: Boolean;
        groupAcc: Boolean;
        BosaAPPGroup: Record "Bosa Member App Group Members";
        BosacustGroup: Record "Bosa Customer Group Members";
        Junior: Boolean;
        MemberAppliedProducts: Record "Membership Reg. Products Appli";// "Membership Applied Products";
        ObjProductsApp: Record "Membership Reg. Products Appli";
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        Accounts: Record Vendor;
        //AcctNo: Code[20];
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
        text001: label 'Status must be open';
        UserMgt: Codeunit "User Setup Management";
        //Notification: Codeunit "SMTP Mail";
        NotificationE: Codeunit Mail;
        MailBody: Text[250];
        ccEmail: Text[1000];
        toEmail: Text[1000];
        GenSetUp: Record "Sacco General Set-Up";
        ClearingAcctNo: Code[20];
        AdvrAcctNo: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","FOSA Opening","Loan Batching",Leave,"Imprest Requisition","Imprest Surrender","Stores Requisition","Funds Transfer","Change Request","Staff Claims","BOSA Transfer","Loan Tranche","Loan TopUp","Memb Opening","Member Withdrawal";
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        NoEditable: Boolean;
        NoSeries: Codeunit "No. Series";
        DioceseEditable: Boolean;
        HomeAdressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        CustPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        OfficeBranchEditable: Boolean;
        employedMember: Boolean;
        selfEmployedMember: Boolean;
        otherFundsSource: Boolean;
        DeptEditable: Boolean;
        SectionEditable: Boolean;
        OccupationEditable: Boolean;
        DesignationEdiatble: Boolean;
        EmployerCodeEditable: Boolean;
        DOBEditable: Boolean;
        EmailEdiatble: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        WitnessEditable: Boolean;
        StatusEditable: Boolean;
        BankCodeEditable: Boolean;
        BranchCodeEditable: Boolean;
        BankAccountNoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        NewMembNo: Code[30];
        Saccosetup: Record "Sacco No. Series";
        NOkApp: Record "Member App Next Of kin";
        TitleEditable: Boolean;
        PostalCodeEditable: Boolean;
        HomeAddressPostalCodeEditable: Boolean;
        HomeTownEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        CopyOFIDEditable: Boolean;
        CopyofPassportEditable: Boolean;
        SpecimenEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        PayslipEditable: Boolean;
        RegistrationFeeEditable: Boolean;
        CopyofKRAPinEditable: Boolean;
        membertypeEditable: Boolean;
        FistnameEditable: Boolean;
        ObjNoSeries: Record "Sacco No. Series";
        dateofbirth2: Boolean;
        registrationeditable: Boolean;
        EstablishdateEditable: Boolean;
        RegistrationofficeEditable: Boolean;
        Signature2Editable: Boolean;
        Picture2Editable: Boolean;
        MembApp: Record "Membership Applications";
        title2Editable: Boolean;
        mobile3editable: Boolean;
        emailaddresEditable: Boolean;
        gender2editable: Boolean;
        postal2Editable: Boolean;
        town2Editable: Boolean;
        passpoetEditable: Boolean;
        maritalstatus2Editable: Boolean;
        commonDetails: Boolean;
        payrollno2editable: Boolean;
        Employercode2Editable: Boolean;
        address3Editable: Boolean;
        HomePostalCode2Editable: Boolean;
        Employername2Editable: Boolean;
        ageEditable: Boolean;
        CopyofconstitutionEditable: Boolean;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        IncrementNo: Code[20];
        // MpesaAppH: Record "MPESA Applications";
        // MpesaAppD: Record "MPESA Application Details";
        // MpesaAppNo: Code[20];
        // ATMApp: Record "ATM Card Applications";
        MpesaMob: Boolean;
        MpesaCop: Boolean;
        CompInfo: Record "Company Information";
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        SourceOfFunds: Boolean;
        RespCenter: Boolean;
        ShareCapContr: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        Mtype: Boolean;
        TaxExemp: Boolean;
        AccountCategory: Boolean;
        DimensionValue: Record "Dimension Value";
        Dates: Codeunit "Dates Calculation";
        // Age: Text[100];

        NationalRe: Boolean;
        Jooint: Boolean;
        BusinessAccount: Boolean;
        Vendor: Record Vendor;
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        RecordApproved: Boolean;
        CanCancelApprovalForRecord: Boolean;

        CreateAccount: Boolean;
        IEntry: integer;
        SMSToSend: Text[250];
        CoveragePercentStyle: Text;
        SwizzsoftFactory: Codeunit "Swizzsoft Factory";
        EmailCodeunit: Codeunit Emailcodeunit;


    procedure UpdateControls()
    begin


        if Rec."Account Category" = Rec."account category"::Individual then begin
            groupAcc := false;
            Individual := true;
            Junior := false;
            commonDetails := true;
            Jooint := false;
            BusinessAccount := false;
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := false;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := false;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := true;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := true;
            RegistrationFeeEditable := true;
            CopyofKRAPinEditable := true;
            membertypeEditable := true;
            FistnameEditable := true;
            registrationeditable := false;
            EstablishdateEditable := false;
            RegistrationofficeEditable := false;
            Picture2Editable := true;
            Signature2Editable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            commonDetails := true;



        end else if Rec."Account Category" = Rec."account category"::other then begin
            groupAcc := false;
            Individual := true;
            Junior := false;
            commonDetails := true;
            Jooint := false;
            BusinessAccount := false;
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := false;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := false;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := true;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := true;
            RegistrationFeeEditable := true;
            CopyofKRAPinEditable := true;
            membertypeEditable := true;
            FistnameEditable := true;
            registrationeditable := false;
            EstablishdateEditable := false;
            RegistrationofficeEditable := false;
            Picture2Editable := true;
            Signature2Editable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            commonDetails := true;



        end else if Rec."Account Category" = Rec."account category"::Business then begin
            Individual := false;
            BusinessAccount := true;
            Jooint := false;
            Junior := false;
            groupAcc := false;
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := false;
            commonDetails := false;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := false;
            PhoneEditable := true;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := true;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := false;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := true;
            CopyofKRAPinEditable := true;
            membertypeEditable := true;
            registrationeditable := true;
            EstablishdateEditable := true;
            RegistrationofficeEditable := true;
            Picture2Editable := false;
            Signature2Editable := false;
            FistnameEditable := false;
            registrationeditable := true;
            EstablishdateEditable := true;
            RegistrationofficeEditable := true;
            Picture2Editable := true;
            Signature2Editable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            CopyofconstitutionEditable := true;
        end
        else
            if Rec."Account Category" = Rec."account category"::Corporate then begin
                Individual := false;
                groupAcc := false;
                Junior := false;
                Jooint := true;
                BusinessAccount := false;
                commonDetails := false;
                NameEditable := true;
                AddressEditable := true;
                GlobalDim1Editable := false;
                GlobalDim2Editable := true;
                CustPostingGroupEdit := false;
                PhoneEditable := true;
                MaritalstatusEditable := true;
                IDNoEditable := true;
                PhoneEditable := true;
                RegistrationDateEdit := true;
                OfficeBranchEditable := true;
                DeptEditable := true;
                SectionEditable := true;
                OccupationEditable := true;
                DesignationEdiatble := true;
                EmployerCodeEditable := true;
                DOBEditable := true;
                EmailEdiatble := true;
                StaffNoEditable := true;
                GenderEditable := true;
                MonthlyContributionEdit := true;
                PostCodeEditable := true;
                CityEditable := true;
                WitnessEditable := true;
                BankCodeEditable := true;
                BranchCodeEditable := true;
                BankAccountNoEditable := true;
                VillageResidence := true;
                TitleEditable := false;
                PostalCodeEditable := true;
                HomeAddressPostalCodeEditable := true;
                HomeTownEditable := true;
                RecruitedEditable := true;
                ContactPEditable := true;
                ContactPRelationEditable := true;
                ContactPOccupationEditable := true;
                CopyOFIDEditable := true;
                CopyofPassportEditable := true;
                SpecimenEditable := true;
                ContactPPhoneEditable := true;
                HomeAdressEditable := true;
                PictureEditable := true;
                SignatureEditable := true;
                PayslipEditable := true;
                RegistrationFeeEditable := true;
                CopyofKRAPinEditable := true;
                membertypeEditable := true;
                FistnameEditable := true;
                registrationeditable := true;
                EstablishdateEditable := true;
                RegistrationofficeEditable := true;
                Picture2Editable := true;
                Signature2Editable := true;
                registrationeditable := true;
                EstablishdateEditable := true;
                RegistrationofficeEditable := true;
                Picture2Editable := true;
                Signature2Editable := true;
                title2Editable := true;
                emailaddresEditable := true;
                gender2editable := true;
                HomePostalCode2Editable := true;
                town2Editable := true;
                passpoetEditable := true;
                maritalstatus2Editable := true;
                payrollno2editable := true;
                Employercode2Editable := true;
                address3Editable := true;
                Employername2Editable := true;
                mobile3editable := true;
                CopyofconstitutionEditable := true;
                IDNoEditable := true;
                dateofbirth2 := true
            end;


        if Rec.Status = Rec.Status::Approved then begin
            CreateAccount := false;
            CanCancelApprovalForRecord := false;
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            RecordApproved := true;
            CreateAccount := true;

        end;
        if Rec.Status = Rec.Status::"Pending Approval" then begin
            CreateAccount := false;
            CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;



        end;


        if Rec.Status = Rec.Status::Open then begin
            CreateAccount := false;
            CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := false;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := false;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := true;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := true;
            RegistrationFeeEditable := true;
            title2Editable := true;
            emailaddresEditable := true;
            gender2editable := true;
            HomePostalCode2Editable := true;
            town2Editable := true;
            passpoetEditable := true;
            maritalstatus2Editable := true;
            payrollno2editable := true;
            Employercode2Editable := true;
            address3Editable := true;
            Employername2Editable := true;
            ageEditable := false;
            mobile3editable := true;
            CopyofconstitutionEditable := true;

        end;

    end;


    procedure SendSMS()
    begin
        CompInfo.Get();
        GenSetUp.Get();
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end else begin
            iEntryNo := 1;
        end;

        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := Rec."No.";
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MEMBERREGISTRATION';
        SMSMessages."Entered By" := UserId;
        SMSMessages."System Created Entry" := true;
        SMSMessages."Document No" := Rec."No.";
        SMSMessages."Telephone No" := Rec."Mobile Phone No";
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := 'Dear Member your account has been created successfully, your Account No is '
        + BOSAACC + '  Account Name ' + Rec.Name + ' .' + 'You can now Deposit Via PayBill ....... Thank You For Choosing to Save With Us';
        SMSMessages.Insert;

    end;


    procedure SendMail(MemberNumber: Text[70])
    var
        EmailBody: Text[1000];
        EmailSubject: Text[100];
        Emailaddress: Text[100];
        Companyinfo: Record "Company Information";
        memberRegister: Record Customer;
        memberName: Text;
    begin
        memberRegister.Reset();
        memberRegister.SetRange(memberRegister."No.", MemberNumber);
        if memberRegister.Find('-') then begin
            Emailaddress := memberRegister."E-Mail";
            memberName := memberRegister.Name;
        end;
        EmailSubject := 'Bamburi Wananchi Membership Application';
        CompanyInfo.Get();

        EMailBody := 'Dear <b>' + memberName + '</b>,</br></br>' +
            'On behalf of Bamburi Wananchi Sacco am pleased to inform you that your application for membership has been accepted. Your Membership Number is' + MemberNumber + '<br></br>' +
            'You can now Deposit Via PayBill ..... ' + '</br>' +
            'Thank You For Choosing to Save With Us' + '</br>' +
            'Kind regards,' + '<br></br>' +

            Companyinfo.Name + '</br>' + Companyinfo.Address + '</br>' + Companyinfo.City + '</br>' +
            Companyinfo."Post Code" + '</br>' + Companyinfo."Country/Region Code" + '</br>' +
            Companyinfo."Phone No." + '</br>' + Companyinfo."E-Mail";

        EmailCodeunit.SendMail(Emailaddress, EmailSubject, EmailBody);
    end;

    local procedure FnCreateBOSAMemberAccounts(): Code[50]
    var
        NoSeriesLine: Record "No. Series Line";

    begin
        Saccosetup.Get();

        ObjNoSeries.get();

        NewMembNo := NoSeries.GetNextNo(ObjNoSeries."Members Nos", today);
        // NoSeriesLine.RESET;
        // NoSeriesLine.SETRANGE(NoSeriesLine."Series Code", ObjNoSeries."Members Nos");
        // IF NoSeriesLine.FINDSET THEN BEGIN
        //     NoSeriesLine."Last No. Used" := INCSTR(NoSeriesLine."Last No. Used");
        //     NoSeriesLine."Last Date Used" := TODAY;
        //     NoSeriesLine.MODIFY;
        // END;


        //NewMembNo := Saccosetup."Last Memb No.";



        //Create BOSA account
        Cust.Init;
        Cust."No." := Format(NewMembNo);
        Cust.Name := Rec.Name;
        if Rec."Account Category" = Rec."Account Category"::Corporate then begin
            Cust."Group Account" := true;
        end;
        Cust."Group Account Name" := Rec.Name;
        Cust."Nature of Business" := Rec."Nature of Business";
        Cust.Address := Rec.Address;
        Cust."Post Code" := Rec."Postal Code";
        Cust.Pin := Rec."KRA Pin";
        Cust.County := Rec.City;



        Cust."Phone No." := Rec."Mobile Phone No";
        Cust."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
        Cust."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
        Cust."Customer Posting Group" := Rec."Customer Posting Group";
        Cust."Registration Date" := Today;
        Cust."Mobile Phone No" := Rec."Mobile Phone No";
        Cust.Status := Cust.Status::Active;
        Cust."Employer Code" := Rec."Employer Code";
        Cust."Employer Name" := Rec."Employer Name";
        Cust."Date of Birth" := Rec."Date of Birth";
        Cust."Station/Department" := Rec."Station/Department";
        Cust."E-Mail" := Rec."E-Mail (Personal)";
        Cust.Location := Rec.Location;
        Cust.Title := Rec.Title;
        Cust."Home Address" := Rec."Home Address";
        Cust."Home Postal Code" := Rec."Home Postal Code";
        Cust."Home Town" := Rec."Home Town";
        Cust."Recruited By" := Rec."Recruited By";
        Cust."Contact Person" := Rec."Contact Person";
        Cust."ContactPerson Relation" := Rec."ContactPerson Relation";
        Cust."ContactPerson Occupation" := Rec."ContactPerson Occupation";
        Cust."Account Category" := Rec."Account Category";
        //---Junior Accounts
        Cust."Guardian No." := Rec."Guardian No.";
        Cust."Guardian Name" := Rec."Guardian Name";
        Cust."Birth Certficate No." := Rec."Birth Certficate No.";

        //**
        Cust."Office Branch" := Rec."Office Branch";
        Cust.Department := Rec.Department;
        Cust.Occupation := Rec.Occupation;
        Cust.Designation := Rec.Designation;
        Cust."Bank Code" := Rec."Bank Code";
        Cust."Bank Branch Code" := Rec."Bank Name";
        Cust."Bank Account No." := Rec."Bank Account No";
        //**
        //Joint
        Cust."Share Of Ownership One" := Rec."Share Of Ownership One";
        Cust."Source of Income Member One" := Rec."Source of Income Member One";
        Cust."ID NO/Passport 2" := Rec."ID NO/Passport 2";
        Cust.JointRelationship := Rec.JointRelationship;
        Cust."Reasontocreatingajointaccount" := Rec.Reasontocreatingajointaccount;
        Cust.Gender2 := Rec.Gender2;
        Cust."Marital Status2" := Rec."Marital Status2";
        Cust."Date of Birth2" := Rec."Date of Birth2";
        Cust."Mobile No. 3" := Rec."Mobile No. 3";
        Cust."E-Mail (Personal2)" := Rec."E-Mail (Personal2)";
        Cust."Home Postal Code2" := Rec."Home Postal Code2";
        Cust."Home Town2" := Rec."Home Town2";
        Cust."Payroll/Staff No2" := Rec."Payroll/Staff No2";
        Cust."Employer Code2" := Rec."Employer Code2";
        Cust."Share Of Ownership Two" := Rec."Share Of Ownership Two";
        Cust."Employer Name2" := Rec."Employer Name2";
        Cust."Source of IncomeMember Two" := Rec."Source of IncomeMember Two";
        //**

        Cust."Sub-Location" := Rec."Sub-Location";
        Cust.District := Rec.District;
        Cust."Payroll/Staff No" := Rec."Payroll No";
        Cust."Personal No" := Rec."Payroll No";
        Cust."ID No." := Rec."ID No.";
        Cust."Mobile Phone No" := Rec."Mobile Phone No";
        Cust."Marital Status" := Rec."Marital Status";
        Cust."Customer Type" := Cust."customer type"::Member;
        Cust.Gender := Rec.Gender;
        Cust."Sms Notification" := Rec."Sms Notification";
        Cust.Age := Rec.Age;

        Cust.Image := Rec.Picture;
        Cust.Signature := Rec.Signature;
        Cust.IPRS := Rec.IPRS;
        //========================================================================Member Risk Rating
        Cust."Individual Category" := Rec."Individual Category";
        Cust."Entities" := Rec.Entities;
        // Cust."Member Risk Level" := (Rec."Member Risk Level");
        // Cust."Due Diligence Measure" := Format(Rec."Due Diligence Measure");
        Cust."Member Residency Status" := Rec."Member Residency Status";
        Cust."Industry Type" := Rec."Industry Type";
        // Cust."Length Of Relationship" := Rec."Length Of Relationship";
        Cust."International Trade" := Rec."International Trade";
        Cust."Electronic Payment" := Rec."Electronic Payment";
        Cust."Accounts Type Taken" := Rec."Accounts Type Taken";
        Cust."Cards Type Taken" := Rec."Cards Type Taken";
        //========================================================================
        Cust."Monthly Contribution" := Rec."Monthly Contribution";
        Cust."Contact Person" := Rec."Contact Person";
        Cust."Contact Person Phone" := Rec."Contact Person Phone";
        Cust."ContactPerson Relation" := Rec."ContactPerson Relation";
        Cust."Recruited By" := Rec."Recruited By";
        Cust."ContactPerson Occupation" := Rec."ContactPerson Occupation";
        Cust."Village/Residence" := Rec."Village/Residence";
        Cust.Insert(true);

        Saccosetup."Last Memb No." := IncStr(NewMembNo);
        Saccosetup.Modify;
        BOSAACC := Cust."No.";
        exit(BOSAACC);
    end;

    local procedure FnPostRegistrationFees(memberNo: Code[50]; transAmount: Decimal)
    var
        Gnljnline: Record "Gen. Journal Line";
        LineN: Integer;
        Jtemplate: Code[20];
        Jbatch: Code[20];

        transDescription: Text;
    begin
        Jtemplate := 'General';
        Jbatch := 'Default';
        transDescription := 'Registration Fees Recovered from deposits made on ' + Format(Today);
        //Credit Registration Fees
        LineN := LineN + 10000;
        Gnljnline.Init;
        Gnljnline."Journal Template Name" := Jtemplate;
        Gnljnline."Journal Batch Name" := Jbatch;
        Gnljnline."Line No." := LineN;
        Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
        Gnljnline."Account No." := memberNo;
        Gnljnline.Validate(Gnljnline."Account No.");
        Gnljnline."Document No." := Rec."No.";
        Gnljnline."Posting Date" := Today;
        Gnljnline.Description := transDescription;
        Gnljnline.Amount := transAmount * -1;
        Gnljnline.Validate(Gnljnline.Amount);
        Gnljnline."Transaction Type" := Gnljnline."Transaction Type"::"Registration Fee";
        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
        // Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(memberNo);
        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
        if Gnljnline.Amount <> 0 then
            Gnljnline.Insert();

        //Debit Depost Contrs
        LineN := LineN + 10000;
        Gnljnline.Init;
        Gnljnline."Journal Template Name" := Jtemplate;
        Gnljnline."Journal Batch Name" := Jbatch;
        Gnljnline."Line No." := LineN;
        Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
        Gnljnline."Account No." := memberNo;
        Gnljnline.Validate(Gnljnline."Account No.");
        Gnljnline."Document No." := Rec."No.";
        Gnljnline."Posting Date" := Today;
        Gnljnline.Description := transDescription;
        Gnljnline.Amount := transAmount;
        Gnljnline.Validate(Gnljnline.Amount);
        Gnljnline."Transaction Type" := Gnljnline."Transaction Type"::"Deposit Contribution";
        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
        // Gnljnline."Shortcut Dimension 2 Code" := FnGetMemberBranch(memberNo);
        Gnljnline.Validate(Gnljnline."Shortcut Dimension 1 Code");
        Gnljnline.Validate(Gnljnline."Shortcut Dimension 2 Code");
        if Gnljnline.Amount <> 0 then
            Gnljnline.Insert();


        // Reinitialize the record and open the journal page
        Gnljnline.Reset();
        Gnljnline.SetRange("Journal Template Name", Jtemplate);
        Gnljnline.SetRange("Journal Batch Name", Jbatch);
        if Gnljnline.Find('-') then begin
            Page.Run(page::"General Journal", Gnljnline);
            Message('Registration fee of %1 has been posted', transAmount);
        end;
    end;

    local procedure FnFOSAProducts(BOSAAccountNo: Code[50]): Code[50]
    var
        Vendortable: Record Vendor;
        ProductApplications: record "Membership Reg. Products Appli";
        ProductAccountNo: Code[50];
    begin
        ProductApplications.Reset();
        ProductApplications.SetRange(ProductApplications."Membership Applicaton No", rec."No.");
        ProductApplications.SetRange(ProductApplications.Product, 'M-WALLET');
        if ProductApplications.Find('-') then begin
            repeat
                ProductAccountNo := '';
                if ProductApplications.Product <> '' then begin

                    ProductAccountNo := swizzMobile.FnGetNewAccountNo(ProductApplications.Product, BOSAAccountNo, '100');

                    Vendortable.Init();
                    Vendortable."No." := ProductAccountNo;
                    //.........................
                    Vendortable.Name := rec.Name;
                    Vendortable."First Name" := rec."First Name";
                    Vendortable."Middle Name" := rec."Middle Name";
                    Vendortable."Last Name" := rec."Last Name";
                    // Vendortable."Country of Residence" := rec."Country of Residence";
                    Vendortable."Phone No." := rec."Mobile Phone No";
                    Vendortable."Account Type" := ProductApplications.Product;
                    Vendortable.Validate(Vendortable."Account Type");
                    Vendortable."Mobile Phone No." := rec."Mobile Phone No";
                    Vendortable."Mobile Phone No" := rec."Mobile Phone No";
                    Vendortable."E-Mail" := rec."E-Mail (Personal)";
                    Vendortable."ID No." := rec."ID No.";
                    Vendortable.Gender := rec.Gender;
                    Vendortable."Registration Date" := Today;
                    Vendortable."Global Dimension 1 Code" := 'FOSA';
                    Vendortable."Global Dimension 2 Code" := rec."Global Dimension 2 Code";
                    Vendortable.Status := Vendortable.Status::Active;
                    Vendortable."Personal No." := rec."Payroll No";
                    Vendortable.Image := rec.Picture;
                    Vendortable.Signature := rec.Signature;
                    Vendortable."BOSA Account No" := BOSAAccountNo;
                    Vendortable."Account Type" := ProductApplications.Product;
                    Vendortable."Creditor Type" := Vendortable."Creditor Type"::Account;
                    Vendortable.Insert(true);
                    //.........................
                    Vendortable.Reset();
                    Vendortable.SetRange(Vendortable."BOSA Account No", BOSAAccountNo);
                    if Vendortable.Find('-') then begin
                        Vendortable."Global Dimension 1 Code" := 'FOSA';
                        Vendortable."Global Dimension 2 Code" := REC."Global Dimension 2 Code";
                        Vendortable."Account Type" := ProductApplications.Product;
                        Vendortable."Creditor Type" := Vendortable."Creditor Type"::Account;
                        Vendortable.Modify(true);
                    end;
                end;
            until ProductApplications.Next = 0;
        end;
    end;

    local procedure FnUpdateBOSAAccountToFOSAAccount(BOSAAccountNo: Code[50]): Code[50]
    var
        VendorTable: Record Vendor;
        MemberTable: record Customer;
    begin
        VendorTable.Reset();
        VendorTable.SetRange(VendorTable."BOSA Account No", BOSAAccountNo);
        if VendorTable.Find('-') then begin
            MemberTable.Reset();
            MemberTable.SetRange(MemberTable."No.", BOSAAccountNo);
            if MemberTable.Find('-') then begin
                MemberTable."FOSA Account No." := VendorTable."No.";
                MemberTable."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
                MemberTable."Global Dimension 2 Code" := rec."Global Dimension 2 Code";
                MemberTable."Employer Code" := rec."Employer Code";
                MemberTable."Employer Name" := rec."Employer Code";
                MemberTable.Modify();
            end;
        end;
    end;

    local procedure FnGetPostingGroup(ProductCode: Code[40]): Code[20]
    var
        SavingsAccountTypes: Record "Account Types-Saving Products";
    begin
        SavingsAccountTypes.Reset();
        SavingsAccountTypes.SetRange(SavingsAccountTypes.Code, ProductCode);
        if SavingsAccountTypes.find('-') then begin
            exit(SavingsAccountTypes."Posting Group");
        end;
    end;

    local procedure FnCreateNextOfKinDetails(MemberNo: text[70])
    var
        NextofKinBOSA: Record "Members Next Kin Details";
    begin
        NextOfKinApp.Reset;
        NextOfKinApp.SetRange(NextOfKinApp."Account No", Rec."No.");
        if NextOfKinApp.Find('-') then begin
            repeat
                //......................................BOSA
                NextofKinBOSA.Init;
                NextofKinBOSA."Account No" := MemberNo;
                NextofKinBOSA.Name := NextOfKinApp.Name;
                NextofKinBOSA.Relationship := NextOfKinApp.Relationship;
                NextofKinBOSA.Beneficiary := NextOfKinApp.Beneficiary;
                NextofKinBOSA."Date of Birth" := NextOfKinApp."Date of Birth";
                NextofKinBOSA.Address := NextOfKinApp.Address;
                NextofKinBOSA.Telephone := NextOfKinApp.Telephone;
                NextofKinBOSA.Fax := NextOfKinApp.Fax;
                NextofKinBOSA.Email := NextOfKinApp.Email;
                NextofKinBOSA."ID No." := NextOfKinApp."ID No.";
                NextofKinBOSA."%Allocation" := NextOfKinApp."%Allocation";
                NextofKinBOSA.Type := NextOfKin.Type;
                NextofKinBOSA.Insert;

            until NextOfKinApp.Next = 0;
        end;
    end;

    local procedure FnCreateNomineeDetails(MemberNo: text[70])
    var
        // NextofKinBOSA: Record "Members Next Kin Details";
        nomineeApp: Record "Member App Nominee";
        membersNominee: Record "Members Nominee";
    begin

        nomineeApp.Reset;
        nomineeApp.SetRange(nomineeApp."Account No", Rec."No.");
        if nomineeApp.Find('-') then begin
            repeat
                //......................................BOSA
                membersNominee.Init;
                membersNominee."Account No" := MemberNo;
                membersNominee.Name := nomineeApp.Name;
                membersNominee.Relationship := nomineeApp.Relationship;
                membersNominee.Beneficiary := nomineeApp.Beneficiary;
                membersNominee."Date of Birth" := nomineeApp."Date of Birth";
                // membersNominee.Address := nomineeApp.Address;
                membersNominee.Telephone := nomineeApp.Telephone;
                // membersNominee.Fax := nomineeApp.Fax;
                // membersNominee.Email := nomineeApp.Email;
                membersNominee."ID No." := nomineeApp."ID No.";
                membersNominee."%Allocation" := nomineeApp."%Allocation";
                membersNominee."Next Of Kin Type" := NextOfKin.Type;
                membersNominee.Insert;

            until nomineeApp.Next = 0;
        end;
    end;

    local procedure FnCreateAccountSignatories(MemberNo: text[70])
    begin
        AccountSignApp.Reset;
        AccountSignApp.SetRange(AccountSignApp."Account No", Rec."No.");
        if AccountSignApp.Find('-') then begin
            repeat
                AccountSign.Init;
                AccountSign."Account No" := MemberNo;
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
                AccountSign."Mobile Phone No" := AccountSignApp."Mobile No.";
            until AccountSignApp.Next = 0;
        end;
    end;

    local procedure FnCreateGroupMembers()
    begin
        BosaAPPGroup.Reset;
        BosaAPPGroup.SetRange(BosaAPPGroup."Account No", Rec."No.");
        if BosaAPPGroup.Find('-') then begin
            repeat
                //......................................BOSA
                BosacustGroup.Init;
                BosacustGroup."Account No" := NewMembNo;
                BosacustGroup."Date of Birth" := BosaAPPGroup."Date of Birth";
                BosacustGroup.E_Mail := BosaAPPGroup.E_Mail;
                BosacustGroup.Employer := BosaAPPGroup.Employer;
                BosacustGroup."ID Number/Passport Number" := BosaAPPGroup."ID Number/Passport Number";
                BosacustGroup."Mobile Phone Number" := BosaAPPGroup."Mobile Phone Number";
                BosacustGroup.Name := BosaAPPGroup.Name;
                BosacustGroup.Nationality := BosaAPPGroup.Nationality;
                BosacustGroup.Occupation := BosaAPPGroup.Occupation;
                BosacustGroup."Specimen Passport" := BosaAPPGroup."Specimen Passport";
                BosacustGroup."Specimen Signature" := BosaAPPGroup."Specimen Signature";
            until BosaAPPGroup.Next = 0;
        end;
    end;


    local procedure FnGenerateNextNumberSeries(): Code[20]
    var
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesManagement: Codeunit "No. Series";
    begin
        SaccoNoSeries.Get();
        SaccoNoSeries.TestField(SaccoNoSeries."SwizzKash Reg No.");
        EXIT(NoSeriesManagement.GetNextNo(SaccoNoSeries."SwizzKash Reg No.", 0D, true));
        exit('Error generating No series of mobile applications');
    end;

    local procedure FnSendSMSOnAccountOpening()
    var
    begin
        SMSToSend := 'Dear Member your account has been created successfully, your Account No is '
        + BOSAACC + '  Account Name ' + Rec.Name + ' .' + 'You can now Deposit Via PayBill. Thank You For Choosing to Save With Us';
        IEntry := 0;
        SMSMessages.Reset();
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end else begin
            iEntryNo := 1;
        end;
        SMSMessages.Reset();
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := '';
        SMSMessages."Document No" := Rec."No.";
        SMSMessages."Account No" := Cust."No.";
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MEMBERREGISTRATION';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
        SMSMessages."SMS Message" := SMSToSend;
        SMSMessages."Telephone No" := Rec."Mobile Phone No";
        SMSMessages.Insert();
    end;

    trigger OnAfterGetRecord()
    begin
        //............................
        SetStyles();

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(REC.RecordId);//Return No and allow sending of approval request.

        EnabledApprovalWorkflowsExist := true;
        //............................


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserMgt: Codeunit "User Management";
    begin
        //FnUpdateEditableControls();
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
