#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50369 "Member Ledger Entries"
{
    Caption = 'Member Ledger Entries';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Member Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date";Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document No.";Rec."Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External Document No.";Rec."External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer No.";Rec."Customer No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan No";Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction No.";Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type";Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Amount";Rec."Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Amount";Rec."Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("IC Partner Code";Rec."IC Partner Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Salesperson Code";Rec."Salesperson Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount (LCY)";Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the Work Date Transaction Date,for transactions that are Backdated';
                }
                field("Bal. Account Type";Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account No.";Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Source Code";Rec."Source Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Reason Code";Rec."Reason Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Reversed;Rec.Reversed)
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Reversed by Entry No.";Rec."Reversed by Entry No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reversed Entry No.";Rec."Reversed Entry No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reversal Date";Rec."Reversal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No.";Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("Member Ledger Entry FactBox";"Member Ledger Entry FactBox")
            {
                SubPageLink = "Entry No."=field("Entry No.");
                Visible = true;
            }
            systempart(Control1102755003;Links)
            {
                Visible = false;
            }
            systempart(Control1102755001;Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Navigate")
                {
                    ApplicationArea = Basic;
                    Caption = '&Navigate';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Navigate.SetDoc(Rec."Posting Date",Rec."Document No.");
                        Navigate.Run;
                    end;
                }
                action("Reverse Transaction")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reverse Transaction';
                    Ellipsis = true;
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                    begin
                        // //....................
                        // ObjMemberLedgerEntries.RESET;
                        //  ObjMemberLedgerEntries.SETRANGE("Loan No",'BLN_0001886');
                        //  ObjMemberLedgerEntries.SETRANGE(Reversed,FALSE);
                        //  IF ObjMemberLedgerEntries.FIND('-') THEN BEGIN
                        //    REPEAT
                        //    ObjMemberLedgerEntries."Loan Type":='12';
                        //    ObjMemberLedgerEntries.MODIFY(TRUE);
                        //    UNTIL ObjMemberLedgerEntries.NEXT=0;
                        //  END;
                        //  EXIT;
                        // //....................
                         if UserSetup.Get(UserId) then
                         begin
                         if UserSetup."Reversal Right"=false then Error ('You dont have permissions to Reverse, Contact your system administrator! ')
                         end;

                        Clear(ReversalEntry);
                        if Rec.Reversed then
                          ReversalEntry.AlreadyReversedEntry(Rec.TableCaption,Rec."Entry No.");
                        if Rec."Journal Batch Name" = '' then
                          ReversalEntry.TestFieldError;
                        Rec.TestField("Transaction No.");if (Rec."Loan No"<>'') and (Rec."Transaction Type"=Rec."transaction type"::Loan) then begin
                          ObjMemberLedgerEntries.Reset;
                          ObjMemberLedgerEntries.SetRange("Loan No",Rec."Loan No");
                          ObjMemberLedgerEntries.SetRange(Reversed,false);
                          ObjMemberLedgerEntries.SetRange("Transaction Type",Rec."transaction type"::"Loan Repayment");
                          if ObjMemberLedgerEntries.Find('-') then
                            Error('You cannot Reverse a Loan with Repayment Entries.')
                          end;

                        ReversalEntry.ReverseTransaction(Rec."Transaction No.");

                        if ((Rec."Loan No"<>'') and (Rec."Transaction Type"=Rec."transaction type"::Loan)) then begin
                          ObjMemberLedgerEntries.Reset;
                          ObjMemberLedgerEntries.SetRange("Loan No",Rec."Loan No");
                          ObjMemberLedgerEntries.SetRange(Reversed,true);
                          ObjMemberLedgerEntries.SetRange("Transaction Type",Rec."transaction type"::Loan);
                          if ObjMemberLedgerEntries.Find('-') then
                            begin
                              ObjLoans.Reset;
                              ObjLoans.SetRange("Loan  No.",Rec."Loan No");
                              if ObjLoans.Find('-') then begin
                                Message('You are about to reverse a Loan.Yo will be Required to raise the Loan afresh.');
                                ObjLoans.Reversed:=true;
                                ObjLoans.Modify;
                                Message('You successfully reversed Loan No '+Rec."Loan No");
                                end

                              end
                          end
                    end;
                }
                action(Email)
                {
                    ApplicationArea = Basic,Suite;
                    Caption = 'Send by &Email';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Prepare to send the document by email. The Send Email window opens prefilled for the customer where you can add or change information before you send the email.';

                    trigger OnAction()
                    var
                        MemberLedger: Record "Member Ledger Entry";
                    begin
                        MemberLedger := Rec;
                        CurrPage.SetSelectionFilter(MemberLedger);
                        MemberLedger.EmailRecords(true);
                    end;
                }
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        Codeunit.Run(Codeunit::"Cust. Entry-Edit",Rec);
        exit(false);
    end;

    var
        Navigate: Page Navigate;
        UserSetup: Record "User Setup";
        ObjMemberLedgerEntries: Record "Member Ledger Entry";
        ObjLoans: Record "Loans Register";
}

