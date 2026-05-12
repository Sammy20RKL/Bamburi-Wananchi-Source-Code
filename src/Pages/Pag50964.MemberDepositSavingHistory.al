#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50964 "Member Deposit Saving History"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = 51916;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Out"; Rec."Amount Out")
                {
                    ApplicationArea = Basic;
                }
                field("Amount In"; Rec."Amount In")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

