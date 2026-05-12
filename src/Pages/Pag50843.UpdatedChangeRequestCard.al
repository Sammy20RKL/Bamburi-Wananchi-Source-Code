#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50843 "Updated Change Request Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Change Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = TypeEditable;

                    trigger OnValidate()
                    begin
                        AccountVisible := false;
                        MobileVisible := false;
                        AtmVisible := false;
                        nxkinvisible := false;

                        // if Type = Type::"M-Banking Change" then begin
                        //     MobileVisible := true;
                        // end;

                        // if Type = Type::"ATM Change" then begin
                        //     AtmVisible := true;
                        // end;

                        if Rec.Type = Rec.Type::"BOSA Change" then begin
                            AccountVisible := true;
                            nxkinvisible := true;
                        end;

                        // if Type = Type::"FOSA Change" then begin
                        //     AccountVisible := true;
                        //     nxkinvisible := true;
                        // end;
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Captured by"; Rec."Captured by")
                {
                    ApplicationArea = Basic;
                }
                field("Capture Date"; Rec."Capture Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved by"; Rec."Approved by")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
            group(Mobile)
            {
                Caption = 'Phone No Details';
                Visible = Mobilevisible;
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile No(New Value)"; Rec."Mobile No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No(New Value)';
                    Editable = MobileNoEditable;
                }
                field("S-Mobile No"; Rec."S-Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("S-Mobile No(New Value)"; Rec."S-Mobile No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'S-Mobile No(New Value)';
                    Editable = SMobileNoEditable;
                }
            }
            group(s)
            {
                Caption = 'ATM Card Details';
                Visible = Atmvisible;
                field("ATM Approve"; Rec."ATM Approve")
                {
                    ApplicationArea = Basic;
                    Editable = ATMApproveEditable;
                }
                field("Card Expiry Date"; Rec."Card Expiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = CardExpiryDateEditable;
                }
                field("Card Valid From"; Rec."Card Valid From")
                {
                    ApplicationArea = Basic;
                    Editable = CardValidFromEditable;
                }
                field("Card Valid To"; Rec."Card Valid To")
                {
                    ApplicationArea = Basic;
                    Editable = CardValidToEditable;
                }
                field("Date ATM Linked"; Rec."Date ATM Linked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM No."; Rec."ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = ATMNOEditable;
                }
                field("ATM Issued"; Rec."ATM Issued")
                {
                    ApplicationArea = Basic;
                    Editable = ATMIssuedEditable;
                }
                field("ATM Self Picked"; Rec."ATM Self Picked")
                {
                    ApplicationArea = Basic;
                    Editable = ATMSelfPickedEditable;
                }
                field("ATM Collector Name"; Rec."ATM Collector Name")
                {
                    ApplicationArea = Basic;
                    Editable = ATMCollectorNameEditable;
                }
                field("ATM Collectors ID"; Rec."ATM Collectors ID")
                {
                    ApplicationArea = Basic;
                    Editable = ATMCollectorIDEditable;
                }
                field("Atm Collectors Moile"; Rec."Atm Collectors Moile")
                {
                    ApplicationArea = Basic;
                    Editable = ATMCollectorMobileEditable;
                }
                field("Responsibility Centers"; Rec."Responsibility Centers")
                {
                    ApplicationArea = Basic;
                    Editable = ResponsibilityCentreEditable;
                }
            }
            group("Account Info")
            {
                Caption = 'Account Details';
                Visible = Accountvisible;
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Name(New Value)"; Rec."Name(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name(New Value)';
                    Editable = NameEditable;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                    Editable = PictureEditable;
                }
                field(signinature; Rec.signinature)
                {
                    ApplicationArea = Basic;
                    Editable = SignatureEditable;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Address(New Value)"; Rec."Address(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Address(New Value)';
                    Editable = AddressEditable;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("City(New Value)"; Rec."City(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'City(New Value)';
                    Editable = CityEditable;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email(New Value)"; Rec."Email(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Email(New Value)';
                    Editable = EmailEditable;
                }
                field("Personal No"; Rec."Personal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No(New Value)"; Rec."Personal No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Personal No(New Value)';
                    Editable = PersonalNoEditable;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No(New Value)"; Rec."ID No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No(New Value)';
                    Editable = IDNoEditable;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Marital Status(New Value)"; Rec."Marital Status(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status(New Value)';
                    Editable = MaritalStatusEditable;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Passport No.(New Value)"; Rec."Passport No.(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.(New Value)';
                    Editable = PassPortNoEditbale;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type(New Value)"; Rec."Account Type(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Type(New Value)';
                    Editable = AccountTypeEditible;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category(New Value)"; Rec."Account Category(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Category(New Value)';
                    Editable = AccountCategoryEditable;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Section(New Value)"; Rec."Section(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Section(New Value)';
                    Editable = SectionEditable;
                }
                field("Card No"; Rec."Card No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Card No(New Value)"; Rec."Card No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Card No(New Value)';
                    Editable = CardNoEditable;
                }
                field("Home Address"; Rec."Home Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Address(New Value)"; Rec."Home Address(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Address(New Value)';
                    Editable = HomeAddressEditable;
                }
                field(Loaction; Rec.Loaction)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loaction(New Value)"; Rec."Loaction(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loaction(New Value)';
                    Editable = LocationEditable;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub-Location(New Value)"; Rec."Sub-Location(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sub-Location(New Value)';
                    Editable = SubLocationEditable;
                }
                field(District; Rec.District)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("District(New Value)"; Rec."District(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'District(New Value)';
                    Editable = DistrictEditable;
                }
                field("Member Account Status"; Rec."Member Account Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Account Status(NewValu)"; Rec."Member Account Status(NewValu)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Account Status(New Value)';
                    Editable = MemberStatusEditable;
                }
                field("Charge Reactivation Fee"; Rec."Charge Reactivation Fee")
                {
                    ApplicationArea = Basic;
                    Editable = ReactivationFeeEditable;
                }
                field("Reason for change"; Rec."Reason for change")
                {
                    ApplicationArea = Basic;
                    Editable = ReasonForChangeEditable;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Signing Instructions(NewValue)"; Rec."Signing Instructions(NewValue)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signing Instructions(New Value)';
                    Editable = SigningInstructionEditable;
                }
                field("Monthly Contributions"; Rec."Monthly Contributions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contributions(NewValu)"; Rec."Monthly Contributions(NewValu)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthly Contributions(New Value)';
                    Editable = MonthlyContributionEditable;
                }
                field("Member Cell Group"; Rec."Member Cell Group")
                {
                    ApplicationArea = Basic;
                    Editable = MemberCellEditable;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

        }
    }

    trigger OnAfterGetRecord()
    begin
        AccountVisible := false;
        MobileVisible := false;
        AtmVisible := false;
        nxkinvisible := false;

        // if Type = Type::"M-Banking Change" then begin
        //     MobileVisible := true;
        // end;

        // if Type = Type::"ATM Change" then begin
        //     AtmVisible := true;
        // end;

        if Rec.Type = Rec.Type::"BOSA Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        // if Type = Type::"FOSA Change" then begin
        //     AccountVisible := true;
        //     nxkinvisible := true;
        // end;

        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        AccountVisible := false;
        MobileVisible := false;
        AtmVisible := false;
        nxkinvisible := false;

        // if Type = Type::"M-Banking Change" then begin
        //     MobileVisible := true;
        // end;

        // if Type = Type::"ATM Change" then begin
        //     AtmVisible := true;
        // end;

        if Rec.Type = Rec.Type::"BOSA Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        // if Type = Type::"FOSA Change" then begin
        //     AccountVisible := true;
        //     nxkinvisible := true;
        // end;

        UpdateControl();
    end;

    var
        vend: Record Vendor;
        Memb: Record Customer;
        MobileVisible: Boolean;
        AtmVisible: Boolean;
        AccountVisible: Boolean;
        ProductNxK: Record "FOSA Account NOK Details";
        //MembNxK: Record "Members Next of Kin";
        cloudRequest: Record "Change Request";
        nxkinvisible: Boolean;
        Kinchangedetails: Record "Members Next Kin Details";
        DocumentType: Option " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Withdrawal","Membership Reg","Loan Batches","Payment Voucher","Petty Cash",Loan,Interbank,Checkoff,"Savings Product Opening","Standing Order",ChangeRequest;
        MemberNxK: Record "Members Next Kin Details";
        GenSetUp: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        NameEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        AddressEditable: Boolean;
        CityEditable: Boolean;
        EmailEditable: Boolean;
        PersonalNoEditable: Boolean;
        IDNoEditable: Boolean;
        MaritalStatusEditable: Boolean;
        PassPortNoEditbale: Boolean;
        AccountTypeEditible: Boolean;
        SectionEditable: Boolean;
        CardNoEditable: Boolean;
        HomeAddressEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        DistrictEditable: Boolean;
        MemberStatusEditable: Boolean;
        ReasonForChangeEditable: Boolean;
        SigningInstructionEditable: Boolean;
        MonthlyContributionEditable: Boolean;
        MemberCellEditable: Boolean;
        ATMApproveEditable: Boolean;
        CardExpiryDateEditable: Boolean;
        CardValidFromEditable: Boolean;
        CardValidToEditable: Boolean;
        ATMNOEditable: Boolean;
        ATMIssuedEditable: Boolean;
        ATMSelfPickedEditable: Boolean;
        ATMCollectorNameEditable: Boolean;
        ATMCollectorIDEditable: Boolean;
        ATMCollectorMobileEditable: Boolean;
        ResponsibilityCentreEditable: Boolean;
        MobileNoEditable: Boolean;
        SMobileNoEditable: Boolean;
        TypeEditable: Boolean;
        AccountNoEditable: Boolean;
        AccountCategoryEditable: Boolean;
        ReactivationFeeEditable: Boolean;

    local procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin
            NameEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            AddressEditable := true;
            CityEditable := true;
            EmailEditable := true;
            PersonalNoEditable := true;
            IDNoEditable := true;
            MaritalStatusEditable := true;
            PassPortNoEditbale := true;
            AccountTypeEditible := true;
            EmailEditable := true;
            SectionEditable := true;
            CardNoEditable := true;
            HomeAddressEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            DistrictEditable := true;
            MemberStatusEditable := true;
            ReasonForChangeEditable := true;
            SigningInstructionEditable := true;
            MonthlyContributionEditable := true;
            MemberCellEditable := true;
            ATMApproveEditable := true;
            CardExpiryDateEditable := true;
            CardValidFromEditable := true;
            CardValidToEditable := true;
            ATMNOEditable := true;
            ATMIssuedEditable := true;
            ATMSelfPickedEditable := true;
            ATMCollectorNameEditable := true;
            ATMCollectorIDEditable := true;
            ATMCollectorMobileEditable := true;
            ResponsibilityCentreEditable := true;
            MobileNoEditable := true;
            SMobileNoEditable := true;
            AccountNoEditable := true;
            ReactivationFeeEditable := true;
            TypeEditable := true;
            AccountCategoryEditable := true
        end else
            if Rec.Status = Rec.Status::Pending then begin
                NameEditable := false;
                PictureEditable := false;
                SignatureEditable := false;
                AddressEditable := false;
                CityEditable := false;
                EmailEditable := false;
                PersonalNoEditable := false;
                IDNoEditable := false;
                MaritalStatusEditable := false;
                PassPortNoEditbale := false;
                AccountTypeEditible := false;
                EmailEditable := false;
                SectionEditable := false;
                CardNoEditable := false;
                HomeAddressEditable := false;
                LocationEditable := false;
                SubLocationEditable := false;
                DistrictEditable := false;
                MemberStatusEditable := false;
                ReasonForChangeEditable := false;
                SigningInstructionEditable := false;
                MonthlyContributionEditable := false;
                MemberCellEditable := false;
                ATMApproveEditable := false;
                CardExpiryDateEditable := false;
                CardValidFromEditable := false;
                CardValidToEditable := false;
                ATMNOEditable := false;
                ATMIssuedEditable := false;
                ATMSelfPickedEditable := false;
                ATMCollectorNameEditable := false;
                ATMCollectorIDEditable := false;
                ATMCollectorMobileEditable := false;
                ResponsibilityCentreEditable := false;
                MobileNoEditable := false;
                SMobileNoEditable := false;
                AccountNoEditable := false;
                TypeEditable := false;
                ReactivationFeeEditable := false;
                AccountCategoryEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    NameEditable := false;
                    PictureEditable := false;
                    SignatureEditable := false;
                    AddressEditable := false;
                    CityEditable := false;
                    EmailEditable := false;
                    PersonalNoEditable := false;
                    IDNoEditable := false;
                    MaritalStatusEditable := false;
                    PassPortNoEditbale := false;
                    AccountTypeEditible := false;
                    EmailEditable := false;
                    SectionEditable := false;
                    CardNoEditable := false;
                    HomeAddressEditable := false;
                    LocationEditable := false;
                    SubLocationEditable := false;
                    DistrictEditable := false;
                    MemberStatusEditable := false;
                    ReasonForChangeEditable := false;
                    SigningInstructionEditable := false;
                    MonthlyContributionEditable := false;
                    MemberCellEditable := false;
                    ATMApproveEditable := false;
                    CardExpiryDateEditable := false;
                    CardValidFromEditable := false;
                    CardValidToEditable := false;
                    ATMNOEditable := false;
                    ATMIssuedEditable := false;
                    ATMSelfPickedEditable := false;
                    ATMCollectorNameEditable := false;
                    ATMCollectorIDEditable := false;
                    ATMCollectorMobileEditable := false;
                    ResponsibilityCentreEditable := false;
                    MobileNoEditable := false;
                    SMobileNoEditable := false;
                    AccountNoEditable := false;
                    ReactivationFeeEditable := false;
                    TypeEditable := false;
                    AccountCategoryEditable := false
                end;
    end;
}