#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50039 "FD transfer Term Amount List"
{
    CardPageID = "FD Transfer Term Amount Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "FD Processing";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No."; Rec."Personal No.")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Status"; Rec."Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                }
                field("Call Deposit"; Rec."Call Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No"; Rec."BOSA Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("FD Marked for Closure"; Rec."FD Marked for Closure")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Earned"; Rec."Interest Earned")
                {
                    ApplicationArea = Basic;
                }
                field("Untranfered Interest"; Rec."Untranfered Interest")
                {
                    ApplicationArea = Basic;
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account No."; Rec."Savings Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Duration"; Rec."Fixed Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Neg. Interest Rate"; Rec."Neg. Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Date Renewed"; Rec."Date Renewed")
                {
                    ApplicationArea = Basic;
                }
                field("Last Interest Date"; Rec."Last Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field("S-Mobile No"; Rec."S-Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("FDR Deposit Status Type"; Rec."FDR Deposit Status Type")
                {
                    ApplicationArea = Basic;
                }
                field("On Term Deposit Maturity"; Rec."On Term Deposit Maturity")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Interest On Term Dep"; Rec."Expected Interest On Term Dep")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account"; Rec."Destination Account")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Current Account Balance"; Rec."Current Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; Rec."Date Posted")
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
    }
}

