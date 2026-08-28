page 50003 "Member Listing"
{
    ApplicationArea = All;
    Caption = 'Member Listing - Report';
    PageType = List;
    SourceTable = Customer;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Member No.';
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Member Name';
                    ToolTip = 'Specifies the name of the customer.';
                }
                field(Age; Rec.Age)
                {
                    Caption = 'Age';
                    ToolTip = 'Specifies the value of the Age field.', Comment = '%';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    Caption = 'Date of Birth';
                    ToolTip = 'Specifies the value of the Date of Birth field.', Comment = '%';
                }
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'ID Number';
                    ToolTip = 'Specifies the value of the ID No. field.', Comment = '%';
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    Caption = 'Deposits Contributions';
                    ToolTip = 'Specifies the value of the Shares Retained field.', Comment = '%';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    Caption = 'Outstanding Loans';
                    ToolTip = 'Specifies the value of the Outstanding Balance field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = basic;
                    Caption = 'Status';
                    ToolTip = 'Specifies the status of the customer.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Member Account Card")
            {
                ApplicationArea = All;
                Caption = 'Member Account Card';
                Image = Card;
                RunObject = page "Member Account Card";
            }
            action("Calculate Ages")
            {
                ApplicationArea = All;
                Caption = 'Calculate Ages';
                Image = Calculate;
                trigger OnAction()
                var
                    customer: Record Customer;
                    Dates: Codeunit "Dates Calculation";
                begin
                    customer.Reset();
                    if customer.FindSet() then begin
                        repeat
                            if customer."Date of Birth" <> 0D then
                                customer.Age := Dates.DetermineAge(customer."Date of Birth", Today);
                            customer.Modify();
                        until customer.Next() = 0;
                    end;
                end;
            }
        }
    }
    // trigger OnAfterGetCurrRecord()
    // var
    //     Dates: Codeunit "Dates Calculation";
    // begin
    //     if Rec."Date of Birth" <> 0D then
    //         Rec.Age := Dates.DetermineAge(Rec."Date of Birth", Today);
    // end;
}
