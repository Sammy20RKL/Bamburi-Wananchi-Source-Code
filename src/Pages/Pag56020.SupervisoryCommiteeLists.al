Page 56020 "Supervisory Commitee Lists"
{
    ApplicationArea = All;
    Caption = 'Supervisory comitee  List';
    PageType = ListPart;
    SourceTable = "Supervisory Commitee";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    TableRelation = customer."No." where(Supervisory = const(true));
                    trigger OnValidate()
                    begin
                        if Cust.Get(Rec."No.") then begin
                            Rec.Name := cust.Name;
                        end;
                    end;
                }
                field(Name; Rec.Name)
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Active; Rec.Active)
                {
                }
                field(Designation; Rec.Designation) { }
            }
        }
    }
    var
        Cust: Record customer;
}
