table 50057 "Members Cues"
{

    fields
    {
        field(1; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(2; "All Members"; Integer)
        {
            CalcFormula = count(Customer where("Customer Posting Group" = filter('Member')));
            FieldClass = FlowField;
        }

        field(3; "Active Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = const("Active"), "Customer Posting Group" = filter('Member')));
            FieldClass = FlowField;
        }
        field(4; "NonActive Mbrs"; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Dormant), "Customer Posting Group" = filter('Member')));
            FieldClass = FlowField;
        }

        field(5; Deceased; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Deceased), "Customer Posting Group" = filter('Member')));
            FieldClass = FlowField;
        }

        field(6; Exited; Integer)
        {
            CalcFormula = count(Customer where(Status = const(Withdrawal), "Customer Posting Group" = filter('Member')));
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

        field(10; "Awaiting Exit"; Integer)
        {
            CalcFormula = count(Customer where(Status = const("Awaiting Withdrawal"), "Customer Posting Group" = filter('Member')));
            FieldClass = FlowField;
        }
        field(13; Female; Integer)
        {
            CalcFormula = count(Customer where(Gender = Const(Female), "Customer Posting Group" = filter('Member')));
            FieldClass = FlowField;
        }
        field(14; Male; Integer)
        {
            CalcFormula = count(Customer where(Gender = Const(Male), "Customer Posting Group" = filter('Member')));
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

