#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56130 "Members Kin Details List"
{
    PageType = List;
    Editable = false;
    SourceTable = "Members Next Kin Details";
    SourceTableView = where(Type = const("Next of Kin"));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                // field(Type; Rec.Type)
                // {
                //     ApplicationArea = Basic;
                // }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'Id/Birth Cert No.';
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }
                // field("%Allocation"; Rec."%Allocation")
                // {
                //     ApplicationArea = Basic;
                // }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                // field("Account No"; Rec."Account No")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        // StatusPermissions.Reset;
        // StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
        // StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::Nominee);
        // if StatusPermissions.Find('-') = false then
        //     Error('You do not have permissions to View This information.');
    end;

    var
        StatusPermissions: Record "Status Change Permision";
}

