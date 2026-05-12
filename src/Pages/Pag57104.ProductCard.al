#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 57104 "Product Card"
{
    Caption = 'Account Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Vendor;
    // SourceTableView = where("Creditor Type" = const(Account),
    //                         "Debtor Type" = const("FOSA Account"));

    layout
    {
        area(content)
        {
            group(AccountTab)
            {
                Caption = 'General Info';
                Editable = true;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';
                    Editable = false;

                }
                field("Sacco No"; Rec."Sacco No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Joint Account Name"; Rec."Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No."; Rec."Personal No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BOSA Account No"; Rec."BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                    Editable = false;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }

                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }

                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Station/Sections"; Rec."Station/Sections")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field(txtGender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pension No"; Rec."Pension No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Uncleared Cheques"; Rec."Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Book Balance';
                    Enabled = false;
                    Visible = false;
                }
                field(AvailableBal; Rec."Balance (LCY)" - (Rec."Uncleared Cheques" + Rec."ATM Transactions" + Rec."EFT Transactions" + MinBalance + Rec."Mobile Transactions") + Rec."Cheque Discounted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawable Balance';
                    Editable = false;
                }
                field("Cheque Discounted"; Rec."Cheque Discounted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Comission On Cheque Discount"; Rec."Comission On Cheque Discount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason For Blocking Account"; Rec."Reason For Blocking Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        //TESTFIELD("Resons for Status Change");
                    end;
                }
                field("Prevous Blocked Status"; Rec."Prevous Blocked Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Frozen"; Rec."Account Frozen")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM No."; Rec."ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Acc. No"; Rec."Cheque Acc. No")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    HideValue = false;
                    Style = Standard;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Resons for Status Change");

                        // StatusPermissions.Reset;
                        // StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        // StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Account Status");
                        // if StatusPermissions.Find('-') = false then
                        //     Error('You do not have permissions to change the account status.');

                        if Rec."Account Type" = 'FIXED' then begin
                            if Rec."Balance (LCY)" > 0 then begin
                                Rec.CalcFields("Last Interest Date");

                                if Rec."Call Deposit" = true then begin
                                    if Rec.Status = Rec.Status::Closed then begin
                                        if Rec."Last Interest Date" < Today then
                                            Error('Fixed deposit interest not UPDATED. Please update interest.');
                                    end else begin
                                        if Rec."Last Interest Date" < Rec."FD Maturity Date" then
                                            Error('Fixed deposit interest not UPDATED. Please update interest.');
                                    end;
                                end;
                            end;
                        end;

                        if Rec.Status = Rec.Status::Active then begin
                            if Confirm('Are you sure you want to re-activate this account? This will recover re-activation fee.', false) = false then begin
                                Error('Re-activation terminated.');
                            end;

                            Rec.Blocked := Rec.Blocked::" ";
                            Rec.Modify;





                        end;


                        //Account Closure
                        if Rec.Status = Rec.Status::Closed then begin
                            Rec.TestField("Closure Notice Date");
                            if Confirm('Are you sure you want to close this account? This will recover closure fee and any '
                            + 'interest earned before maturity will be forfeited.', false) = false then begin
                                Error('Closure terminated.');
                            end;


                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                            if GenJournalLine.Find('-') then
                                GenJournalLine.DeleteAll;



                            AccountTypes.Reset;
                            AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                            if AccountTypes.Find('-') then begin
                                Rec."Date Closed" := Today;

                                //Closure charges
                                /*Charges.RESET;
                                IF CALCDATE(AccountTypes."Closure Notice Period","Closure Notice Date") > TODAY THEN
                                Charges.SETRANGE(Charges.Code,AccountTypes."Closing Prior Notice Charge") */

                                Charges.Reset;
                                if CalcDate(AccountTypes."Closure Notice Period", Rec."Closure Notice Date") > Today then
                                    Charges.SetRange(Charges.Code, AccountType."Closing Charge")

                                else
                                    Charges.SetRange(Charges.Code, AccountTypes."Closing Charge");
                                if Charges.Find('-') then begin
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No." + '-CL';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := Charges.Description;
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := Charges."Charge Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := Charges."GL Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                end;
                                //Closure charges


                                //Interest forfeited/Earned on maturity
                                Rec.CalcFields("Untranfered Interest");
                                if Rec."Untranfered Interest" > 0 then begin
                                    ForfeitInterest := true;
                                    //If FD - Check if matured
                                    if AccountTypes."Fixed Deposit" = true then begin
                                        if Rec."FD Maturity Date" <= Today then
                                            ForfeitInterest := false;
                                        if Rec."Call Deposit" = true then
                                            ForfeitInterest := false;

                                    end;

                                    //PKK INGORE MATURITY
                                    ForfeitInterest := false;
                                    //If FD - Check if matured

                                    if ForfeitInterest = true then begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                        GenJournalLine."Account No." := AccountTypes."Interest Forfeited Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Interest Forfeited';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := -Rec."Untranfered Interest";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        InterestBuffer.Reset;
                                        InterestBuffer.SetRange(InterestBuffer."Account No", Rec."No.");
                                        if InterestBuffer.Find('-') then
                                            InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);


                                    end else begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        if AccountTypes."Fixed Deposit" = true then
                                            GenJournalLine."Account No." := Rec."Savings Account No."
                                        else
                                            GenJournalLine."Account No." := Rec."No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Interest Earned';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := -Rec."Untranfered Interest";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        InterestBuffer.Reset;
                                        InterestBuffer.SetRange(InterestBuffer."Account No", Rec."No.");
                                        if InterestBuffer.Find('-') then
                                            InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);



                                    end;


                                    //Transfer Balance if Fixed Deposit
                                    if AccountTypes."Fixed Deposit" = true then begin
                                        Rec.CalcFields("Balance (LCY)");

                                        Rec.TestField("Savings Account No.");

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := Rec."Savings Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'FD Balance Tranfers';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        if Rec."Amount to Transfer" <> 0 then
                                            GenJournalLine.Amount := -Rec."Amount to Transfer"
                                        else
                                            GenJournalLine.Amount := -Rec."Balance (LCY)";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := Rec."No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'FD Balance Tranfers';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        if Rec."Amount to Transfer" <> 0 then
                                            GenJournalLine.Amount := Rec."Amount to Transfer"
                                        else
                                            GenJournalLine.Amount := Rec."Balance (LCY)";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;


                                    end;

                                    //Transfer Balance if Fixed Deposit


                                end;

                                //Interest forfeited/Earned on maturity
                                /*
                                //Post New
                                GenJournalLine.RESET;
                                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                                GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                                IF GenJournalLine.FIND('-') THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                END;
                                //Post New
                                */

                                Message('Funds transfered successfully to main account and account closed.');




                            end;
                        end;


                        //Account Closure

                    end;
                }
                field("Staff Account"; Rec."Staff Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Notice Date"; Rec."Closure Notice Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Resons for Status Change"; Rec."Resons for Status Change")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Interest Earned"; Rec."Interest Earned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Untranfered Interest"; Rec."Untranfered Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Untransfered interest Savings"; Rec."Untransfered interest Savings")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Allowable Cheque Discounting %"; Rec."Allowable Cheque Discounting %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("S-Mobile No"; Rec."S-Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile Transactions"; Rec."Mobile Transactions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("E-Loan Qualification Amount"; Rec."E-Loan Qualification Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Salary Processing"; Rec."Salary Processing")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason for Freezing Account"; Rec."Reason for Freezing Account")
                {
                    ApplicationArea = Basic;
                }
                field("Account Frozen By"; Rec."Account Frozen By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Activated By"; Rec."Activated By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Statement Page Nos"; Rec."Statement Page Nos")
                {
                    ApplicationArea = Basic;
                    Caption = 'No of Statement Pages to Charge';
                }
            }
            group(AccountTab1)
            {
                Caption = 'Communication Info';
                Editable = true;
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = Basic;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = Basic;
                }
                field("ContacPerson Phone"; Rec."ContacPerson Phone")
                {
                    ApplicationArea = Basic;
                }
                field("ContactPerson Occupation"; Rec."ContactPerson Occupation")
                {
                    ApplicationArea = Basic;
                }
                field(CodeDelete; Rec.CodeDelete)
                {
                    ApplicationArea = Basic;
                }
                field("Home Address"; Rec."Home Address")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Term Deposit Details")
            {
                Caption = 'Term Deposit Details';
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Deposit Type';
                    Editable = true;
                    Visible = true;
                }
                field("Fixed Deposit Start Date"; Rec."Fixed Deposit Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Duration"; Rec."Fixed Duration")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Duration';
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount to Transfer from Current';
                }
                field("Fixed Deposit Certificate No."; Rec."Fixed Deposit Certificate No.")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Interest On Term Dep"; Rec."Expected Interest On Term Dep")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Interest Earned';
                    Editable = false;
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Maturity Date';
                    Editable = false;
                }
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Deposit Status';
                }
                field("Term Deposit Status Type"; Rec."FDR Deposit Status Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Deposit Status Type';
                }
                field("On Term Deposit Maturity"; Rec."On Term Deposit Maturity")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Savings Account No."; Rec."Savings Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account No.';
                    Editable = false;
                }
                field("Transfer Amount to Savings"; Rec."Transfer Amount to Savings")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transfer Amount to Current';
                }
                field("Last Interest Earned Date"; Rec."Last Interest Earned Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Previous Term Deposit Details")
            {
                Caption = 'Previous Term Deposit Details';
                field("Prevous Fixed Deposit Type"; Rec."Prevous Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Type';
                    Editable = false;
                }
                field("Prevous FD Start Date"; Rec."Prevous FD Start Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Start Date';
                    Editable = false;
                }
                field("Prevous Fixed Duration"; Rec."Prevous Fixed Duration")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Duration';
                    Editable = false;
                }
                field("Prevous Expected Int On FD"; Rec."Prevous Expected Int On FD")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Int On Fixed Deposit';
                    Editable = false;
                }
                field("Prevous FD Maturity Date"; Rec."Prevous FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Maturity Date';
                    Editable = false;
                }
                field("Prevous FD Deposit Status Type"; Rec."Prevous FD Deposit Status Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Status Type';
                    Editable = false;
                }
                field("Prevous Interest Rate FD"; Rec."Prevous Interest Rate FD")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Rate Fixed Deposit';
                    Editable = false;
                }
                field("Date Renewed"; Rec."Date Renewed")
                {
                    ApplicationArea = Basic;
                }
            }
            group("ATM Details")
            {
                Caption = 'ATM Details';
                field("ATM No.B"; Rec."ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Transactions"; Rec."ATM Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Atm card ready"; Rec."Atm card ready")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM Card Ready For Collection';
                }
                field("FDR Deposit Status Type"; Rec."ATM Issued")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Self Picked"; Rec."ATM Self Picked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector Name"; Rec."ATM Collector Name")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector's ID"; Rec."ATM Collector's ID")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector's Mobile"; Rec."ATM Collector's Mobile")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000034; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Go To Member Page';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = field("BOSA Account No");
                }
            }
            group(ActionGroup1102755009)
            {
                action("Page Vendor Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            Report.Run(56890, true, false, Vend)
                    end;
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("posting date") order(descending);
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                }
                action("Freeze Account")
                {
                    ApplicationArea = Basic;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Promoted = true;
                    // Visible = ViewFreezingAction;
                    //Visible = true;
                    Image = AdjustEntries;
                    trigger onAction()
                    var
                        FreezeAccountPage: Page "Freeze Account";
                        StatusGiven: text;
                    begin
                        if rec.status = rec.status::Frozen then begin
                            Error('Account is already in frozen state');
                        end;
                        if rec.status <> rec.status::Frozen then begin
                            if Confirm('Are you sure you want to freeze this account ?', false) = false then begin
                                exit;
                            end else begin
                                CLEAR(FreezeAccountPage);
                                IF FreezeAccountPage.RUNMODAL <> ACTION::OK THEN begin
                                    CurrPage.Close();
                                    exit;
                                end;
                                StatusGiven := '';
                                StatusGiven := FreezeAccountPage.GetEnteredReason();
                                IF (StatusGiven <> '') THEN BEGIN
                                    Rec."Reason for Freezing Account" := StatusGiven;
                                    Rec."Resons for Status Change" := StatusGiven;
                                    rec.Blocked := rec.Blocked::Payment;
                                    Rec.Status := Rec.Status::Frozen;
                                    rec.Modify(true);
                                    message('Account has successfully been frozen !');
                                END
                                ELSE BEGIN
                                    ERROR('Reason for Freezing Account MUST be specified');
                                END;
                            end;
                        end;
                    end;
                }
                action("UnFreeze Account")
                {
                    ApplicationArea = Basic;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Promoted = true;
                    //Visible = ViewUnfreezingAction;
                    //Visible = true;
                    Image = AdjustEntries;
                    trigger onAction()
                    var
                        FreezeAccountPage: Page "Freeze Account";
                        StatusGiven: text;
                    begin
                        if rec.status <> rec.status::Frozen then begin
                            Error('Account is MUST be in frozen state');
                        end;

                        if rec.status = rec.status::Frozen then begin
                            if Confirm('Are you sure you want to Unfreeze this account ?', false) = false then begin
                                exit;
                            end else begin
                                CLEAR(FreezeAccountPage);
                                IF FreezeAccountPage.RUNMODAL <> ACTION::OK THEN begin
                                    CurrPage.Close();
                                    exit;
                                end;
                                StatusGiven := '';
                                StatusGiven := FreezeAccountPage.GetEnteredReason();
                                IF (StatusGiven <> '') THEN BEGIN
                                    Rec."Reason for Freezing Account" := '';
                                    Rec."Resons for Status Change" := StatusGiven;
                                    Rec.Status := Rec.Status::Active;
                                    rec.Blocked := rec.Blocked::" ";
                                    rec.Modify(true);
                                    message('Account has successfully been Activated !');
                                END
                                ELSE BEGIN
                                    ERROR('Reason for UnFreezing Account MUST be specified');
                                END;
                            end;
                        end;
                    end;
                }
                action("Activate Account")
                {
                    ApplicationArea = All;
                    PromotedCategory = Process;
                    Promoted = true;
                    Visible = IsAbletoActivateMember;

                    trigger OnAction()
                    var
                        Vend: Record Vendor;

                        AmountToPay: Decimal;
                        Sfactory: Codeunit "SWIZZSFT Factory";
                        Answer: Boolean;
                        LineNo: Integer;
                        GenJournalLine: Record "Gen. Journal Line";
                        SaccoSetup: Record "Sacco General Set-Up";
                        GenPost: codeunit "Gen. Jnl.-Post Line";


                    begin

                        if rec.status <> rec.status::Dormant then begin
                            Error('Account is MUST be in Dormant state');
                        end;

                        SaccoSetup.Get();
                        Vend.Reset();
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.FindFirst() then begin
                            if Confirm('Are you sure you want to Activate this account ?', false) = false then begin
                                exit;
                            end else begin
                                Vend.Status := Vend.Status::Active;
                                Vend.Modify();

                            end;
                        end;
                    end;
                }
                action("Recover Entrance Fee")
                {
                    ApplicationArea = Basic;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Promoted = true;
                    Visible = CanRecoverEntranceFee;
                    Image = AccountingPeriods;
                    trigger onAction()
                    var
                        StatusChangePermission: record "Status Change Permision";
                        OptionChoosen: Integer;
                        SFactory: Codeunit "SWIZZSFT Factory";
                        GenPost: codeunit 12;
                    begin
                        GenJournalLine.Reset();
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'REGFEE');
                        IF GenJournalLine.Find('-') THEN begin
                            GenJournalLine.DeleteAll();
                        end;
                        OptionChoosen := Dialog.StrMenu('Dont Recover,Recover from FOSA,Recover from share deposits', 0, 'Recover Member Registration Fee ?');
                        case OptionChoosen of
                            0:
                                begin
                                    exit;
                                end;
                            1:
                                begin
                                    exit;
                                end;
                            2:
                                begin
                                    FnRecoverFromFOSAAccount(rec."No.", rec."BOSA Account No", 500);
                                    //POST
                                    GenJournalLine.Reset();
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'REGFEE');
                                    IF GenJournalLine.Find('-') THEN begin
                                        repeat
                                            GenPost.Run(GenJournalLine);
                                        until GenJournalLine.Next = 0;
                                        GenJournalLine.DeleteAll();
                                        Message('Successfully recovered from FOSA Account');
                                    end;
                                end;
                            3:
                                begin
                                    FnRecoverFromFromShareDeposits(rec."No.", rec."BOSA Account No", 500);
                                    //POST
                                    GenJournalLine.Reset();
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'REGFEE');
                                    IF GenJournalLine.Find('-') THEN begin
                                        repeat
                                            GenPost.Run(GenJournalLine);
                                        until GenJournalLine.Next = 0;
                                        GenJournalLine.DeleteAll();
                                        Message('Successfully recovered from Member Share Deposits');
                                    end;
                                end else begin
                                exit;
                            end;
                        end;
                    end;
                }
                action("ACtivate USSD")
                {
                    ApplicationArea = Basic;
                    PromotedCategory = Process;
                    Promoted = true;
                    Visible = true;

                    trigger OnAction()
                    var
                        applicationNumber: Code[20];
                    begin
                        if Confirm('Are you sure to send the Mobile Application record for ' + Format(Rec."Name") + ' for activation ?', false) = false then begin
                            exit;
                        end else begin
                            swizzKashApplications.Reset();
                            swizzKashApplications.SetRange("Account No", Rec."No.");
                            if swizzKashApplications.Find('-') then begin
                                Error('This user is already Registered, Kindly consider PIN Reset');
                            end else begin
                                //send data to SwizzKash Applications (56119), status <>Approved

                                SaccoNoSeries.Get;
                                SaccoNoSeries.TestField(SaccoNoSeries."Swizzkash Reg No.");

                                // ✅ Get next number from series
                                applicationNumber := NoSeries.GetNextNo(SaccoNoSeries."Swizzkash Reg No.", Today, true);

                                swizzKashApplications.Init();
                                swizzKashApplications."No." := applicationNumber;
                                swizzKashApplications."No. Series" := SaccoNoSeries."Swizzkash Reg No.";
                                swizzKashApplications."Account No" := Rec."No.";
                                swizzKashApplications."Account Name" := Rec.Name;
                                swizzKashApplications.ActivationStatus := swizzKashApplications.ActivationStatus::SUBMITTED;
                                swizzKashApplications."Created By" := UserId;
                                swizzKashApplications."Date Applied" := Today;
                                swizzKashApplications."Member No" := Rec."BOSA Account No";
                                swizzKashApplications."ID No" := Rec."ID No.";
                                swizzKashApplications.Status := swizzKashApplications.Status::Approved;
                                swizzKashApplications.SentToServer := true;
                                swizzKashApplications.Telephone := Rec."Mobile Phone No";
                                swizzKashApplications.Gender := Rec.Gender;
                                swizzKashApplications.Insert(true);

                                Message('Record Marked for activation');
                                CurrPage.Close();
                            end;
                        end;
                    end;
                }
                action("Charge Fosa Replacement Card Fee")
                {
                    ApplicationArea = Basic;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Promoted = true;
                    Visible = CanChargeFosaCard;
                    Image = AccountingPeriods;
                    trigger onAction()
                    var
                        StatusChangePermission: record "Status Change Permision";
                        OptionChoosen: Integer;
                        SFactory: Codeunit "SWIZZSFT Factory";
                        GenPost: codeunit 12;
                    begin


                        IF CONFIRM('This process will recover FOSA card replacement Fee.Continue?', FALSE) = FALSE THEN
                            EXIT;

                        Rec.CALCFIELDS("Balance (LCY)", "ATM Transactions");
                        IF (Rec."Balance (LCY)" - Rec."ATM Transactions") <= 0 THEN
                            ERROR('This Account does not have sufficient funds');


                        AccountTypes.RESET;
                        AccountTypes.SETRANGE(AccountTypes.Code, Rec."Account Type");
                        IF AccountTypes.FIND('-') THEN BEGIN

                            Charges.RESET;
                            Charges.SETRANGE(Charges.Code, 'FCARD');
                            IF Charges.FIND('-') THEN BEGIN
                                GenJournalLine.RESET;
                                GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", 'FTRANS');
                                IF GenJournalLine.FIND('-') THEN
                                    GenJournalLine.DELETEALL;

                                LineNo := LineNo + 10000;

                                GenJournalLine.INIT;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No." + 'CARD';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := TODAY;
                                GenJournalLine.Description := 'FOSA card fee';
                                GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Charges."Charge Amount";
                                GenJournalLine."Mobile Transaction Type" := GenJournalLine."Mobile Transaction Type"::FOSACardFee;
                                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := Charges."GL Account";
                                GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                IF GenJournalLine.Amount <> 0 THEN
                                    GenJournalLine.INSERT;


                                //Post New
                                GenJournalLine.RESET;
                                GenJournalLine.SETRANGE("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SETRANGE("Journal Batch Name", 'FTRANS');
                                IF GenJournalLine.FIND('-') THEN BEGIN
                                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                    MESSAGE('Charge Posted Successfully')
                                END;
                                //Post New
                            END;
                            //Closure charge
                        end;
                    end;
                }

            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        FnUpdateControls();
        MinBalance := 0;
        if AccountType.Get(Rec."Account Type") then
            MinBalance := AccountType."Minimum Balance";

        OnAfterGetCurrRecord;

        Rec.CalcFields(NetDis);
        UnclearedLoan := Rec.NetDis;
        //MESSAGE('Uncleared loan is %1',UnclearedLoan);
        if Rec."Account Category" <> Rec."account category"::Joint then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;
        Joint3DetailsVisible := true;
        ViewFreezingAction := false;
        ViewUnfreezingAction := false;
        IsAbletoActivateMember := false;

        // if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
        //     if UserSetup.Get(UserId) then begin
        //         if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
        //     end;
        // end;
        StatusChangePermissions.reset;
        StatusChangePermissions.setrange(StatusChangePermissions."User ID", userid);
        StatusChangePermissions.SetRange(StatusChangePermissions.Function, StatusChangePermissions.Function::"Can activate Account");
        if StatusChangePermissions.Find('-') then begin
            IsAbletoActivateMember := true;
        end;


    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Rec.Find(Which);
        CurrPage.Editable := RecordFound or (Rec.GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Creditor Type" := Rec."creditor type"::Account;
    end;

    trigger OnOpenPage()
    begin

        CanRecoverEntranceFee := false;
        StatusPermissions.Reset();
        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
        StatusPermissions.SetRange(StatusPermissions.Function, StatusPermissions.Function::"Can Recover Entrance Fees");
        if StatusPermissions.Find('-') then begin
            CanRecoverEntranceFee := true;
        end;

        CanChargeFosaCard := false;
        StatusPermissions.Reset();
        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
        StatusPermissions.SetRange(StatusPermissions.Function, StatusPermissions.Function::"Can Charge Fosa Card Replacement Fee");
        if StatusPermissions.Find('-') then begin
            CanChargeFosaCard := true;
        end;

        ActivateFields;
        if Rec."Account Category" <> Rec."account category"::Joint then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;
        Joint3DetailsVisible := true;

        if Frequency.FindLast then
            Counts := Frequency.code + 1
        else
            Counts := 1;
        Frequency.Init;
        Frequency.code := Counts;
        Frequency.Account_no := Rec."No.";
        Frequency.Account_Name := Rec.Name;
        Frequency.User_Accessed := UserId;
        Frequency.date := Today;
        Frequency.time := Time;
        Frequency.Activity := Frequency.Activity::FOSA;
        Frequency.Insert;



        //Audit Entries
        if (UserId <> 'MOBILE') and (UserId <> 'ATM') and (UserId <> 'AGENCY') then begin
            EntryNos := 0;
            if Audit.FindLast then
                EntryNos := 1 + Audit."Entry No";
            Audit.Init;
            Audit."Entry No" := EntryNos;
            Audit."Transaction Type" := 'FOSA Account Viewing';
            Audit."Loan Number" := '';
            Audit."Document Number" := Rec."No.";
            Audit."Account Number" := Rec."No.";
            Audit.UsersId := UserId;
            Audit.Amount := 0;
            Audit.Date := Today;
            Audit.Time := Time;
            Audit.Source := 'FOSA ACCOUNT';
            // Audit.Insert;
            // COMMIT
        end;
        //End Audit Entries
        //.................................................
        IF REC.Status = REC.STATUS::Frozen THEN begin
            ViewFreezingAction := false;
            ViewUnfreezingAction := true;
        end;
        IF REC.Status <> REC.STATUS::Frozen THEN begin
            ViewFreezingAction := true;
            ViewUnfreezingAction := false;
        end;
    end;

    var
        SaccoNoSeries: Record "Sacco No. Series";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        swizzKashApplications: Record "SwizzKash Applications";
        CalendarMgmt: Codeunit "Calendar Management";
        IsAbletoActivateMember: Boolean;
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        PictureExists: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        GenJournalLine: Record "Gen. Journal Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Interest Buffer";
        FDType: Record "Fixed Deposit Type";
        Vend: Record Vendor;
        Cust: Record Customer;
        LineNo: Integer;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        CanRecoverEntranceFee: Boolean;
        CanChargeFosaCard: Boolean;
        ViewFreezingAction: Boolean;
        ViewUnfreezingAction: Boolean;
        MinBalance: Decimal;
        OBalance: Decimal;
        OInterest: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loan GuarantorsFOSA";
        Loans: Record "Loans Register";
        DefaulterType: Code[20];
        LastWithdrawalDate: Date;
        StatusChangePermissions: record "Status Change Permision";
        AccountType: Record "Account Types-Saving Products";
        ReplCharge: Decimal;
        Acc: Record Vendor;
        SearchAcc: Code[10];
        Searchfee: Decimal;
        Statuschange: Record "Status Change Permision";
        UnclearedLoan: Decimal;
        LineN: Integer;
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GenSetup: Record "Sacco General Set-Up";
        UserSetup: Record "User Setup";
        Saccosetup: Record "Sacco No. Series";
        NewMembNo: Code[30];
        fosaG: Record "Loan GuarantorsFOSA";
        Frequency: Record "Control Cues";
        Counts: Integer;
        Audit: Record "Audit Entries";
        EntryNos: Integer;
        NoSeries: Codeunit "No. Series";


    procedure ActivateFields()
    begin
        //CurrForm.Contact.EDITABLE("Primary Contact No." = '');
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ActivateFields;
        FnUpdateControls();
    end;

    LOCAL Procedure FnUpdateControls()
    var
        StatusChangePermissions: record "Status Change Permision";
    begin
        StatusChangePermissions.reset;
        StatusChangePermissions.setrange(StatusChangePermissions."User ID", userid);
        StatusChangePermissions.SetRange(StatusChangePermissions.Function, StatusChangePermissions.Function::"Can Freeze Accounts");
        if StatusChangePermissions.Find('-') then begin
            ViewFreezingAction := true;
            ViewUnfreezingAction := true;
        end;
    end;

    local procedure FnRecoverFromFromShareDeposits(No: Code[20]; BOSAAccountNo: Code[20]; amount: Integer)
    var
        GenJournalLine: record "Gen. Journal Line";
        SFactory: Codeunit "SWIZZSFT Factory";
        LineNo: Integer;
    begin
        //Recover from deposits
        LineNo := LineNo + 1;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'REGFEE';
        GenJournalLine."Document No." := 'REGFEE';
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := BOSAAccountNo;
        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
        GenJournalLine."Loan No" := '';
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Member registration fee recovered';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := amount;
        GenJournalLine."External Document No." := 'REG FEE';
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := REC."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
        //Pay to registration fee account
        LineNo := LineNo + 1;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'REGFEE';
        GenJournalLine."Document No." := 'REGFEE';
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := BOSAAccountNo;
        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Registration Fee";
        GenJournalLine."Loan No" := '';
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Member registration fee paid';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -amount;
        GenJournalLine."External Document No." := 'REG FEE';
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := REC."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    local procedure FnRecoverFromFOSAAccount(No: Code[20]; BOSAAccountNo: Code[20]; amount: Integer)
    var
        GenJournalLine: record "Gen. Journal Line";
        SFactory: Codeunit "SWIZZSFT Factory";
        LineNo: Integer;
    begin
        //Recover from deposits
        LineNo := LineNo + 1;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'REGFEE';
        GenJournalLine."Document No." := 'REGFEE';
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No." := No;
        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::" ";
        GenJournalLine."Loan No" := '';
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Member registration fee recovered';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := amount;
        GenJournalLine."External Document No." := 'REG FEE';
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := REC."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
        //Pay to registration fee account
        LineNo := LineNo + 1;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'GENERAL';
        GenJournalLine."Journal Batch Name" := 'REGFEE';
        GenJournalLine."Document No." := 'REGFEE';
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := BOSAAccountNo;
        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Registration Fee";
        GenJournalLine."Loan No" := '';
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := Today;
        GenJournalLine.Description := 'Member registration fee paid';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -amount;
        GenJournalLine."External Document No." := 'REG FEE';
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
        GenJournalLine."Shortcut Dimension 2 Code" := REC."Global Dimension 2 Code";
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


}

