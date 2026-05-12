#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50070 "Imprest Details"
{
    PageType = ListPart;
    SourceTable = "Imprest Lines";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Advance Type"; Rec."Advance Type")
                {
                    ApplicationArea = Basic;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Account No:"; Rec."Account No:")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("No of Days"; Rec."No of Days")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Daily Rate(Amount)"; Rec."Daily Rate(Amount)")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        /*{Get the total amount paid}
                        Bal:=0;
                        
                        PayHeader.RESET;
                        PayHeader.SETRANGE(PayHeader."Line No.",No);
                        IF PayHeader.FINDFIRST THEN
                          BEGIN
                            PayLine.RESET;
                            PayLine.SETRANGE(PayLine.No,PayHeader."Line No.");
                            IF PayLine.FIND('-') THEN
                              BEGIN
                                REPEAT
                                  Bal:=Bal + PayLine."Pay Mode";
                                UNTIL PayLine.NEXT=0;
                              END;
                          END;
                        //Bal:=Bal + Amount;
                        
                        IF Bal > PayHeader.Amount THEN
                          BEGIN
                            ERROR('Please ensure that the amount inserted does not exceed the amount in the header');
                          END;
                          */

                    end;
                }
                field("Imprest Holder"; Rec."Imprest Holder")
                {
                    ApplicationArea = Basic;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = Basic;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Issued"; Rec."Date Issued")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        PayHeader: Record "Pending Vch. Surr. Line";
        PayLine: Record "Receipt Line";
        Bal: Decimal;
}

