namespace FOSASACCO.FOSASACCO;

page 57000 "Portal User Card"
{
    ApplicationArea = All;
    Caption = 'Portal User Card';
    PageType = Card;
    SourceTable = "Online Users";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                // field("Line No"; Rec."Line No")
                // {
                //     Editable = false;
                // }
                field("User Name"; Rec."User Name")
                {
                    Editable = false;
                }
                field("User Type"; Rec."User Type")
                {
                    Editable = false;
                }
                field(Email; Rec.Email)
                {
                }
                field(IdNumber; Rec.IdNumber)
                {
                }
                field("Mobile No"; Rec.MobileNumber)
                {
                }
                field("Changed Password"; Rec."Changed Password")
                {
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                }
                field("Number Of Logins"; Rec."Number Of Logins")
                {
                    Editable = false;
                }
                field(Password; Rec.Password)
                {
                }
            }
        }
    }
}
