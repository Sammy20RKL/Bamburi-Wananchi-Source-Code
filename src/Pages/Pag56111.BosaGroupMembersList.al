Page 56111 "Bosa Group Members List"
{
    ApplicationArea = All;
    Caption = 'Bosa Group Members List';
    PageType = List;
    CardPageId = "Bosa Group Members";
    SourceTable = "Bosa Member App Group Members";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = true;


    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field("Specimen Signature"; Rec."Specimen Signature")
                {
                    ToolTip = 'Specifies the value of the Specimen Signature field.';
                }
                field("Specimen Passport"; Rec."Specimen Passport")
                {
                    ToolTip = 'Specifies the value of the Specimen Passport field.';
                }
            }
        }
    }
}
