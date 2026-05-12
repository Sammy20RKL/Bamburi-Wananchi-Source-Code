#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56186 "SwizzKash Paybill Buffer"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "SwizzKash Paybill Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = Basic;
                }
                field("Completion Time"; Rec."Completion Time")
                {
                    ApplicationArea = Basic;
                }
                field("Initiation Time"; Rec."Initiation Time")
                {
                    ApplicationArea = Basic;
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Status"; Rec."Transaction Status")
                {
                    ApplicationArea = Basic;
                }
                field("Paid In"; Rec."Paid In")
                {
                    ApplicationArea = Basic;
                }
                field(Withdrawn; Rec.Withdrawn)
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance Confirmed"; Rec."Balance Confirmed")
                {
                    ApplicationArea = Basic;
                }
                field("Reason Type"; Rec."Reason Type")
                {
                    ApplicationArea = Basic;
                }
                field("Other Party Info"; Rec."Other Party Info")
                {
                    ApplicationArea = Basic;
                }
                field("Linked Transaction ID"; Rec."Linked Transaction ID")
                {
                    ApplicationArea = Basic;
                }
                field("A/C No."; Rec."A/C No.")
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
            action(Import)
            {
                ApplicationArea = Basic;
                Caption = 'Import';
                Image = import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = XMLport MpesaTransImport;
            }
            action(Clear)
            {
                ApplicationArea = Basic;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    fnClearTble(Paybill);
                end;
            }
            action(Transfer)
            {
                ApplicationArea = Basic;
                Image = post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    PaybillBuffer.Reset;
                    PaybillBuffer.SetRange(PaybillBuffer."Linked Transaction ID", '');
                    if PaybillBuffer.Find('-') then begin
                        repeat
                            MPESAPAYBILL.Reset;
                            MPESAPAYBILL.SetRange(MPESAPAYBILL."Document No", PaybillBuffer."Receipt No.");
                            if MPESAPAYBILL.Find('-') = false then begin

                                TextTosplit := PaybillBuffer.Details;
                                Part1 := SplitString(TextTosplit, 'Acc.');
                                StringAcc := StrLen(Part1 + 'Acc.  ');
                                Part2 := CopyStr(TextTosplit, StringAcc, 100);

                                newString := PaybillBuffer."Completion Time";
                                newDate := SplitString(newString, ' ');
                                finalDate := DelChr(newDate, '=', DelChr(newDate, '=', '1234567890'));

                                //EVALUATE(DateTimeRec,PaybillBuffer."Completion Time");

                                MPESAPAYBILL.Init;
                                MPESAPAYBILL."Document No" := PaybillBuffer."Receipt No.";
                                MPESAPAYBILL."Transaction Date" := Today;
                                MPESAPAYBILL."Transaction Time" := time;
                                MPESAPAYBILL.TransDate := CurrentDatetime;
                                MPESAPAYBILL.Amount := PaybillBuffer."Paid In";
                                MPESAPAYBILL."Paybill Acc Balance" := PaybillBuffer.Balance;
                                MPESAPAYBILL."Document Date" := Today;
                                MPESAPAYBILL."Key Word" := CopyStr(PaybillBuffer."A/C No.", 1, 3);
                                MPESAPAYBILL."Account No" := PaybillBuffer."A/C No.";
                                MPESAPAYBILL."Account Name" := CopyStr(PaybillBuffer."Other Party Info", 16, 250);
                                MPESAPAYBILL.Telephone := CopyStr(PaybillBuffer."Other Party Info", 1, 65);
                                MPESAPAYBILL.Description := 'Paybill Deposit';
                                MPESAPAYBILL.Insert;

                            end;
                        until PaybillBuffer.Next = 0;

                        Message('Posted successfully');
                        fnClearTble(PaybillBuffer);
                    end;
                end;
            }
            action(Refresh)
            {
                ApplicationArea = Basic;
                Image = refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
        }
    }

    var
        PaybillBuffer: Record "SwizzKash Paybill Buffer";
        MPESAPAYBILL: Record "SwizzKash MPESA Trans";
        AccountSplit: Text;
        AccountFinal: Text;
        TextTosplit: Text;
        StringAcc: Decimal;
        newString: Text;
        newDate: Text;
        finalDate: Text;
        Vardecimal: Decimal;
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        LastDate: Date;
        Part1: Text;
        Part2: Text;
        Part3: Text;
        Paybill: Record "SwizzKash Paybill Buffer";
        DateTimeRec: DateTime;

    local procedure SplitString(sText: Text; separator: Text) Token: Text
    var
        Pos: Integer;
        Tokenq: Text;
    begin
        Pos := StrPos(sText, separator);
        if Pos > 0 then begin
            Token := CopyStr(sText, 1, Pos - 1);
            if Pos + 1 <= StrLen(sText) then
                sText := CopyStr(sText, Pos + 1)
            else
                sText := '';
        end else begin
            Token := sText;
            sText := '';
        end;
    end;

    local procedure fnClearTble(Paybill: Record "SwizzKash Paybill Buffer")
    begin
        Paybill.Reset;
        Paybill.SetRange(Paybill."Linked Transaction ID", '');
        if Paybill.Find('-') then begin
            repeat
                Paybill.Delete;

            until Paybill.Next = 0;
        end;
    end;
}

