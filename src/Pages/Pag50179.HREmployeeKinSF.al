#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50179 "HR Employee Kin SF"
{
    Caption = 'HR Employee Kin & Beneficiaries';
    PageType = List;
    SourceTable = "HR Employee Kin";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }
                field(SurName; Rec.SurName)
                {
                    ApplicationArea = Basic;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = Basic;
                }
                field("ID No/Passport No"; Rec."ID No/Passport No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("Office Tel No"; Rec."Office Tel No")
                {
                    ApplicationArea = Basic;
                }
                field("Home Tel No"; Rec."Home Tel No")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Next of Kin")
            {
                Caption = '&Next of Kin';
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const("Employee Relative"),
                                  "No." = field("Employee Code"),
                                  "Table Line No." = field("Line No.");
                }
            }
        }
    }

    var
        D: Date;
}

