page 52015 "Company Job List"
{
    ApplicationArea = All;
    Caption = 'Staff Establishment';
    CardPageID = "Company Job Card";
    PageType = List;
    SourceTable = "Company Job";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field("Job Description"; Rec."Job Description")
                {
                    ToolTip = 'Specifies the value of the Job Description field';
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ToolTip = 'Specifies the value of the No of Posts field';
                }
                field("Occupied Position"; Rec."Occupied Position")
                {
                    ToolTip = 'Specifies the value of the Occupied Position field';
                }
                field(Vacancy; Rec.Vacancy)
                {
                    ToolTip = 'Specifies the value of the Vacancy field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //HRManagement.GetVacantPositions(Rec);
    end;

    var
        HRManagement: Codeunit "HR Management";
}





