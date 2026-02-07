page 52014 "Company Job Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Company Job";
    Caption = 'Company Job Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field("Job Designation"; Rec."Job Description")
                {
                    ToolTip = 'Specifies the value of the Job Description field';
                }
                field("Dimension 2"; Rec."Dimension 2")
                {
                    Visible = true;
                    ToolTip = 'Specifies the value of the Dimension 2 field';
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Department Name field';
                }
                field("Position Reporting to"; Rec."Position Reporting to")
                {
                    Caption = 'Immediate Supervisor';
                    ToolTip = 'Specifies the value of the Immediate Supervisor field';
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field';
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ToolTip = 'Specifies the value of the No of Posts field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Occupied Position"; Rec."Occupied Position")
                {
                    ToolTip = 'Specifies the value of the Occupied Position field';

                    trigger OnDrillDown()
                    begin
                        Employee.Reset();
                        Employee.SetRange("Job Position", Rec."Job ID");
                        if Employee.Find('-') then
                            Page.Run(Page::"Employee List", Employee);
                    end;
                }
                field(Vacancy; Rec.Vacancy)
                {
                    ToolTip = 'Specifies the value of the Vacancy field';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
            }
            group("Objective/Function")
            {
                Caption = 'Objective/Function';

                field(Objective; Rec.Objective)
                {
                    Caption = 'Objectives';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Objectives field';
                }
            }
            // part(KeyJobResponsibilities; "Key Job Responsibilities")
            // {
            //     SubPageLink = Code = field("Job ID");
            // }
            // part(Academics; "Company Job Education")
            // {
            //     Caption = 'Academic Qualifications';
            //     SubPageLink = "Job Id" = field("Job ID"), "Education Level" = filter(<> Professional);
            // }
            // part(Experience; "Company Job Experience")
            // {
            //     Caption = 'Experience Qualifications';
            //     SubPageLink = "Job Id" = field("Job ID");
            // }
            // part(ProfessionalCourse; "Company Job Prof course")
            // {
            //     SubPageLink = "Job Id" = field("Job ID");
            // }
            // part(ProfessionalMembership; "Company Job Prof Membership")
            // {
            //     SubPageLink = "Job Id" = field("Job ID");
            // }
            // part(Control13; "Job Requirements Lines")
            // {
            //     SubPageLink = "Job Id" = field("Job ID");
            //     Visible = false;
            // }
            // part("Position Supervising"; "Positions Supervising")
            // {
            //     Caption = 'Position Supervising';
            //     SubPageLink = "Job ID" = field("Job ID");
            // }
            // part(Control18; "Job Attachments")
            // {
            //     SubPageLink = "Job ID" = field("Job ID");
            //     Visible = false;
            // }
            // part(Control19; "Job Attachments")
            // {
            //     SubPageLink = "Job ID" = field("Job ID");
            // }
            group("Job Interviews")
            {
                Visible = false;

                field("Oral Interview"; Rec."Oral Interview")
                {
                    ToolTip = 'Specifies the value of the Oral Interview field';
                }
                field("Oral Interview (Board)"; Rec."Oral Interview (Board)")
                {
                    ToolTip = 'Specifies the value of the Oral Interview (Board) field';
                }
                field(Classroom; Rec.Classroom)
                {
                    ToolTip = 'Specifies the value of the Classroom field';
                }
                field(Practical; Rec.Practical)
                {
                    ToolTip = 'Specifies the value of the Practical field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Career Plan")
            {
                // RunObject = page "Job Career Plan";
                // RunPageLink = "Job ID" = field("Job ID");
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = Planning;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DepartmentName := '';

        GetDeptName();

        //  HRManagement.GetVacantPositions(Rec);
    end;

    trigger OnOpenPage()
    begin
        DepartmentName := '';

        GetDeptName();
    end;

    var
        Employee: Record "HR Employees";
        HRManagement: Codeunit "HR Management";
        DepartmentName: Text;

    local procedure GetDeptName(): Text
    var
        Dimensions: Record "Dimension Value";
    begin
        Dimensions.Reset();
        Dimensions.SetRange(Code, Rec."Dimension 2");
        if Dimensions.Find('-') then
            DepartmentName := Dimensions.Name;
    end;
}





