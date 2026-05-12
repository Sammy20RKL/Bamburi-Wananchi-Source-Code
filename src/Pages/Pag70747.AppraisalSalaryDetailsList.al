page 70747 "Appraisal Salary Details List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Appraisal Salary Details";
    Caption = 'Appraisal Salary Details';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = All;
                }

                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Type"; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {

        }
    }
}