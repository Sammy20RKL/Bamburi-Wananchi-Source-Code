tableextension 52019 "Ext Employee Temp" extends "Employee Templ."
{
    fields
    {
        field(50007; "Employee Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Board Member,Attachee,Intern';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,"Board Member",Attachee,Intern;
            Caption = 'Employee Type';
        }
    }

}

