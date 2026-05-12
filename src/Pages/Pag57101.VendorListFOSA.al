#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 57101 "Vendor List-FOSA"
{
    ApplicationArea = Basic;
    Editable = false;
    PageType = List;
    DeleteAllowed = false;
    Caption = 'FOSA List ';
    CardPageID = "Vendor Card";
    SourceTable = Vendor;
    SourceTableView = sorting("No.")
                      order(ascending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fosa Account No';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Customer Name';
                }

                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                // field("Card No."; Rec."Card No.")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'ATM Card No.';
                // }
                field("BOSA Account No"; Rec."BOSA Account No")
                {
                    ApplicationArea = Basic;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }

                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Processing"; Rec."Salary Processing")
                {
                    ApplicationArea = Basic;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }

                // field(Contact; Contact)
                // {
                //     ApplicationArea = Basic;
                // }
                field("Personal No."; Rec."Personal No.")
                {
                    ApplicationArea = Basic;
                }

                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                }


                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                // field("Search Name"; Rec."Search Name")
                // {
                //     ApplicationArea = Basic;
                // }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Location Code2"; Rec."Location Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1901138007; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("No."),
                              "Currency Filter" = field("Currency Filter"),
                              "Date Filter" = field("Date Filter"),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnAfterGetRecord()
    begin
    end;

    var


}

