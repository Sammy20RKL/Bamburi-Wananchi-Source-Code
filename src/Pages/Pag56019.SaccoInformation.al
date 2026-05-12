Page 56019 "Sacco Information"
{
    ApplicationArea = All;
    Caption = 'Sacco Information';
    PageType = Card;
    Editable = true;
    SourceTable = "Sacco Information";
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Visible = false;
                }
                field("Sacco Principal Activities"; Rec."Sacco Principal Activities")
                {
                    ApplicationArea = all;
                    ToolTip = 'The Sacco Principal activities';
                }
                field("Sacco CEO"; Rec."Sacco CEO")
                {
                    ApplicationArea = all;
                }
                field("Sacco CEO Name"; Rec."Sacco CEO Name")
                {
                    ApplicationArea = all;

                }
                field("Sacco CEO P.O Box"; Rec."Sacco CEO P.O Box")
                {
                    ApplicationArea = all;
                }
                field("L.R.No."; Rec."L.R.No.")
                {
                    ApplicationArea = all;

                }
                // field("Floor Number"; "Floor Number")
                // {
                //     ApplicationArea = all;

                // }
                field("P.O Box"; Rec."P.O Box")
                {
                    ApplicationArea = all;

                }

                field("Building Name"; Rec."Building Name")
                {
                    ApplicationArea = all;
                }
                field("Independent Auditor"; Rec."Independent Auditor")
                {
                    ApplicationArea = all;
                }
                field(IndAuditorBOX; Rec.IndAuditorBOX)
                {
                    ApplicationArea = all;
                }
                field(PrincipalBankBox; Rec.PrincipalBankBox)
                {
                    ApplicationArea = all;
                }
                field(PrincipalBankers; Rec.PrincipalBankers)
                {
                    Caption = 'Principal Bankers';
                    ApplicationArea = all;
                }
                field("Principal Bank Branch"; Rec."Principal Bank Branch")
                {
                    ApplicationArea = all;

                }
                field(auditorcerfication; Rec.auditorcerfication)
                {
                    ApplicationArea = all;
                    Caption = 'Auditor Certification Name';
                }
                field("Dividends Interest"; Rec."Dividends Interest") { }
                field("Previous Dividends Interest"; Rec."Previous Dividends Interest") { }
                field("Deposits Interest"; Rec."Deposits Interest") { }
                field("Previous Deposits Interest"; Rec."Previous Deposits Interest") { }




            }
            group("Board of Directors")
            {
                part("Board of Directors Lists"; "Board of Directors Lists")
                {
                    ApplicationArea = all;
                }
            }
            group("Supervisory Commite")
            {
                part("Supervisory Commitee Lists"; "Supervisory Commitee Lists")
                {
                    ApplicationArea = all;
                }
            }
        }


    }
    actions
    {
        area(processing)
        {
            action("Mkopo Account Setup")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // RunObject = page "Mkopo Account Setup";
            }

        }

    }
    trigger OnInit()
    begin
        if Rec.IsEmpty() then
            Rec.Insert();
    end;
}
