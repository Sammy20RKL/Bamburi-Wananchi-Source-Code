
table 57100 "Vendor Cue"
{

    fields
    {
        field(1; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }

        field(2; "Registered Fosa"; Integer)
        {
            CalcFormula = count(Vendor);
            FieldClass = FlowField;

        }
        field(3; "Active Fosa"; Integer)
        {
            CalcFormula = count(Vendor where(Status = const(Active)));
            FieldClass = FlowField;


        }
        // field(3; "Non-Active Members"; Integer)
        // {
        //     CalcFormula = count(Customer where(Status = const("Non-Active")));
        //     FieldClass = FlowField;
        // }
        field(4; "Dormant Fosa"; Integer)
        {
            CalcFormula = count(Vendor where(Status = const(Dormant)));
            FieldClass = FlowField;
        }

        field(5; "Closed Fosa"; Integer)
        {
            CalcFormula = count(Vendor where(Status = const(Closed)));
            FieldClass = FlowField;
        }
        field(6; "Frozen Fosa"; Integer)
        {
            CalcFormula = count(Vendor where(Status = const(Frozen)));
            FieldClass = FlowField;
        }

        field(7; "Deceased Fosa"; Integer)
        {
            // CalcFormula = count(Customer where(Status = const(Defaulter)));
            // FieldClass = FlowField;
            CalcFormula = count(Vendor where(Status = const(Deceased)));
            FieldClass = FlowField;
        }
        field(8; "Requests to Approve"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Approver ID" = field("User ID"),
                                                        Status = filter(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(9; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Sender ID" = field("User ID"),
                                                        Status = filter(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

