#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56016 InputOTP
{

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("Input OTP"; InputOTP)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
    }

    var
        InputOTP: Integer;


    procedure GetEnteredOTP(): Integer
    begin
    end;
}

