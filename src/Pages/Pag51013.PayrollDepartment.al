page 51013 PayrollDepartment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PayrollDepartments;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(code; Rec.code)
                {
                    ApplicationArea = All;

                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}