#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50527 "Cheque Application"
{
    PageType = Card;
    SourceTable = "Cheque Book Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Book Type"; Rec."Cheque Book Type")
                {
                    ApplicationArea = Basic;
                }
                field("Begining Cheque No."; Rec."Begining Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("End Cheque No."; Rec."End Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last check"; Rec."Last check")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Account No."; Rec."Cheque Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cheque Register Generated"; Rec."Cheque Register Generated")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cheque Book charges Posted"; Rec."Cheque Book charges Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Issue/Generate Cheque Register")
            {
                ApplicationArea = Basic;
                Image = Interaction;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Rec."Cheque Register Generated" then
                        Error('Cheque generation already done');
                    Rec.TestField("Begining Cheque No.");
                    Rec.TestField("End Cheque No.");
                    IncrNo := Rec."Begining Cheque No.";

                    if Rec."End Cheque No." < Rec."Begining Cheque No." then
                        Error('Beginning number is more than ending number');


                    while IncrNo <= Rec."End Cheque No." do begin
                        CheqReg.Init;
                        CheqReg."Account No." := Rec."Cheque Account No.";
                        CheqReg."Cheque No." := IncrNo;
                        CheqReg."Application No." := Rec."No.";
                        CheqReg.Insert;

                        IncrNo := IncStr(IncrNo);
                    end;
                    Rec."Cheque Register Generated" := true;
                    Rec.Modify;
                end;
            }
            action("Cheque Register")
            {
                ApplicationArea = Basic;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Cheque Register List";
                RunPageLink = "Application No." = field("No.");
            }
            action("Post Cheque Book Charges")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*
                  IF Status<>Status::Approved THEN BEGIN
                  ERROR('APPLICATION MUST BE APPROVED BEFORE POSTING CHARGES');
                  END;
                   */

                    if Rec."Cheque Book charges Posted" = true then begin
                        Error('Cheque book charges has already been posted');

                    end;

                    if Confirm('Are you sure you want post cheques', true) = true then begin
                        "TOTAL CHARGES" := 0;
                        Charges.Reset;
                        Charges.SetRange(Charges."Charge Type", Charges."charge type"::"Cheque Book");
                        if Charges.Find('-') then begin

                            //Charges.GET('CBC');


                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'CHQTRANS');
                            GenJournalLine.DeleteAll;

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'CHQTRANS';
                            GenJournalLine."Document No." := Rec."No.";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := Charges."GL Account";//'1-00-600-003';
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine."External Document No." := Rec."Cheque Account No.";
                            GenJournalLine.Description := 'Cheque Application fees';
                            GenJournalLine.Amount := -Charges."Charge Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            if Vend.Get(Rec."Account No.") then begin
                                GenJournalLine."Shortcut Dimension 2 Code" := Vend."Global Dimension 2 Code";
                            end;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            GenSetup.Get;
                            "TOTAL CHARGES" := "TOTAL CHARGES" + Charges."Charge Amount";

                            /* LineNo:=LineNo+10000;
                             GenJournalLine.INIT;
                             GenJournalLine."Journal Template Name":='GENERAL';
                             GenJournalLine."Journal Batch Name":='CHQTRANS';
                             GenJournalLine."Document No.":="No.";
                             GenJournalLine."Line No.":=LineNo;
                             GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                             GenJournalLine."Account No.":=GenSetup."Excise Duty Account";//GenSetup."Excise Duty G/L Acc.";
                             GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                             GenJournalLine."Posting Date":=TODAY;
                             GenJournalLine.Description:='Excise Duty';
                             GenJournalLine.Amount:=-(Charges."Charge Amount"*0.1);
                             GenJournalLine.VALIDATE(GenJournalLine.Amount);
                             GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                             IF Vend.GET("Account No.") THEN BEGIN
                             GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                             END;
                             GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                             GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                             IF GenJournalLine.Amount<>0 THEN
                             GenJournalLine.INSERT;
                             */
                            // coop bank charges
                            /*IF ChequeSetUp.GET("Cheque Book Type") THEN BEGIN
                             LineNo:=LineNo+10000;
                              GenJournalLine.INIT;
                              GenJournalLine."Journal Template Name":='GENERAL';
                              GenJournalLine."Journal Batch Name":='CHQTRANS';
                              GenJournalLine."Document No.":="No.";
                              GenJournalLine."Line No.":=LineNo;
                             // GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
                             // GenJournalLine."Account No.":='176';
                              GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                              GenJournalLine."Account No.":=Charges."GL Account";//'1-00-600-003';
                              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                              GenJournalLine."Posting Date":=TODAY;
                              GenJournalLine."External Document No.":="Cheque Account No.";
                              GenJournalLine.Description:='Cheque Application fees';
                              GenJournalLine.Amount:=-(ChequeSetUp.Amount+(ChequeSetUp.Amount*0.1));
                              GenJournalLine.VALIDATE(GenJournalLine.Amount);
                              GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                              IF Vend.GET("Account No.") THEN BEGIN
                              GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                              END;
                              GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                              GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                              IF GenJournalLine.Amount<>0 THEN
                              GenJournalLine.INSERT;
                               "TOTAL CHARGES":= "TOTAL CHARGES"+ChequeSetUp.Amount;
                             END;
                             */
                            // end of coopbank charges
                        end;

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'CHQTRANS';
                        GenJournalLine."Document No." := Rec."No.";
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := Rec."Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."External Document No." := Rec."Cheque Account No.";
                        GenJournalLine.Description := 'Cheque Application fees';
                        GenJournalLine.Amount := ("TOTAL CHARGES");
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        if Vend.Get(Rec."Account No.") then begin
                            GenJournalLine."Shortcut Dimension 2 Code" := Vend."Global Dimension 2 Code";
                        end;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;







                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'CHQTRANS');
                        if GenJournalLine.Find('-') then begin
                            //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;
                        //Post New





                    end;

                    Rec."Cheque Book charges Posted" := true;
                    Rec.Modify;

                    Message('Cheque book charged successfully');

                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //TEST
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //TEST
                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
            }
        }
    }

    var
        CheqReg: Record "Cheques Register";
        IncrNo: Code[10];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Vend: Record Vendor;
        AccountTypeS: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        Charges: Record Charges;
        GenSetup: Record "Sacco General Set-Up";
        ChequeSetUp: Record "Cheque Set Up";
        "TOTAL CHARGES": Decimal;
        TEST: Code[10];
}

