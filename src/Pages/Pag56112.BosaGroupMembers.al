Page 56112 "Bosa Group Members"
{
    ApplicationArea = All;
    Caption = 'Bosa Group Members';
    PageType = Card;
    SourceTable = "Bosa Member App Group Members";
    DataCaptionFields = Name;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("ID Number/Passport Number"; Rec."ID Number/Passport Number")
                {
                    ToolTip = 'Specifies the value of the ID Number/Passport Number field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name  field.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ToolTip = 'Specifies the value of the Date of Birth field.';
                }
                field(Nationality; Rec.Nationality)
                {
                    ToolTip = 'Specifies the value of the Nationality field.';
                }
                field("Mobile Phone Number"; Rec."Mobile Phone Number")
                {
                    ToolTip = 'Specifies the value of the Mobile Phone Number field.';
                }
                field(E_Mail; Rec.E_Mail)
                {
                    ToolTip = 'Specifies the value of the E_Mail field.';
                }
                field(Ocupation; Rec.Ocupation)
                {
                    ToolTip = 'Specifies the value of the Ocupation field.';
                }
                field(Employer; Rec.Employer)
                {
                    ToolTip = 'Specifies the value of the Employer field.';
                }
                field(Occupation; Rec.Occupation)
                {
                    ToolTip = 'Specifies the value of the Occupation field.';
                }

            }



        }
        area(factboxes)
        {
            part(Control149; "Bosa Member Picture")
            {

                ApplicationArea = all;
                SubPageLink = "ID Number/Passport Number" = FIELD("ID Number/Passport Number");
                Visible = true;

            }

            part(Control150; "Bosa Member Signature")
            {

                ApplicationArea = all;
                SubPageLink = "ID Number/Passport Number" = FIELD("ID Number/Passport Number");
                Visible = true;
            }
        }
    }
}
