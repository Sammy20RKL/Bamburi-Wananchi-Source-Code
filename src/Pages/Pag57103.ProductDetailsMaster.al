#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 57103 "Product Details Master"
{
    ApplicationArea = Basic;
    CardPageID = "Product Card";
    DeleteAllowed = false;
    Editable = false;
    AnalysisModeEnabled = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Vendor;
    SourceTableView = where("Debtor Type" = const("FOSA Account"));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }

                field("BOSA Account No"; Rec."BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = AttentionAccent;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Go To Member Page';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = field("BOSA Account No");
                }
            }
            group(ActionGroup1102755220)
            {
                action("Page Vendor Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            Report.Run(56890, true, false, Vend)
                    end;
                }
                action("Page Vendor Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "FOSA Statistics";
                    // RunPageLink = "No." = field("No."),
                    //               "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                    //               "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        // Codeunit.Run(Codeunit::"Adjust Gen. Journal Balance", GenJnlLine);
        // Codeunit.Run(Codeunit::SwizzKashMobile);
    end;

    var
        Cust: Record Customer;
        Vend: Record Vendor;
        Audit: Record "Audit Entries";
        EntryNos: Integer;
}

