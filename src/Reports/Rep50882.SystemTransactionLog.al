#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50882 "System Transaction Log"
{
    DefaultLayout = RDLC;
    Caption = 'System Transaction Log';
    RDLCLayout = './Layouts/System Transaction Log.rdl';

    dataset
    {
        dataitem("Session Event"; "System Log Trails")
        {
            RequestFilterFields = "User ID", "Transaction Date";
            DataItemTableView = sorting("Entry No") where("Session Type" = filter(Insert | Post));

            column(ProductID; "Session Event"."Transaction ID")
            {
            }
            column(EntryNo; EntryNo)
            {
            }
            column(Transaction_Type_ID; "Session Event"."Transaction Type ID")
            {
            }
            column(Account_Type_ID; "Session Event"."Account Type ID")
            {
            }
            column(Product; "Session Event"."Transaction Type")
            {
            }
            column(BranchID; "Session Event"."Transacting Branch ID")
            {
            }
            column(Account_ID; "Session Event"."Account ID")
            {
            }
            column(Transaction_Description; "Session Event"."Transaction Description")
            {
            }
            column(Transaction_Amount; "Session Event"."Transaction Amount")
            {
            }
            column(Authorized_By; "Session Event"."Authorized By")
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
                EntryNo := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                EntryNo := EntryNo + 1;
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
        EntryNo: Integer;
}

