#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50060 "Next of Kin Details Report"
{
    //DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/NextofKinDetailsReport.rdl';

    dataset
    {
        dataitem("Members Register"; Customer)
        {
            RequestFilterFields = "No.", "Employer Code", Gender, "Registration Date", Status, "Current Shares", "Shares Retained", "Account Category";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Personal_No; "Members Register"."Payroll/Staff No")
            {
            }
            column(Registration_Date; Format("Members Register"."Registration Date"))
            {
            }
            column(Share_Capital; "Members Register"."Shares Retained")
            {
            }
            column(Deposits; "Members Register"."Monthly Contribution")
            {
                AutoCalcField = true;
            }
            column(EMail_MembersRegister; "Members Register"."E-Mail")
            {
            }
            column(No_MembersRegister; "Members Register"."No.")
            {
            }
            column(Name_MembersRegister; "Members Register".Name)
            {
            }
            column(Address_MembersRegister; "Members Register".Address)
            {
            }
            column(PhoneNo_MembersRegister; "Members Register"."Phone No.")
            {
            }
            // column(RiskFund_MembersRegister;"Members Register"."Risk Fund")
            // {
            // }
            // column(FOSAAccountNo_MembersRegister;"Members Register"."FOSA Account No.")
            // {
            // }
            column(SharesRetained_MembersRegister; "Members Register"."Shares Retained")
            {
            }
            column(CurrentShares_MembersRegister; "Members Register"."Current Shares")
            {
            }
            column(Status_MembersRegister; "Members Register".Status)
            {
            }
            column(DividendAmount_MembersRegister; "Members Register"."Dividend Amount")
            {
            }
            column(FOSAShares_MembersRegister; "Members Register"."FOSA Shares")
            {
            }
            column(Phone_No_; "Members Register"."Phone No.")
            {
            }
            column(id; "Members Register"."ID No.")
            {
            }
            column(branch; "Members Register"."Global Dimension 2 Code")
            {
            }
            column(category; "Members Register"."Account Category")
            {
            }
            column(SN; SN)
            {
            }
            // column(JuniorSavings_MembersRegister;"Members Register"."Junior Savings")
            // {
            // }
            // column(SafariSavings_MembersRegister;"Members Register"."Safari Savings")
            // {
            // }
            // column(SilverSavings_MembersRegister;"Members Register"."Silver Savings")
            // {
            // }
            column(EmployerName_MembersRegister; "Members Register"."Employer Name")
            {
            }
            column(OutstandingInterest_MembersRegister; "Members Register"."Outstanding Interest")
            {
            }
            column(OutstandingBalance_MembersRegister; "Members Register"."Outstanding Balance")
            {
            }
            column(DateofBirth_MembersRegister; "Members Register"."Date of Birth")
            {
            }
            column(EMailPersonal_MembersRegister; "Members Register"."E-Mail")
            {
            }
            // column(RefereeMemberNo_MembersRegister;"Members Register"."Referee Member No")
            // {
            // }
            // column(RefereeName_MembersRegister;"Members Register"."Referee Name")
            // {
            // }
            column(RegistrationDate_MembersRegister; "Members Register"."Registration Date")
            {
            }
            dataitem(NextofKin; "Members Next Kin Details")
            {
                DataItemLink = "Account No" = field("No.");
                column(ReportForNavId_12; 12)
                {
                }
                column(Name_NextofKin; NextofKin.Name)
                {
                }
                column(Relationship_NextofKin; NextofKin.Relationship)
                {
                }
                column(Beneficiary_NextofKin; NextofKin.Beneficiary)
                {
                }
                column(DateofBirth_NextofKin; NextofKin."Date of Birth")
                {
                }
                column(Address_NextofKin; NextofKin.Address)
                {
                }
                column(Telephone_NextofKin; NextofKin.Telephone)
                {
                }
                column(Email_NextofKin; NextofKin.Email)
                {
                }
                column(AccountNo_NextofKin; NextofKin."Account No")
                {
                }
                column(IDNo_NextofKin; NextofKin."ID No.")
                {
                }
                column(Allocation_NextofKin; NextofKin."%Allocation")
                {
                }
                column(NewUpload_NextofKin; NextofKin."New Upload")
                {
                }
                // column(TotalAllocation_NextofKin;NextofKin."Total Allocation")
                // {
                // }
                column(MaximunAllocation_NextofKin; NextofKin."Maximun Allocation %")
                {
                }
                // column(NOKResidence_NextofKin;NextofKin."NOK Residence")
                // {
                // }
                // column(EntryNo_NextofKin;NextofKin."Entry No")
                // {
                // }
                // column(Description_NextofKin;NextofKin.Description)
                // {
                // }
                // column(Guardian_NextofKin;NextofKin.Guardian)
                // {
                // }
                // column(CreatedBy_NextofKin;NextofKin."Created By")
                // {
                // }
                // column(LastdateModified_NextofKin;NextofKin."Last date Modified")
                // {
                // }
                // column(Modifiedby_NextofKin;NextofKin."Modified by")
                // {
                // }
                // column(DateCreated_NextofKin;NextofKin."Date Created")
                // {
                // }
                column(NextOfKinType_NextofKin; NextofKin.Type)
                {
                }
                // column(MemberNo_NextofKin;NextofKin."Member No")
                // {
                // }
                // column(BeneficiaryPaid_NextofKin;NextofKin."Beneficiary Paid")
                // {
                // }
                // column(BeneficialyPaidOn_NextofKin;NextofKin."Beneficialy Paid On")
                // {
                // }
                // column(BeneficiaryPaidBy_NextofKin;NextofKin."Beneficiary Paid By")
                // {
                // }
                // column(Benevolent_NextofKin;NextofKin.Benevolent)
                // {
                // }
            }

            trigger OnAfterGetRecord()
            begin
                SN := SN + 1;
                // IF EmployersRec.GET("Members Register"."Employer Code") THEN BEGIN
                //  "Members Register"."Employer Name":=EmployersRec."Employer Name";
                //  END;
            end;

            trigger OnPreDataItem()
            begin
                Company.Get();
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Company: Record "Company Information";
        SN: Integer;
    //fajrnl:Codeunit "FA Jnl.-Check Line";
    // EmployersRec: Record UnknownRecord51516355;
}

