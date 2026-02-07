#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50389 "Loan Offset Detail List"
{
    PageType = List;
    SourceTable = "Loan Offset Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Loan Top Up"; Rec."Loan Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan to Offset';
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Principle Top Up"; Rec."Principle Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Top Up"; Rec."Interest Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Commision; Rec.Commision)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fee';
                }
                field("Total Top Up"; Rec."Total Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Recovery';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loan Payoff")
            {
                ApplicationArea = Basic;
                Image = Document;
                Promoted = true;
                RunObject = Page "Loan PayOff List";
            }
            action(ReduceLoanBalance)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;

                trigger OnAction()
                begin

                    ObjLoanOffset.Reset;
                    ObjLoanOffset.SetRange(ObjLoanOffset."Loan Top Up", Rec."Loan Top Up");
                    ObjLoanOffset.SetRange(ObjLoanOffset."FOSA Account", Rec."FOSA Account");
                    if ObjLoanOffset.Find('-') then begin
                        if ObjLoanOffset."FOSA Account" = '' then begin
                            Error('Specify the FOSA Account to be Debited When reducing the Loan');
                        end;
                        Report.Run(51516934, true, false, ObjLoanOffset);
                    end;
                end;
            }
        }
    }

    var
        ObjLoanOffset: Record "Loan Offset Details";
}

