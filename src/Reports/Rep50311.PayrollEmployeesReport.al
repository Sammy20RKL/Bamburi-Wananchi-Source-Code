#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50311 "Payroll Employees Report."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Payroll Employees Report..rdlc';

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            DataItemTableView = order(ascending);
            column(ReportForNavId_1; 1)
            {
            }
            column(No; "Payroll Employee."."No.")
            {
            }
            column(Surname; "Payroll Employee.".Surname)
            {
            }
            column(FirstName; "Payroll Employee."."First Name")
            {
            }
            column(LastName; "Payroll Employee."."Middle Name")
            {
            }
            column(Full_Name; "Full Name")
            {

            }
            column(DateofJoin; "Payroll Employee."."Joining Date")
            {
            }
            column(Activity; "Payroll Employee."."Global Dimension 1")
            {
            }
            column(Branch; "Payroll Employee."."Global Dimension 2")
            {
            }
            column(IDNo; "Payroll Employee."."National ID No")
            {
            }
            column(PINNo; "Payroll Employee."."PIN No")
            {
            }
            column(Basic_Pay; "Payroll Employee."."Basic Pay") { }
            column(NSSFNo; "Payroll Employee."."NSSF No")
            {
            }
            column(NHIFNo; "Payroll Employee."."NHIF No")
            {
            }
            column(CName; CompanyInformation.Name)
            {
            }
            column(CAddress; CompanyInformation."Address 2")
            {
            }
            column(CPic; CompanyInformation.Picture)
            {
            }
            column(Department_PayrollEmployee; "Payroll Employee.".Department)
            {
            }
            column(SN; SN)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SN := SN + 1;
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(CompanyInformation.Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        SN: Integer;
}

