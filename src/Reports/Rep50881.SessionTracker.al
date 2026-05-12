#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50881 "Session Tracker"
{
    DefaultLayout = RDLC;
    Caption = 'System User Session Tracker';
    RDLCLayout = './Layouts/Session Tracker.rdl';

    dataset
    {
        dataitem("Session Event"; "System Log Trails")
        {
            RequestFilterFields = "User ID";
            DataItemTableView = sorting("Entry No") where("Session Type" = filter(LogIn | Logout));

            column(ReportForNavId_1120054000; 1120054000)
            {
            }
            column(UserID_SessionEvent; "Session Event"."User ID")
            {
            }
            column(ClientComputerName_SessionEvent; "Session Event"."Log In Computer Name")
            {
            }
            column(DatabaseName_SessionEvent; "Session Event"."Database Name")
            {
            }
            column(EventDatetime_SessionEvent; "Session Event"."Event Date/Time")
            {
            }
            column(EventType_SessionEvent; "Session Event"."Session Type")
            {
            }
            column(SessionID_SessionEvent; "Session Event"."Session ID")
            {
            }
            column(ServerInstanceID_SessionEvent; "Session Event"."Server Instance")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_City; Company.City)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(USERID; UserId)
            {
            }

            trigger OnPreDataItem()
            begin
                Company.Get();
                Company.CalcFields(Picture);
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
}

