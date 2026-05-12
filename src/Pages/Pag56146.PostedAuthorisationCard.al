#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56146 "Posted Authorisation Card"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Over Draft Authorisationx";
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Over Draft No"; Rec."Over Draft No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Captured by"; Rec."Captured by")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = Basic;
                }
                field("Amount applied"; Rec."Amount applied")
                {
                    ApplicationArea = Basic;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft Status"; Rec."Overdraft Status")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Athourisation)
            {
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisor Checked"; Rec."Supervisor Checked")
                {
                    ApplicationArea = Basic;
                }
                field("Authorisation Requirement"; Rec."Authorisation Requirement")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;

                trigger OnAction()
                begin
                    if Rec.Posted = true then begin
                        Error(Rec."Over Draft No" + 'Already posted');
                    end else
                        Rec.TestField("Account No");
                    Rec.TestField("Approved Date");
                    //TESTFIELD("Current Account No") ;
                    overdraftno := '';
                    //get Current account
                    if vend."Account Type" = 'CURRENT' then
                        vend.Reset;
                    vend.SetRange(vend."No.", Rec."Account No");
                    if vend.Find('-') then begin
                        overdraftno := vend."No.";
                    end;
                    DValue.Reset;
                    DValue.SetRange(DValue."Global Dimension No.", 2);
                    if DValue.Find('-') then begin
                        DValue.TestField(DValue."Overdraft Account");
                        Overdraftbank := DValue."Overdraft Account";
                        dbanch := DValue.Code;
                        Message('Overdraft clearing account is' + Overdraftbank);
                        if Rec."Approved Amount" > 0 then begin
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'OVERDRAFT');
                            GenJournalLine.DeleteAll;

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'OVERDRAFT';
                            GenJournalLine."Document No." := Rec."Over Draft No";
                            GenJournalLine."External Document No." := 'OV' + Rec."Over Draft No";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := Rec."Account No";
                            GenJournalLine.Amount := Rec."Approved Amount" * -1;
                            GenJournalLine.Validate(Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := dbanch;
                            GenJournalLine."Posting Date" := Rec."Approved Date";
                            GenJournalLine."User ID" := Rec."Captured by";
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                            GenJournalLine."Bal. Account No." := Overdraftbank;
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert(true);

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'OVERDRAFT');
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);
                            end;





                        end;

                        //end authorisation

                        Message('Over draft successfully updated');
                        Rec."Posted By" := UserId;
                        Rec.Posted := true;
                        Rec."Time Posted" := Time;
                        Rec."Overdraft Status" := Rec."overdraft status"::Inactive;
                        Rec."Supervisor Checked" := true;
                        if Rec."Supervisor Checked" = true
                          then
                            Rec."Authoriser Id" := UserId;

                        vend.Modify;
                        Rec.Modify;
                    end;




                    //Post New
                end;
            }
        }
    }

    var
        vend: Record Vendor;
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        overdraftno: Code[30];
        DValue: Record "Dimension Value";
        Overdraftbank: Code[10];
        dbanch: Code[50];
}

