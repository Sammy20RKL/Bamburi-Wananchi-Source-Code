// namespace KRBERPSourceCode.KRBERPSourceCode;

page 57016 "Online Loan Application Card"
{
    ApplicationArea = All;
    Caption = 'Online Loan Application Card';
    PageType = Card;
    Editable = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    SourceTable = "Online Loan Application";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Application No"; Rec."Application No")
                {
                }
                field("Application Date"; Rec."Application Date")
                {
                }
                field("BOSA No"; Rec."BOSA No")
                {
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                }
                field(Email; Rec.Email)
                {
                }
                field("Employment No"; Rec."Employment No")
                {
                }
                field("Home Address"; Rec."Home Address")
                {
                }
                field("Id No"; Rec."Id No")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                }
                field("Loan No"; Rec."Loan No")
                {
                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                }
                field("Loan Type"; Rec."Loan Type")
                {
                }
                field("Member Names"; Rec."Member Names")
                {
                }
                field("Membership No"; Rec."Membership No")
                {
                }
                field(Telephone; Rec.Telephone)
                {
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                }
                field("Sent To Bosa Loans"; Rec."Sent To Bosa Loans")
                {
                }
                field(Source; Rec.Source)
                {
                }
                field("Is Top Up"; Rec."Is Top Up")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
                field(Station; Rec.Station)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field(Refno; Rec.Refno)
                {
                }
                field(submitted; Rec.submitted)
                {
                }
                field("Application Status"; Rec."Application Status") { }
            }

            part(Guarantors; "Online Loan Guarantors")
            {
                Caption = 'Guarantors  Detail';
                ApplicationArea = Basic;
                SubPageLink = "Loan Application No" = field("Application No");
            }

        }

        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("BOSA No");
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Download Application Form")
            {
                ApplicationArea = All;
                Caption = 'Download Application Form';
                ToolTip = 'Generates and prints/downloads the official Loan Application Form, pre-filled with the member, loan and guarantor details captured so far.';
                Image = PrintReport;


                trigger OnAction()
                var
                    laonapp: Record "Online Loan Application";
                begin
                    laonapp.SetRange("Application No", Rec."Application No");
                    Report.RunModal(Report::"Loan Application Form", true, false, laonapp);



                end;
            }
        }
    }
}
