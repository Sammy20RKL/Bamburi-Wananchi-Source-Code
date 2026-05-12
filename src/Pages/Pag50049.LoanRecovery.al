Page 50049 "Loan Recovery"
{
    ApplicationArea = All;
    Caption = 'Loan Recovery List';
    PageType = List;
    CardPageId = "Loan Recovery Card";
    SourceTable = "Loan Recovery Header";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                }
                field("Recovery Type"; Rec."Recovery Type")
                {
                    Editable = false;
                }

                field("Entered By"; Rec."Entered By")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Style = Favorable;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    Editable = false;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    Editable = false;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Entered By", UserId);
    end;
}
