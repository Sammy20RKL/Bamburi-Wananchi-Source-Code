#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50176 "HR Employee List"
{
    ApplicationArea = Basic;
    CardPageID = "HR Employee Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Employee';
    SourceTable = "HR Employees";
    SourceTableView = where(Status = filter(Active | Inactive),
                            IsCommette = const(false),
                            IsBoard = const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }

                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    ApplicationArea = Basic;
                    Caption = 'Phone Number';
                }
            }
        }
        area(factboxes)
        {

        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         // group(Employee)
    //         // {
    //         //     Caption = 'Employee';

    //         action("Kin/Beneficiaries")
    //         {
    //             ApplicationArea = Basic;
    //             Caption = 'Kin/Beneficiaries';
    //             Image = Relatives;
    //             Promoted = true;
    //             PromotedCategory = Category4;
    //             PromotedIsBig = true;
    //             RunObject = Page "HrEmployee Relatives";
    //             RunPageLink = "Employee No." = field("No.");
    //         }



    //         // }
    //     }
    // }

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;


}

