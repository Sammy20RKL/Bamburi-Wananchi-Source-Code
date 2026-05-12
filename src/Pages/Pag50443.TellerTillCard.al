#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50443 "Teller Till Card"
{
    Caption = 'Teller Till Card';
    Editable = false;
    PageType = Card;
    SourceTable = "Bank Account";
    SourceTableView = where("Account Type" = filter(Cashier));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic;
                }
                field(Control22; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Balance"; Rec."Min. Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Our Contact Code"; Rec."Our Contact Code")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                }
                field(CashierID; Rec.CashierID)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Maximum Teller Withholding"; Rec."Maximum Teller Withholding")
                {
                    ApplicationArea = Basic;
                }
                field("Max Withdrawal Limit"; Rec."Max Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Max Deposit Limit"; Rec."Max Deposit Limit")
                {
                    ApplicationArea = Basic;
                }
                // field("Max Cheque Deposit Limit"; Rec."Max Cheque Deposit Limit")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Last Check No."; Rec."Last Check No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transit No."; Rec."Transit No.")
                {
                    ApplicationArea = Basic;
                }
                field("Last Statement No."; Rec."Last Statement No.")
                {
                    ApplicationArea = Basic;
                }
                field("Balance Last Statement"; Rec."Balance Last Statement")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Acc. Posting Group"; Rec."Bank Acc. Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
            group(Transfer)
            {
                Caption = 'Transfer';
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = Basic;
                }
                field(Iban; Rec.Iban)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Bank Acc.")
            {
                Caption = '&Bank Acc.';
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Date Filter" = field("Date Filter"),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const("Bank Account"),
                                  "No." = field("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(270),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action(Balance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Balance';
                    Image = Balance;
                    RunObject = Page "Bank Account Balance";
                    RunPageLink = "No." = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                }
                action("St&atements")
                {
                    ApplicationArea = Basic;
                    Caption = 'St&atements';
                    RunObject = Page "Bank Account Statement";
                    RunPageLink = "Bank Account No." = field("No.");
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    RunObject = Page "Bank Account Ledger Entries";
                    RunPageLink = "Bank Account No." = field("No.");
                    RunPageView = sorting("Bank Account No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Chec&k Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Chec&k Ledger Entries';
                    Image = CheckLedger;
                    RunObject = Page "Check Ledger Entries";
                    RunPageLink = "Bank Account No." = field("No.");
                    RunPageView = sorting("Bank Account No.");
                }
                action("C&ontact")
                {
                    ApplicationArea = Basic;
                    Caption = 'C&ontact';

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
                action("Cashier Activity Report")
                {
                    ApplicationArea = Basic;
                    Image = Reminder;

                    trigger OnAction()
                    begin
                        TillNo.Reset;
                        TillNo.SetRange(TillNo."No.", Rec."No.");
                        if TillNo.Find('-') then
                            Report.Run(1404, true, false, TillNo)
                    end;
                }
                action("Cashier Activity Report 2")
                {
                    ApplicationArea = Basic;
                    Image = Reminder;

                    trigger OnAction()
                    begin
                        TillNo.Reset;
                        TillNo.SetRange(TillNo."No.", Rec."No.");
                        if TillNo.Find('-') then
                            Report.Run(51516029, true, false, TillNo)
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Check Report Name");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Account Type" := Rec."account type"::Cashier;
    end;

    var
        UsersID: Record User;
        TillNo: Record "Bank Account";
}

