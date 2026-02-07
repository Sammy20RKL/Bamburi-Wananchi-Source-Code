namespace FOSASACCO.FOSASACCO;

page 56999 "Online Portal Users"
{
    ApplicationArea = All;
    Caption = 'Online Portal Users';
    PageType = List;
    SourceTable = "Online Users";
    UsageCategory = Lists;
    CardPageId = "Portal User Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // field("Line No"; Rec."Line No")
                // {
                // }
                field("User Type"; Rec."User Type")
                {
                }
                field("User Name"; Rec."User Name")
                {
                }
                field(IdNumber; Rec.IdNumber)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field("Mobile No"; Rec.MobileNumber)
                {
                }
                field("Changed Password"; Rec."Changed Password")
                {
                }
                field("Date Created"; Rec."Date Created")
                {
                }
                field("Number Of Logins"; Rec."Number Of Logins")
                {
                }
                field(Password; Rec.Password)
                {
                }
            }
        }
    }
}
