#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56027 "Member List"
{
    ApplicationArea = Basic;
    Caption = 'Member List';
    CardPageID = "Member Account Card";
    Editable = false;
    DeleteAllowed = true;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = sorting("No.")
                      order(ascending)
                      where("Customer Type" = filter(Member),
                            "Customer Posting Group" = filter('MEMBER'));
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
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Payroll No"; Rec."Personal No")
                {
                    Caption = 'Payroll No';
                    ApplicationArea = basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile Phone';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = basic;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                // field("Shares Retained"; Rec."Shares Retained")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Share Capital';
                // }
                // field("Current Shares"; Rec."Current Shares")
                // {
                //     Caption = 'Non-withdrawable Deposits';
                //     Style = StrongAccent;
                //     ApplicationArea = Basic;
                // }
            }
        }
        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
                Visible = true;
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        area(Processing)
        {
            group(ActionGroup1102755007)
            {
                action(DetailedStatement)
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "process";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50223, true, false, Cust);
                    end;
                }
                action(GStatement)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "process";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51031, true, false, Cust);
                    end;
                }
                action("Shares Statement")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    visible = false;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50302, true, false, Cust);
                    end;
                }
                action("Loans Statement")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    visible = false;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50608, true, false, Cust);
                    end;
                }
                action("Shares Certificate")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    //visible = false;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50303, true, false, Cust);
                    end;
                }
                action(MemberStatementActive)
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Member Active';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "process";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51046, true, false, Cust);
                    end;
                }

                action(Statement)
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    //visible = false;
                    Caption = 'Member Statement';
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50223, true, false, Cust);
                    end;
                }

            }
        }
    }
    trigger OnAfterGetRecord()
    begin

    end;


    var
        SwizzsoftFactory: Codeunit "swizzsoft Factory";
        Cust: Record Customer;
        GeneralSetup: Record "Sacco General Set-Up";
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        TotalAvailable: Integer;
        Loans: Record "Loans Register";
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        TotalDefaulterR: Decimal;
        Value2: Decimal;
        AvailableShares: Decimal;
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        RoundingDiff: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
}

