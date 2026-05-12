#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50661 "Un Allocated Funds List"
{
    PageType = List;
    SourceTable = Customer;
    SourceTableView = where("Un-allocated Funds" = filter(> 0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Holiday Contribution"; Rec."Holiday Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Un-allocated Funds"; Rec."Un-allocated Funds")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control7; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("No.");
                Visible = true;
            }
        }
    }

    actions
    {
    }
}

