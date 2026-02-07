#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50354 "Member Holiday Savings List"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Holiday Savings Table";
    SourceTableView = where("Holiday Savings Paid Out" = filter(> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Holiday Savings Paid Out"; Rec."Holiday Savings Paid Out")
                {
                    ApplicationArea = Basic;
                }
                field("Holiday Interest Paid Out"; Rec."Holiday Interest Paid Out")
                {
                    ApplicationArea = Basic;
                }
                field("Total Paid Out"; Rec."Total Paid Out")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control8; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Member No");
            }
        }
    }

    actions
    {
    }
}

