page 70748 "Batches List"
{
    Caption = 'Batches';
    PageType = List;
    SourceTable = Batches;
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Batch No_"; Rec."Batch No_")
                {
                    ApplicationArea = All;
                }
                field("Description Remarks"; Rec."Description Remarks")
                {
                    ApplicationArea = All;
                }
                field("Batch Type"; Rec."Batch Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }


                field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
                {
                    ApplicationArea = All;
                }
                field("Document No_"; Rec."Document No_")
                {
                    ApplicationArea = All;
                }
                field("Cheque No_"; Rec."Cheque No_")
                {
                    ApplicationArea = All;
                }
                field("BOSA Bank Account"; Rec."BOSA Bank Account")
                {
                    ApplicationArea = All;
                }

                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                }


            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
        area(Navigation)
        {

        }
    }
}