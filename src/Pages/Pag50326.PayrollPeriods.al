#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50326 "Payroll Periods."
{
    ApplicationArea = Basic, Suite;
    Caption = 'Payroll Periods.';
    UsageCategory = Tasks;
    DeleteAllowed = true;
    Editable = true;
    PageType = Card;
    SourceTable = "Payroll Calender.";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;

                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;

                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = All;

                }
                field("Date Opened"; Rec."Date Opened")
                {
                    ApplicationArea = All;

                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = All;
                    Editable = true;

                }
                field(Closed; Rec.Closed)
                {

                    ApplicationArea = All;
                    Editable = true;

                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Close Period")
            {
                ApplicationArea = All;
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*
                    Warn user about the consequence of closure - operation is not reversible.
                    Ask if he is sure about the closure.
                    */

                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'Still want to close [' + strPeriodName + ']';
                    PayrollDefined := '';
                    // PayrollType.SetCurrentKey("Payroll Code");
                    // if PayrollType.FindFirst then begin
                    //     NoofRecords := PayrollType.Count;
                    //     repeat
                    //         i += 1;
                    //         PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                    //         if i < NoofRecords then
                    //             PayrollDefined := PayrollDefined + ','
                    //     until PayrollType.Next = 0;
                    // end;


                    // Selection := StrMenu(PayrollDefined, 3);
                    // PayrollType.Reset;
                    // PayrollType.SetRange(PayrollType.EntryNo, Selection);
                    // if PayrollType.Find('-') then begin
                    //     PayrollCode := PayrollType."Payroll Code";
                    // end;
                    // end;
                    //End Multiple Payroll




                    Answer := DIALOG.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(objOcx);
                        objOcx.fnClosePayrollPeriod(dtOpenPeriod, PayrollCode);
                        Message('Process Complete');
                    end else begin
                        Message('You have selected NOT to Close the period');
                    end

                end;
            }
            // action("Create Period")
            // {
            //     ApplicationArea = All;
            //     Visible = false;
            //     trigger OnAction()
            //     begin
            //         ContrInfo.Init();

            //         ContrInfo."Primary Key" := ' ';
            //         ContrInfo.Name := 'Polytech';
            //         ContrInfo.Insert();
            //     end;
            // }
        }
    }

    var
        PayPeriod: Record "Payroll Calender.";
        strPeriodName: Text[30];
        Text000: Label '''Leave without saving changes?''';
        Text001: Label '''You selected %1.''';
        Question: Text[250];
        Answer: Boolean;
        objOcx: Codeunit "Payroll Processing";
        dtOpenPeriod: Date;
        PayrollType: Record "Payroll Type.";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information.";

    procedure fnGetOpenPeriod()
    begin
        // PayPeriod.Reset();
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.FindLast() then begin
            strPeriodName := PayPeriod."Period Name";
            dtOpenPeriod := PayPeriod."Date Opened";
        end;
    end;
}
