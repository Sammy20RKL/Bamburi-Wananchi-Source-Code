/* #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516665 "Loan Interest List2"
{
    PageType = List;
    SourceTable = UnknownTable51516295;
    SourceTableView = where(Posted=const(No),
                            Transferred=const(No),
                            Reversed=const(No));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Date";"Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount";"Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Transferred;Transferred)
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Loan No.";"Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product type";"Loan Product type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account Type";"Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date";"Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest";"Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed;Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate";"Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa No";"Bosa No")
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
            action("Generate Monthly Interest")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report UnknownReport51516579;
            }
            action("Option ")
            {
                ApplicationArea = Basic;
            }
            action("Post Loan Interest")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Report UnknownReport51516580;
            }
        }
    }

    var
        Option: Option "Generate Only","Generate & Post";
        PeriodicActivities: Codeunit UnknownCodeunit51516029;
        members: Record UnknownRecord51516364;
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record UnknownRecord51516381;
        PostDate: Date;
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EndDate: Date;
        DontCharge: Boolean;
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record UnknownRecord51516391;
        AccountingPeriod: Record UnknownRecord51516391;
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        InterestDue: Decimal;
        LoansInterest: Record UnknownRecord51516295;
        DailyLoansInterestBuffer: Record UnknownRecord51516297;
        LoanNo: Code[20];
        BDate: Date;
        BalDate: Date;
        ProdFact: Record UnknownRecord51516381;
        InterestAmount: Decimal;
        iEntryNo: Integer;
        Temp: Record UnknownRecord51516031;
        CreditAccounts: Record UnknownRecord51516364;
}

 */