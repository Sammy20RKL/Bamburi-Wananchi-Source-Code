#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
table 50089 "DO Payment Credit Card"
{
    Caption = 'Dynamics Online Payment Credit Card';
    // Permissions = TableData "DO Payment Credit Card Number"=rimd;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Type; Code[20])
        {
            Caption = 'Type';
            NotBlank = true;
            TableRelation = "DO Payment Card Type".Name;

            trigger OnValidate()
            begin
                if Type <> xRec.Type then
                    DeleteCreditCardNumber;
            end;
        }
        field(3; "Credit Card Number"; Text[20])
        {
            Caption = 'Credit Card Number';
        }
        field(4; "Expiry Date"; Code[4])
        {
            Caption = 'Expiry Date';
            NotBlank = true;

            trigger OnValidate()
            var
                IntegerValue: Integer;
            begin
                if not Evaluate(IntegerValue, "Expiry Date") or (StrLen("Expiry Date") <> 4) then
                    Error(Text006, FieldCaption("Expiry Date"));

                Evaluate(IntegerValue, CopyStr("Expiry Date", 1, 2));
                if not (IntegerValue in [1 .. 12]) then
                    Error(Text007);
            end;
        }
        field(5; "Card Holder Name"; Text[50])
        {
            Caption = 'Card Holder Name';
            NotBlank = true;
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                Contact.SetRange("Company No.", FindCustomerContactNo);
                Contact.SetRange(Type, Contact.Type::Person);
                if Contact.FindFirst then
                    "Contact No." := Contact."No.";
                ValidateContact;
            end;
        }
        field(7; "Contact No."; Code[20])
        {
            AccessByPermission = TableData Contact = R;
            Caption = 'Contact No.';
            NotBlank = true;

            trigger OnLookup()
            var
                Contact: Record Contact;
                ContactList: Page "Contact List";
            begin
                Contact.SetRange("Company No.", FindCustomerContactNo);
                Contact.SetRange(Type, Contact.Type::Person);

                if "Contact No." <> '' then
                    Contact.Get("Contact No.")
                else begin
                    if Contact.Get then;
                end;

                ContactList.SetTableview(Contact);
                ContactList.LookupMode(true);
                if ContactList.RunModal = Action::LookupOK then begin
                    ContactList.GetRecord(Contact);
                    Validate("Contact No.", Contact."No.");
                end;
            end;

            trigger OnValidate()
            begin
                if "Contact No." <> xRec."Contact No." then
                    ValidateContact;
            end;
        }
        field(8; "Cvc No."; Text[4])
        {
            Caption = 'Cvc No.';

            trigger OnValidate()
            var
                NumericCvc: Integer;
            begin
                if not Evaluate(NumericCvc, "Cvc No.") then
                    Error(Text011, FieldCaption("Cvc No."));
            end;
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Customer No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Type, "Expiry Date")
        {
        }
    }

    trigger OnDelete()
    begin
        if DOPaymentTransLogEntry.HasTransaction(Rec) then
            Error(Text010, TableCaption, "No.");
        DeleteCreditCardNumber;
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            DOPaymentSetup.Get;
            DOPaymentSetup.TestField("Credit Card Nos.");
            //  NoSeriesMgt.InitSeries(DOPaymentSetup."Credit Card Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Validate("Customer No.", GetFilter("Customer No."));
    end;

    trigger OnRename()
    begin
        if DOPaymentTransLogEntry.HasTransaction(Rec) then
            Error(Text010, TableCaption, "No.");
    end;

    var
        Text006: label '%1 must be 4 characters, for example, 1094 for October, 1994.';
        Text007: label 'Check the month number.';
        Text010: label 'You cannot delete %1 %2 because it has a valid transaction log entry.', Comment = '%1=table caption, %2=record no.';
        Text011: label '%1 must be a number.';
        DOPaymentSetup: Record "DO Payment Setup";
        DOPaymentTransLogEntry: Record "DO Payment Trans. Log Entry";
        NoSeriesMgt: Codeunit "No. Series";


    procedure AssistEdit(OldDOPaymentCreditCard: Record "DO Payment Credit Card"): Boolean
    var
        DOPaymentCreditCard: Record "DO Payment Credit Card";
    begin
        // DOPaymentCreditCard := Rec;
        // DOPaymentSetup.Get;
        // DOPaymentSetup.TestField("Credit Card Nos.");
        // if NoSeriesMgt.SelectSeries(DOPaymentSetup."Credit Card Nos.", OldDOPaymentCreditCard."No. Series", DOPaymentCreditCard."No. Series") then begin
        //     NoSeriesMgt.SetSeries(DOPaymentCreditCard."No.");
        //     Rec := DOPaymentCreditCard;
        //     exit(true);
        // end;
    end;


    procedure SetCreditCardNumber(CreditCardNumberText: Text[30])
    var
        DOPaymentCreditCardNo: Record "DO Payment Credit Card Number";
        DOPaymentCardValidation: Codeunit "Service Post Invoice Events";
        StarString: Text[30];
    begin
        // DOPaymentCardValidation.ValidateCreditCard(CreditCardNumberText,Type);

        if DOPaymentCreditCardNo.Get("No.") then begin
            DOPaymentCreditCardNo.SetData(CreditCardNumberText);
            DOPaymentCreditCardNo.Modify;
        end else begin
            DOPaymentCreditCardNo.Init;
            DOPaymentCreditCardNo."No." := "No.";
            DOPaymentCreditCardNo.SetData(CreditCardNumberText);
            DOPaymentCreditCardNo.Insert;
        end;

        // Set obfuscated card no
        StarString := '';
        "Credit Card Number" :=
          PadStr(
            StarString,
            StrLen(CreditCardNumberText) - 4, '*') + CopyStr(CreditCardNumberText,
            StrLen(CreditCardNumberText) - 3);
    end;

    local procedure DeleteCreditCardNumber()
    var
        DOPaymentCreditCardNo: Record "DO Payment Credit Card Number";
    begin
        if DOPaymentCreditCardNo.Get("No.") then begin
            DOPaymentCreditCardNo.Delete;
            "Credit Card Number" := '';
        end;
    end;

    local procedure ValidateContact()
    var
        Contact: Record Contact;
    begin
        if "Contact No." <> '' then begin
            Contact.Get("Contact No.");
            if "Card Holder Name" = '' then
                "Card Holder Name" := Contact.Name;
        end;
    end;

    local procedure FindCustomerContactNo(): Code[20]
    var
        ContBusRel: Record "Contact Business Relation";
    begin
        ContBusRel.SetCurrentkey("Link to Table", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
        ContBusRel.SetRange("No.", "Customer No.");

        if ContBusRel.FindFirst then
            exit(ContBusRel."Contact No.");
    end;


    procedure DeleteByContact(Contact: Record Contact)
    var
        DOPaymentCreditCard: Record "DO Payment Credit Card";
    begin
        DOPaymentCreditCard.SetRange("Contact No.", Contact."No.");
        if DOPaymentCreditCard.FindFirst then
            DOPaymentCreditCard.DeleteAll(true);
    end;


    procedure DeleteByCustomer(Customer: Record Customer)
    var
        DOPaymentCreditCard: Record "DO Payment Credit Card";
    begin
        DOPaymentCreditCard.SetRange("Customer No.", Customer."No.");
        if DOPaymentCreditCard.FindFirst then
            DOPaymentCreditCard.DeleteAll(true);
    end;


    procedure GetCreditCardNumber(CreditCardNo: Code[20]): Text[20]
    begin
        if Get(CreditCardNo) then
            exit("Credit Card Number");

        exit('');
    end;
}

