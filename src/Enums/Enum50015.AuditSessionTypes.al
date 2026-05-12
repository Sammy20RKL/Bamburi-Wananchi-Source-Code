enum 50015 "Audit Session Types"
{

    value(0; " ")
    {
        Caption = '" "';
    }
    value(1; LogIn)
    {
        Caption = 'LogIn';
    }
    value(2; LogOut)
    {
        Caption = 'LogOut';
    }
    value(3; Read)
    {
        Caption = 'Read';//On Reports,On Pages(Sensitive Data only)
    }
    value(4; Insert)
    {
        Caption = 'Insert';//On Tables(On insert trigger)//
    }
    value(5; "Modify")
    {
        Caption = 'Modify';//On  table records
    }
    value(6; Delete)
    {
        Caption = 'Delete';//On posted table records
    }
    value(7; Post)//Other than GL Transactions(leave applications)
    {
        Caption = 'Post';
    }

}
