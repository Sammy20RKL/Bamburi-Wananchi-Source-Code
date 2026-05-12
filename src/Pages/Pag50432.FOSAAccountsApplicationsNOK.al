#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50432 "FOSA Accounts Applications NOK"
{
    PageType = Card;
    SourceTable = "FOSA Account App Kin Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ApplicationArea = Basic;
                }
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
                field(Fax; Rec.Fax)
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation"; Rec."%Allocation")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Total Allocation");
                        if Rec."%Allocation" > Rec."Maximun Allocation %" then
                            Error(' Total allocation should be equal to 100 %');
                    end;
                }
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
        Rec."Maximun Allocation %" := 100;
        //MODIFY;
    end;
}

