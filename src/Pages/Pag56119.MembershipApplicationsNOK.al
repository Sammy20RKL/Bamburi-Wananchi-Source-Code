#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56119 "Membership Applications NOK"
{
    PageType = List;
    SourceTable = "Membership Applications NOK";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Full Names"; Rec."Full Names")
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
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field("Identification No."; Rec."Identification No.")
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation"; Rec."%Allocation")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                        rec.CalcFields(rec."Total %Allocation");
                        if rec."Total %Allocation" > 100 then begin
                            Error('The Next Of Kin Applicants percentage allocation cannot exceed 100 %. It is %1', rec."Total %Allocation");
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        MembershipApplications: record "Membership Applications";
    begin
        MembershipApplications.Reset();
        MembershipApplications.SetRange(MembershipApplications."No.", Rec."Account No");
        if MembershipApplications.Find('-') then begin
            if (MembershipApplications."Approval Status" = MembershipApplications."Approval Status"::Open) or (MembershipApplications."Approval Status" = MembershipApplications."Approval Status"::Rejected) then begin
                CurrPage.Editable := true;
            end else
                CurrPage.Editable := false;
        end;
    end;

    var


}

