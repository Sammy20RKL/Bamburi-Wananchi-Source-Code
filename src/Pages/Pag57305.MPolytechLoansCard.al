// namespace PolyTechERPSourceCode.PolyTechERPSourceCode;

page 57305 "M-Polytech Loans Card"
{
    ApplicationArea = All;
    Caption = 'M-Polytech Loans Card';
    PageType = Card;
    SourceTable = "SwizzKash Transactions";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Loan No"; Rec."Loan No")
                {
                }
                field(Entry; Rec.Entry)
                {
                }
                field("APP Type"; Rec."APP Type")
                {
                }
                field("Account Name"; Rec."Account Name")
                {
                }
                field("Account No"; Rec."Account No")
                {
                }
                field("Account No2"; Rec."Account No2")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Outstanding Balance"; Rec."Outstanding Balance") { }
                field("Outstanding Interest"; Rec."Outstanding Interest") { }
                field(Charge; Rec.Charge)
                {
                }
                field(Client; Rec.Client)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Date Posted"; Rec."Date Posted")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("SMS Message"; Rec."SMS Message")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Telephone Number"; Rec."Telephone Number")
                {
                }
                field(TraceId; Rec.TraceId)
                {
                }
                field(TransType; Rec.TransType)
                {
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("time"; Rec."time")
                {
                }
            }
        }
    }
}
