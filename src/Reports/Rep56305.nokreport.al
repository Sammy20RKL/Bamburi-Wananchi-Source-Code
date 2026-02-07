#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 56305 "nok report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/nok report.rdlc';

    dataset
    {
        dataitem(Nominee; "Members Nominee")
        {
            RequestFilterFields = "Account No";
            column(ReportForNavId_1; 1)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(AccountNo_Nominee; Nominee."Account No")
            {
            }
            column(NextOfKinType_Nominee; Nominee."Next Of Kin Type")
            {
            }
            column(Allocation_Nominee; Nominee."%Allocation")
            {
            }
            column(IDNo_Nominee; Nominee."ID No.")
            {
            }
            column(Description_Nominee; Nominee.Description)
            {
            }
            column(Name_Nominee; Nominee.Name)
            {
            }
            column(Relationship_Nominee; Nominee.Relationship)
            {
            }
            column(TotalAllocation_Nominee; Nominee."Total Allocation")
            {
            }
            column(Telephone_Nominee; Nominee.Telephone)
            {
            }
            column(no; run)
            {
            }
            column(Beneficiary_Nominee; Nominee.Beneficiary)
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Account No");
                column(ReportForNavId_10; 10)
                {
                }
                column(No_MemberRegister; Customer."No.")
                {
                }
                column(Name_MemberRegister; Customer.Name)
                {
                }
                column(PhoneNo_MemberRegister; Customer."Phone No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                run := run + 1;
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

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    trigger OnPreReport()
    begin

        //     IF "COMPY INFOR".GET THEN
        //        BEGIN
        // "COMPY INFOR".CALCFIELDS("COMPY INFOR".Picture);
        //        NAME:="COMPY INFOR".Name;
        //        END;
    end;

    var
        Company: Record "Company Information";
        run: Integer;
}

