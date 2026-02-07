namespace PolyTech.PolyTech;

page 57107 "M Polytech Loans"
{
    ApplicationArea = All;
    Caption = 'M-Polytech Loans';
    CardPageId = "M-Polytech Loans Card";
    PageType = List;
    SourceTable = "SwizzKash Transactions";
    SourceTableView = sorting("Entry")
                      order(ascending)
                      where("Transaction Type" = filter("Loan Application"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ToolTip = 'Specifies the value of the Loan No field.', Comment = '%';
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }

                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance") { }
                field("Outstanding Interest"; Rec."Outstanding Interest") { }
                field("Date Posted"; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("APP Type"; Rec."APP Type")
                {
                    ToolTip = 'Specifies the value of the APP Type field.', Comment = '%';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.', Comment = '%';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field("Account No2"; Rec."Account No2")
                {
                    ToolTip = 'Specifies the value of the Account No2 field.', Comment = '%';
                }
                field(Charge; Rec.Charge)
                {
                    ToolTip = 'Specifies the value of the Charge field.', Comment = '%';
                }
                field(Client; Rec.Client)
                {
                    ToolTip = 'Specifies the value of the Client field.', Comment = '%';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Entry; Rec.Entry)
                {
                    ToolTip = 'Specifies the value of the Entry field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field("SMS Message"; Rec."SMS Message")
                {
                    ToolTip = 'Specifies the value of the SMS Message field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Telephone Number"; Rec."Telephone Number")
                {
                    ToolTip = 'Specifies the value of the Telephone Number field.', Comment = '%';
                }
                field(TraceId; Rec.TraceId)
                {
                    ToolTip = 'Specifies the value of the TraceId field.', Comment = '%';
                }
                field(TransType; Rec.TransType)
                {
                    ToolTip = 'Specifies the value of the TransType field.', Comment = '%';
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ToolTip = 'Specifies the value of the Transaction Time field.', Comment = '%';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.', Comment = '%';
                }
                field("time"; Rec."time")
                {
                    ToolTip = 'Specifies the value of the time field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
            }
        }
    }
}
