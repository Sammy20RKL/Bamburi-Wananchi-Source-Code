Report 50350 "User"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/useronsystem.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(User; User)
        {
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
}