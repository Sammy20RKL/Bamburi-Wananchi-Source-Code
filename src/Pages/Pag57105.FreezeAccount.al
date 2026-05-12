Page 57105 "Freeze Account"
{
    Caption = 'Freeze Account Comment';
    PageType = ListPart;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = '  ';
                Editable = true;
                field("Reason For Freezing Account"; "Reason For Freezing Account")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Caption = 'Reason For Status Change';
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
    }

    var
        "Reason For Freezing Account": Text[100];

    procedure GetEnteredReason(): Text
    begin
        exit("Reason For Freezing Account");
    end;
}

