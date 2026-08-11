Report 50350 "User"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Staff List';
    RDLCLayout = './Layouts/useronsystem.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(User; User)
        {
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(User_Security_ID; "User Security ID")
            {

            }
            column(User_Name; "User Name")
            {

            }
            column(Application_ID; "Application ID")
            {

            }
            column(Windows_Security_ID; "Windows Security ID")
            {

            }
            column(State; State)
            {

            }
            column(SystemId; SystemId)
            {

            }
            column(Contact_Email; "Contact Email")
            {

            }
            column(SystemCreatedAt; SystemCreatedAt)
            {

            }
            column(SystemCreatedBy; SystemCreatedBy)
            {

            }
            column(SystemModifiedBy; SystemModifiedBy)
            {

            }
            column(SystemModifiedAt; SystemModifiedAt)
            {

            }
            column(SystemRowVersion; SystemRowVersion)
            {

            }
            column(UserDepartment; UserDepartment)
            {
            }
            column(UserPosition; UserPosition) { }
            column(DesignationDate; DesignationDate) { }

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                UserLogin.Reset();
                UserLogin.SetCurrentKey("Date and Time");
                UserLogin.SetRange("User ID", "User Name");
                if UserLogin.Find('-') then begin
                    DesignationDate := UserLogin."Date and Time";
                end;

                if (User."User Name" = 'SAMMY') or (User."User Name" = 'MOBILE') or
                (User."User Name" = 'DESKTOP-EKBU2BI\SAMMY') or (User."User Name" = 'SWIZZSOFT')
                or (User."User Name" = 'BAMBURI') then
                    CurrReport.Skip();


            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        myInt: Integer;
        CompanyInfo: Record "Company Information";
        UserPosition: Code[30];
        UserDepartment: Code[40];
        DesignationDate: DateTime;
        UserLogin: Record "Change Log Entry";

}