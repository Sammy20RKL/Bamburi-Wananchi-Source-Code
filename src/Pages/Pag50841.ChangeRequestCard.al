#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50841 "Change Request Card"
{
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
                    Style = StrongAccent;

                    trigger OnValidate()
                    begin
                        AccountVisible := false;
                        MobileVisible := false;
                        nxkinvisible := false;

                        // if Type = Type::"M-Banking Change" then begin
                        //     MobileVisible := true;

                        // end;

                        // if Type = Type::"ATM Change" then begin
                        //     AccountVisible := true;
                        //     nxkinvisible := true;
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
                    Style = StrongAccent;

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
                    Visible = false;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason for change"; Rec."Reason for change")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
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
                field("Phone No.(New)"; Rec."Phone No.(New)")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("E-mail"; Rec.Email)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Email(New Value)"; Rec."Email(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Email(New Value)';
                    Editable = true;
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
                field("Position In the Sacco"; Rec."Position In the Sacco")
                {
                    ApplicationArea = basic;
                    Editable = false;

                }
                field("Position In the Sacco(New)"; Rec."Position In the Sacco(New)")
                {
                    ApplicationArea = basic;
                }
                field("Receive SMS Notification (Old)"; Rec."SMS Notification")
                {

                }
                field("Receive SMS Notification (New)"; Rec."SMS Notification (New)")
                {

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
                    ToolTip = 'Please enter your marital status';
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Gender(New Value)"; Rec."Gender(New Value)")
                {
                }

                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category(New Value)"; Rec."Account Category(New Value)")
                {
                    ApplicationArea = Basic;
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
                field("Status."; Rec."Status.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Status.(New)"; Rec."Status.(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("KRA Pin(Old)"; Rec."KRA Pin(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("KRA Pin(New)"; Rec."KRA Pin(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Blocked (New)"; Rec."Blocked (New)")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code(New)"; Rec."Employer Code(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Reactivation Fee"; Rec."Charge Reactivation Fee")
                {
                    ApplicationArea = Basic;
                    Editable = ReactivationFeeEditable;
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


            }


            group("Bank Details")
            {
                field("Bank Code(Old)"; Rec."Bank Code(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Code(New)"; Rec."Bank Code(New)")
                {

                }

                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Name (New)"; Rec."Bank Name (New)")
                {
                    ApplicationArea = Basic;

                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Branch(New Value)"; Rec."Branch(New Value)")
                {
                    ApplicationArea = Basic;

                }
                field("Bank Account No(Old)"; Rec."Bank Account No(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Bank Account No(New)"; Rec."Bank Account No(New)")
                {
                    ApplicationArea = Basic;

                }

            }

            group("mobile Info")
            {
                Caption = 'Mobile/Agency Change Details';
                Visible = MobileVisible;

                field("ID No."; Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("ID No.(New Value)"; Rec."ID No(New Value)")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Phone No..(New)"; Rec."Phone No.(New)")
                {
                    ApplicationArea = Basic;
                    Editable = PersonalNoEditable;
                }

                field("Mpesa mobile No."; Rec."Mpesa mobile No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Mpesa mobile No.(New)"; Rec."Mpesa mobile No.(New)")
                {
                    ApplicationArea = Basic;
                    Editable = MobileNoEditable;
                }
                field("SMS Notification."; Rec."SMS Notification")
                {
                    Editable = false;
                }
                field("SMS Notification (New)."; Rec."SMS Notification (New)")
                {

                }
                field("E-mail."; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Email.(New Value)"; Rec."Email(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Email (New)';
                    Editable = true;
                }

            }




        }
        area(factboxes)
        {
            part(Control149; "Change Request Pic")
            {

                ApplicationArea = all;
                SubPageLink = No = FIELD("No");
                Visible = true;

            }
            part(Control150; "Change Request Sign")
            {

                ApplicationArea = all;
                SubPageLink = No = FIELD("No");
                Visible = true;

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Changes")
            {
                ApplicationArea = Basic;
                Caption = 'Update Changes';
                Image = UserInterface;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if (Rec.Status <> Rec.Status::Approved) then begin
                        Error('Change Request Must be Approved First');
                    end;
                    // if ((Type = Type::"FOSA Change") or (Type = Type::"M-Banking Change")) then begin

                    //     vend.Reset;
                    //     vend.SetRange(vend."No.", "Account No");
                    //     if vend.Find('-') then begin
                    //         if "Name(New Value)" <> '' then
                    //             vend.Name := "Name(New Value)";
                    //         vend."Global Dimension 2 Code" := Branch;
                    //         if "Address(New Value)" <> '' then
                    //             vend.Address := "Address(New Value)";

                    //         if "Email(New Value)" <> '' then
                    //             vend."E-Mail" := "Email(New Value)";
                    //         vend."E-Mail (Personal)" := "Email(New Value)";
                    //         vend.Status := "Status (New Value)";
                    //         if "Mobile No(New Value)" <> '' then
                    //             vend."Mobile Phone No" := "Mobile No(New Value)";
                    //         vend."Mobile Phone No" := Memb."Mobile Phone No";
                    //         vend."Phone No." := "Mobile No(New Value)";

                    //         if "ID No(New Value)" <> '' then
                    //             vend."ID No." := "ID No(New Value)";

                    //         if "City(New Value)" <> '' then
                    //             vend.City := "City(New Value)";
                    //         if "Section(New Value)" <> '' then
                    //             vend.Section := "Section(New Value)";
                    //         if "Card Expiry Date" <> 0D then
                    //             vend."Card Expiry Date" := "Card Expiry Date";
                    //         if "Card No(New Value)" <> '' then
                    //             vend."Card No." := "Card No(New Value)";
                    //         if "Card No(New Value)" <> '' then
                    //             vend."ATM No." := "Card No(New Value)";
                    //         if "Card Valid From" <> 0D then
                    //             vend."Card Valid From" := "Card Valid From";
                    //         if "Card Valid To" <> 0D then
                    //             vend."Card Valid To" := "Card Valid To";
                    //         if "Marital Status(New Value)" <> "marital status(new value)"::" " then
                    //             vend."Marital Status" := "Marital Status(New Value)";
                    //         if "Responsibility Centers" <> '' then
                    //             vend."Responsibility Center" := "Responsibility Centers";
                    //         if "Phone No." <> '' then
                    //             vend."Phone No." := "Phone No.(New)";
                    //         if "Mpesa mobile No.(New)" <> '' then
                    //             vend."MPESA Mobile No" := "Mpesa mobile No.(New)";
                    //         if "SMS Notification (New)" = true then
                    //             vend."Sms Notification" := true;
                    //         if "Phone No.(New)" <> '' then
                    //             vend."Phone No." := "Phone No.(New)";

                    //         // vend."Phone No.." := "Mobile No(New Value)";
                    //         vend.Blocked := "Blocked (New)";
                    //         vend.Status := "Status.(New)";
                    //         vend.Modify;
                    //         /*

                    //    */
                    //     end;
                    // end;


                    if Rec.Type = Rec.Type::"BOSA Change" then begin
                        Memb.Reset;
                        Memb.SetRange(Memb."No.", Rec."Account No");
                        if Memb.Find('-') then begin
                            if Rec."Name(New Value)" <> '' then
                                Memb.Name := Rec."Name(New Value)";
                            Memb."Global Dimension 2 Code" := Rec.Branch;
                            if Rec."Address(New Value)" <> '' then
                                Memb.Address := Rec."Address(New Value)";
                            if Rec."Post Code (New)" <> '' then
                                Memb."Post Code" := Rec."Post Code (New)";
                            if Rec."Email(New Value)" <> '' then
                                Memb."E-Mail" := Rec."Email(New Value)";
                            if Rec."Mobile No(New Value)" <> '' then begin
                                Memb."Mobile Phone No" := Rec."Mobile No(New Value)";
                                Memb."Phone No." := Rec."Mobile No(New Value)";
                            end;

                            if Rec."ID No(New Value)" <> '' then
                                Memb."ID No." := Rec."ID No(New Value)";
                            if Rec."Personal No(New Value)" <> '' then begin
                                Memb."Payroll/Staff No" := Rec."Personal No(New Value)";
                                Memb.Validate("Payroll/Staff No");
                                loans.Reset;
                                loans.SetRange(loans."Client Code", Rec."Account No");
                                if loans.Find('-') then begin
                                    repeat
                                        loans."Staff No" := Rec."Personal No(New Value)";
                                        loans.Modify;
                                    until loans.Next = 0;
                                end;
                            end;
                            if Rec."City(New Value)" <> '' then
                                Memb.City := Rec."City(New Value)";
                            //Memb.Status := "Status(New Value)";
                            if Rec."Section(New Value)" <> '' then
                                Memb.Section := Rec."Section(New Value)";
                            Memb.Blocked := Rec."Blocked (New)";
                            if Rec."Marital Status(New Value)" <> Rec."marital status(new value)"::" " then
                                Memb."Marital Status" := Rec."Marital Status(New Value)";
                            if Rec."Responsibility Centers" <> '' then
                                Memb."Responsibility Center" := Rec."Responsibility Centers";
                            if Rec."Occupation(New)" <> '' then
                                Memb.Occupation := Rec."Occupation(New)";

                            //update position in the sacco
                            if Rec."Position In the Sacco(New)" <> Rec."Position In the Sacco(New)"::" " then begin
                                if Rec."Position In the Sacco(New)" = Rec."Position In the Sacco(New)"::Board then begin
                                    Memb.Board := true;
                                    Memb.staff := false;
                                    Memb."Sacco Insider" := true;
                                    Memb.Supervisory := false;
                                end else
                                    if Rec."Position In the Sacco(New)" = Rec."Position In the Sacco(New)"::Staff then begin
                                        Memb.Board := false;
                                        Memb.staff := true;
                                        Memb.Supervisory := false;
                                        Memb."Sacco Insider" := true;
                                    end else
                                        if Rec."Position In the Sacco(New)" = Rec."Position In the Sacco(New)"::Member then begin
                                            Memb.Board := false;
                                            Memb.staff := false;
                                            Memb.Supervisory := false;
                                            Memb."Sacco Insider" := false;
                                        end else
                                            if Rec."Position In the Sacco(New)" = Rec."Position In the Sacco(New)"::Supervisory then begin
                                                Memb.Board := false;
                                                Memb.staff := false;
                                                Memb."Sacco Insider" := true;
                                                Memb.Supervisory := true;
                                            end;
                            end;
                            //Update Bank
                            if Rec."Bank Code(New)" <> '' then
                                Memb."Bank Code" := Rec."Bank Code(New)";
                            if Rec."Bank Name (New)" <> '' then
                                // Memb."Benevolent Fund Historical":="Bank Name (New)";
                                if Rec."Bank Account No(New)" <> '' then
                                    Memb."Bank Account No." := Rec."Bank Account No(New)";
                            //Bank Branch
                            if Rec."Bank Branch Code(New)" <> '' then
                                Memb."Bank Code" := Rec."Bank Branch Code(New)";
                            if Rec."Bank Branch Name(New)" <> '' then
                                Memb."Bank Branch Name" := Rec."Bank Branch Name(New)";
                            if Rec."KRA Pin(New)" <> '' then
                                Memb.Pin := Rec."KRA Pin(New)";
                            Memb."Last Date Modified" := Rec."Capture Date";
                            if Rec."Group Account Name" <> '' then
                                Memb."Group Account Name" := Rec."Group Account Name";
                            if Rec."Employer Code(New)" <> '' then
                                Memb."Employer Code" := Rec."Employer Code(New)";
                            IF Rec."Picture(New Value)".HasValue THEN begin
                                MEMB.Image := Rec."Picture(New Value)";
                            end;
                            IF Rec."signinature(New Value)".HasValue THEN begin
                                MEMB.Signature := Rec."signinature(New Value)";
                            end;
                            IF Rec."Date Of Birth" <> 0D THEN
                                Memb."Date of Birth" := Rec."Date Of Birth";
                            IF Rec.Gender <> Rec.Gender::" " then
                                Memb.Gender := Rec.Gender;
                            if Rec."SMS Notification (New)" = true then begin
                                memb."Sms Notification" := true;
                            end;
                            if Rec."Status.(New)" <> Rec."Status.(New)"::" " then begin
                                Memb.Status := Rec."Status.(New)";
                            end;
                            if Rec."Monthly Contributions(NewValu)" <> 0 then
                                Memb."Monthly Contribution" := Rec."Monthly Contributions(NewValu)";
                            Memb.Modify;
                            //.....................GENERAL UPDATE VENDOR ALSO
                            VEND.Reset();
                            VEND.SetRange(vend."BOSA Account No", Rec."Account No");
                            IF vend.Find('-') then begin
                                repeat
                                    IF Rec."Picture(New Value)".HasValue THEN begin
                                        vend.Image := Rec."Picture(New Value)";
                                    end;
                                    if Rec."SMS Notification (New)" = true then begin
                                        vend."Sms Notification" := true;
                                    end;
                                    IF Rec."Date Of Birth" <> 0D THEN
                                        vend."Date of Birth" := Rec."Date Of Birth";
                                    IF Rec.Gender <> Rec.Gender::" " then
                                        vend.Gender := Rec.Gender;
                                    IF Rec."signinature(New Value)".HasValue THEN begin
                                        vend.Signature := Rec."signinature(New Value)";
                                    end;
                                    if Rec."Mobile No(New Value)" <> '' then begin
                                        vend."Mobile Phone No" := Rec."Mobile No(New Value)";
                                        vend."Phone No." := Rec."Mobile No(New Value)";
                                    end;
                                    if Rec."ID No(New Value)" <> '' then
                                        vend."ID No." := Rec."ID No(New Value)";
                                    if (Rec."Status.(New)" <> Rec."Status.(New)"::" ") and (Rec."Status.(New)" = Rec."Status.(New)"::Deceased) then begin
                                        vend.Status := vend.Status::Deceased;
                                    end;
                                    vend.Modify();
                                until vend.Next = 0;
                            end;

                            if Rec."Charge Reactivation Fee" = true then begin
                                if Confirm('The System Is going to Charge Reactivation Fee', false) = true then begin
                                    GenSetUp.Get();
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'ACTIVATE');
                                    if GenJournalLine.FindSet then begin
                                        GenJournalLine.DeleteAll;
                                    end;

                                    BATCH_TEMPLATE := 'GENERAL';
                                    BATCH_NAME := 'ACTIVATE';
                                    DOCUMENT_NO := Rec."Account No";
                                    GenSetup.Get();
                                    LineNo := 0;
                                    //----------------------------------1.DEBIT TO VENDOR WITH PROCESSING FEE----------------------------------------------
                                    LineNo := LineNo + 10000;
                                    // SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
                                    // FnGetFOSA(Rec."Account No"), Today, 200, 'FOSA', '', 'Activation fees', '', GenJournalLine."bal. account type"::"G/L Account", '5534');

                                    //-------------------------------2.CHARGE EXCISE DUTY----------------------------------------------
                                    LineNo := LineNo + 10000;
                                    // SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"0", GenJournalLine."account type"::Vendor,
                                    //FnGetFOSA(Rec."Account No"), Today, 20, 'FOSA', '', 'Excise Duty', '', GenJournalLine."bal. account type"::"G/L Account", GenSetup."Excise Duty Account");


                                    //Post New
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                                        GenJournalLine.DeleteAll;
                                    end;

                                    Message('Account re-activated successfully');
                                end;
                            end;



                        end;


                        //...........................
                    end;

                    Rec.Changed := true;
                    // IF Picture.HasValue then
                    //     Clear(Picture);
                    // IF signinature.HasValue then
                    //     Clear(signinature);
                    Rec.Modify;
                    Message('Changes have been updated Successfully');

                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if Rec.Status <> Rec.Status::Open then
                        Error(text001);
                    Rec.TestField("Reason for change");
                    if Confirm('Send Approval Request?', false) = true then begin
                        SrestepApprovalsCodeUnit.SendMemberChangeRequestForApproval(rec.No, Rec);
                        Message('Approval Request Sent Successfully');
                        CurrPage.Close();
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel A&pproval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Cancel Approval Request?', false) = true then begin
                        SrestepApprovalsCodeUnit.CancelMemberChangeRequestRequestForApproval(rec.No, Rec);
                    end;
                end;
            }

            separator(Action1000000047)
            {
            }
            separator(Action1000000055)
            {
            }
            action("Next of Kin")
            {
                ApplicationArea = Basic;
                Caption = 'Next of Kin';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Next of Kin-Change";
                RunPageLink = "Account No" = field("Account No");
                Visible = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AccountVisible := false;
        MobileVisible := false;
        nxkinvisible := false;

        // if Type = Type::"M-Banking Change" then begin
        //     MobileVisible := true;
        // end;

        // if Type = Type::"ATM Change" then begin
        //     AccountVisible := true;
        //     nxkinvisible := true;
        // end;

        if Rec.Type = Rec.Type::"BOSA Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;


        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        AccountVisible := false;
        MobileVisible := false;
        nxkinvisible := false;

        // if Type = Type::"M-Banking Change" then begin
        //     MobileVisible := true;
        // end;

        // if Type = Type::"ATM Change" then begin
        //     AccountVisible := true;
        //     nxkinvisible := false;
        // end;

        if Rec.Type = Rec.Type::"BOSA Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;


        UpdateControl();
    end;

    var
        vend: Record Vendor;
        Memb: Record Customer;
        MobileVisible: Boolean;
        AtmVisible: Boolean;
        AccountVisible: Boolean;
        ProductNxK: Record "FOSA Account NOK Details";
        cloudRequest: Record "Change Request";
        nxkinvisible: Boolean;
        //Kinchangedetails: Record "Members Next of Kin";
        DocumentType: Option " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Withdrawal","Membership Reg","Loan Batches","Payment Voucher","Petty Cash",Loan,Interbank,Checkoff,"Savings Product Opening","Standing Order",ChangeRequest;
        //MemberNxK: Record "Members Next of Kin";
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
        PosInSaccoEditable: Boolean;
        MembPayTypeEditable: Boolean;
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
        loans: Record "Loans Register";
        RetirementDateEditable: Boolean;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: code[50];
        SFactory: Codeunit "SWIZZSFT Factory";
        SrestepApprovalsCodeUnit: Codeunit SurestepApprovalsCodeUnit;


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
            MembPayTypeEditable := true;
            PosInSaccoEditable := true;
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
                PosInSaccoEditable := false;
                MembPayTypeEditable := false;
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
                    PosInSaccoEditable := false;
                    MembPayTypeEditable := false;
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

    local procedure FnGetFOSA(AccountNo: Code[50]): Code[50]
    var
        Vendor: Record Vendor;
    begin
        Vendor.reset;
        Vendor.SetRange(Vendor."BOSA Account No", AccountNo);
        if Vendor.Find('-') = true then begin
            exit(Vendor."No.");
        end else
            if Vendor.Find('-') = false then begin
                exit(AccountNo);
            end
    end;
}

