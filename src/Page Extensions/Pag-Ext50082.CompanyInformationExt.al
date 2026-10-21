pageextension 50082 "CompanyInformationExt" extends "Company Information"
{
    layout
    {
        addafter("VAT Registration No.")
        {
            field("Sacco Society CS Number"; Rec."Sacco Society CS Number")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Sacco Society''s CS registration number with the Commissioner for Co-operative Development / SASRA, used on regulatory returns.';
            }
        }
    }
}
