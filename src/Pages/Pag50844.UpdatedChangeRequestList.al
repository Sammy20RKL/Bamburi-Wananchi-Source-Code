#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50844 "Updated Change Request List"
{
    CardPageID = "Updated Change Request Card";
    Editable = false;
    PageType = List;
    SourceTable = 51552;
    SourceTableView = where(Changed = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(signinature; Rec.signinature)
                {
                    ApplicationArea = Basic;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No"; Rec."Personal No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = Basic;
                }
                field("Card No"; Rec."Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Home Address"; Rec."Home Address")
                {
                    ApplicationArea = Basic;
                }
                field(Loaction; Rec.Loaction)
                {
                    ApplicationArea = Basic;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    ApplicationArea = Basic;
                }
                field(District; Rec.District)
                {
                    ApplicationArea = Basic;
                }
                field("Reason for change"; Rec."Reason for change")
                {
                    ApplicationArea = Basic;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("S-Mobile No"; Rec."S-Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Approve"; Rec."ATM Approve")
                {
                    ApplicationArea = Basic;
                }
                field("Card Expiry Date"; Rec."Card Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Card Valid From"; Rec."Card Valid From")
                {
                    ApplicationArea = Basic;
                }
                field("Card Valid To"; Rec."Card Valid To")
                {
                    ApplicationArea = Basic;
                }
                field("Date ATM Linked"; Rec."Date ATM Linked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM No."; Rec."ATM No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

