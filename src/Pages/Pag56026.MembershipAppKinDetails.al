#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56026 "Membership App Kin Details"
{
    PageType = List;
    SourceTable = "Member App Next Of kin";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                // field(Beneficiary; Rec.Beneficiary)
                // {
                //     ApplicationArea = Basic;
                // }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                // field(Fax; Rec.Fax)
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
                // field("%Allocation"; Rec."%Allocation")
                // {
                //     ApplicationArea = Basic;
                // }


            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Maximun Allocation %" := 100;

    end;

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
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
}

