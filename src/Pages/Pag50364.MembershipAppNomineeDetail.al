#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50364 "Membership App Nominee Detail"
{
    PageType = List;
    SourceTable = "Member App Nominee";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }

                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    ShowMandatory = true;
                }

                field(Beneficiary; Rec.Beneficiary)
                {
                    ApplicationArea = Basic;
                }
                field("Next Of Kin Type"; Rec."Next Of Kin Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field(Address; Rec.Address)
                // {
                //     ApplicationArea = Basic;
                // }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                // field(Description; Rec.Description)
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Email; Rec.Email)
                // {
                //     ApplicationArea = Basic;
                // }
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'Id/Birth Cert No.';
                    ApplicationArea = Basic;
                }
                field("%Allocation"; Rec."%Allocation")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        MemberApp.Reset;
        MemberApp.SetRange(MemberApp."No.", Rec."Account No");
        if MemberApp.Find('-') then begin
            if MemberApp.Status = MemberApp.Status::Approved then begin                        //MESSAGE(FORMAT(MemberApp.Status));
                CurrPage.Editable := false;
            end else
                CurrPage.Editable := true;
        end;
        Rec."Maximun Allocation %" := 100;
    end;

    var
        MemberApp: Record 51360;
        ReltnShipTypeEditable: Boolean;
}

