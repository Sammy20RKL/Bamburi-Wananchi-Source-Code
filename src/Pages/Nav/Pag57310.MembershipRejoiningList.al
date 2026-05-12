#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 57310 "Membership Rejoining List"
{
    Caption = 'Member List';
    CardPageID = "Membership Rejoining App";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = sorting("No.")
                      order(ascending)
                      where("Customer Type" = const(Member),
                            Status = const(Withdrawal));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No"; Rec."Personal No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1102755024)
            {
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                    Visible = false;
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
            }
            group("Issued Documents")
            {
                Caption = 'Issued Documents';
                Visible = false;
                action("Loans Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guarantors';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Loans Guarantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */

                    end;
                }
            }
            group(ActionGroup1102755013)
            {
                separator(Action1102755008)
                {
                }
            }
            group(ActionGroup1102755007)
            {
                action(Statement)
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        // if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                        //     if UserSetup.Get(UserId) then begin
                        //         if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                        //     end;

                        // end;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516886, true, false, Cust);
                    end;
                }
                action("Statement act")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement Active';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        // if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                        //     if UserSetup.Get(UserId) then begin
                        //         if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                        //     end;

                        // end;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516301, true, false, Cust);
                    end;
                }
                action("Next Of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next Of Kin Report';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        // if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                        //     if UserSetup.Get(UserId) then begin
                        //         if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                        //     end;

                        // end;

                        MembersNominee.Reset;
                        MembersNominee.SetRange(MembersNominee."Account No", Rec."No.");
                        if MembersNominee.Find('-') then
                            Report.Run(51516305, true, false, MembersNominee);
                    end;
                }
                action("New Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        // if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                        //     if UserSetup.Get(UserId) then begin
                        //         if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                        //     end;

                        // end;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516892, true, false, Cust);
                    end;
                }
                action("Member Deposits Statement")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516354, true, false, Cust);
                    end;
                }
                action("Loan Statement BOSA")
                {
                    ApplicationArea = Basic;
                    Image = customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516531, true, false, Cust);
                    end;
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516390, true, false, Cust);
                    end;
                }
                action("Send Checkoff")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnAction()
                    begin
                        FnGenerateCheckoffSlips(Rec."No.", Rec."No." + '.pdf');
                    end;
                }
                action("New Statement ()")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        // if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                        //     if UserSetup.Get(UserId) then begin
                        //         if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                        //     end;

                        // end;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(51516291, true, false, Cust);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MemberLiability := SFactory.FnGetMemberLiability(Rec."No.");
    end;

    var
        Cust: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        TotalAvailable: Integer;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        TotalDefaulterR: Decimal;
        Value2: Decimal;
        AvailableShares: Decimal;
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        RoundingDiff: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];

        MemberLiability: Decimal;
        SFactory: Codeunit "Swizzsoft Factory.";
        ObjMember: Record Customer;
        FILESPATH: label 'C:\CheckOff Reports\';
        MembersNominee: Record "Members Nominee";


    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        /*CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
          Cust.FIND('-');
          WHILE CustCount > 0 DO BEGIN
            CustCount := CustCount - 1;
            Cust.MARKEDONLY(FALSE);
            FirstCust := Cust."No.";
            LastCust := FirstCust;
            More := (CustCount > 0);
            WHILE More DO
              IF Cust.NEXT = 0 THEN
                More := FALSE
              ELSE
                IF NOT Cust.MARK THEN
                  More := FALSE
                ELSE BEGIN
                  LastCust := Cust."No.";
                  CustCount := CustCount - 1;
                  IF CustCount = 0 THEN
                    More := FALSE;
                END;
            IF SelectionFilter <> '' THEN
              SelectionFilter := SelectionFilter + '|';
            IF FirstCust = LastCust THEN
              SelectionFilter := SelectionFilter + FirstCust
            ELSE
              SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
            IF CustCount > 0 THEN BEGIN
              Cust.MARKEDONLY(TRUE);
              Cust.NEXT;
            END;
          END;
        END;
        EXIT(SelectionFilter);
        */

    end;


    procedure SetSelection(var Cust: Record Customer)
    begin
        //CurrPage.SETSELECTIONFILTER(Cust);
    end;


    procedure FnGenerateCheckoffSlips("member no": Code[50]; path: Text[100])
    var
        filename: Text[100];
    begin
        filename := FILESPATH + path;
        Message(FILESPATH);
        if Exists(filename) then
            Erase(filename);
        ObjMember.Reset;
        ObjMember.SetRange("No.", "member no");
        if ObjMember.Find('-') then begin
            Report.SaveAsPdf(51516456, filename, ObjMember);
        end;
    end;
}

