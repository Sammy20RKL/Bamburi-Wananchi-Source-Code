pageextension 50012 "UserSetupPageExt" extends "User Setup"
{
    actions
    {
        addlast(Processing)
        {
            action("User Signature")
            {
                ApplicationArea = All;
                Caption = 'User Signature';
                Image = Signature;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "User Signatures";
                RunPageLink = "User ID" = field("User ID");
                ToolTip = 'Executes the User Signature action';
            }

            action(OpenCard)
            {
                ApplicationArea = All;
                Caption = 'Open Card';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "User Setup Card";
                RunPageLink = "User ID" = field("User ID");
                ToolTip = 'Opens the User Setup Card page';
            }
        }
    }
}





