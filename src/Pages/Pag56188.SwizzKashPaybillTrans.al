#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56188 "SwizzKash Paybill Trans"
{
    ApplicationArea = Basic;
    CardPageID = "SwizzKash Paybill Tran Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "SwizzKash MPESA Trans";
    UsageCategory = Lists;
    SourceTableView = sorting(TransDate) order(descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {


                    ApplicationArea = Basic;
                }
                field(TransDate; Rec.TransDate)
                {
                    ApplicationArea = all;
                    Caption = 'Transaction Date';
                    Visible = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Key Word"; Rec."Key Word")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Needs Manual Posting"; Rec."Needs Manual Posting")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                    // Visible = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Paybill Account"; Rec."Paybill Account No") { }
                field("Paybill Acc Balance"; Rec."Paybill Acc Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted"; Rec."Time Posted")

                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = Basic;
                }
                field("Changed Date"; Rec."Date Changed")
                {
                    ApplicationArea = Basic;
                }
                field("Changed Time"; Rec."Time Changed")
                /*{
                    ApplicationArea = Basic;
                }
                field("Approved By"; Rec."Approved By")
                */
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

