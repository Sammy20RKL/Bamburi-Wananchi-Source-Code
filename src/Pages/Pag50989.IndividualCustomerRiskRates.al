#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50989 "Individual Customer Risk Rates"
{
    Editable = false;
    PageType = CardPart;
    SourceTable = "Individual Customer Risk Rate";

    layout
    {
        area(content)
        {
            field("What is the customer category?"; Rec."What is the customer category?")
            {
                ApplicationArea = Basic;
            }
            field("Customer Category Score"; Rec."Customer Category Score")
            {
                ApplicationArea = Basic;
            }
            field("What is the Member residency?"; Rec."What is the Member residency?")
            {
                ApplicationArea = Basic;
            }
            field("Member Residency Score"; Rec."Member Residency Score")
            {
                ApplicationArea = Basic;
            }
            field("Cust Employment Risk?"; Rec."Cust Employment Risk?")
            {
                ApplicationArea = Basic;
            }
            field("Cust Employment Risk Score"; Rec."Cust Employment Risk Score")
            {
                ApplicationArea = Basic;
            }
            field("Cust Business Risk Industry?"; Rec."Cust Business Risk Industry?")
            {
                ApplicationArea = Basic;
            }
            field("Cust Bus. Risk Industry Score"; Rec."Cust Bus. Risk Industry Score")
            {
                ApplicationArea = Basic;
            }
            field("Lenght Of Relationship?"; Rec."Lenght Of Relationship?")
            {
                ApplicationArea = Basic;
            }
            field("Length Of Relation Score"; Rec."Length Of Relation Score")
            {
                ApplicationArea = Basic;
            }
            field("Cust Involved in Intern. Trade"; Rec."Cust Involved in Intern. Trade")
            {
                ApplicationArea = Basic;
            }
            field("Involve in Inter. Trade Score"; Rec."Involve in Inter. Trade Score")
            {
                ApplicationArea = Basic;
            }
            field("Electronic Payments?"; Rec."Electronic Payments?")
            {
                ApplicationArea = Basic;
            }
            field("Electronic Payments Score"; Rec."Electronic Payments Score")
            {
                ApplicationArea = Basic;
            }
            field("Account Type Taken?"; Rec."Account Type Taken?")
            {
                ApplicationArea = Basic;
            }
            field("Account Type Taken Score"; Rec."Account Type Taken Score")
            {
                ApplicationArea = Basic;
            }
            field("Card Type Taken"; Rec."Card Type Taken")
            {
                ApplicationArea = Basic;
            }
            field("Card Type Taken Score"; Rec."Card Type Taken Score")
            {
                ApplicationArea = Basic;
            }
            field("Channel Taken?"; Rec."Channel Taken?")
            {
                ApplicationArea = Basic;
            }
            field("Channel Taken Score"; Rec."Channel Taken Score")
            {
                ApplicationArea = Basic;
            }
            field("GROSS CUSTOMER AML RISK RATING"; Rec."GROSS CUSTOMER AML RISK RATING")
            {
                ApplicationArea = Basic;
            }
            field("BANK'S CONTROL RISK RATING"; Rec."BANK'S CONTROL RISK RATING")
            {
                ApplicationArea = Basic;
            }
            field("CUSTOMER NET RISK RATING"; Rec."CUSTOMER NET RISK RATING")
            {
                ApplicationArea = Basic;
            }
            field("Risk Rate Scale"; Rec."Risk Rate Scale")
            {
                ApplicationArea = Basic;
                StyleExpr = FieldStyle;
            }
        }
    }

    actions
    {
    }

    var
        FieldStyle: Text;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        if Rec."Risk Rate Scale" = Rec."risk rate scale"::"Low Risk" then begin
            FieldStyle := 'Standard'
        end else
            if Rec."Risk Rate Scale" = Rec."risk rate scale"::"Medium Risk" then begin
                FieldStyle := 'Strong'

            end else
                if Rec."Risk Rate Scale" = Rec."risk rate scale"::"High Risk" then
                    FieldStyle := 'Attention'
    end;
}

