pageextension 50999 "User Settings Ext" extends "User Settings"
{

    trigger OnOpenPage()
    begin
        if (UserId <> 'SWIZZSOFT') and (UserId <> 'FRANKLINE') then
            CurrPage.Editable := false;
    end;
}
