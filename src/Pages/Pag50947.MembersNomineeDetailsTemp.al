#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50947 "Members Nominee Details Temp"
{
    PageType = ListPart;
    SourceTable = 51464;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Add New"; Rec."Add New")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No.(New)"; Rec."ID No.(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Address(New)"; Rec."Address(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Relationship(New)"; Rec."Relationship(New)")
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation"; Rec."%Allocation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("%Allocation(New)"; Rec."%Allocation(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Next Of Kin Type"; Rec."Next Of Kin Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Next Of Kin Type(New)"; Rec."Next Of Kin Type(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date of Birth(New)"; Rec."Date of Birth(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Telephone(New)"; Rec."Telephone(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email(New)"; Rec."Email(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Total Allocation"; Rec."Total Allocation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Allocation(New)"; Rec."Total Allocation(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Remove; Rec.Remove)
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
        if Rec.Name = '' then
            NewEdittable := true;
        if Rec."Add New" = true then
            Nameedittable := true;
    end;

    var
        NewEdittable: Boolean;
        Nameedittable: Boolean;
}

