#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51489 "Online Users"
{
    Permissions = TableData "Online Users" = rimd;


    fields
    {
        field(1; "User Name"; Code[50])
        {

            trigger OnValidate()
            begin
                /*memb.RESET;
                memb.SETRANGE(memb."No.","User Name");
                IF memb.FIND('-') THEN
                Password:=memb."ID No.";*/

            end;
        }
        field(2; Password; Text[25])
        {
        }
        field(3; Email; Text[250])
        {
        }
        field(4; "Date Created"; Date)
        {
        }
        field(5; "Changed Password"; Boolean)
        {
        }
        field(6; "Number Of Logins"; Integer)
        {
            CalcFormula = count("Online Sessions" where("User Name" = field("User Name")));
            FieldClass = FlowField;
        }
        field(8; "User Type"; Text[30])
        {
        }
        field(9; MobileNumber; Code[40])
        {
        }
        field(10; IdNumber; Code[50])
        {
        }
        field(11; "Key"; Guid)
        {
            Caption = 'Key';
        }
        field(12; "Last Login"; DateTime) { }
        field(13; "Login OTP"; Code[4]) { }
    }

    keys
    {
        key(Key1; "User Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        memb: Record Customer;
}

