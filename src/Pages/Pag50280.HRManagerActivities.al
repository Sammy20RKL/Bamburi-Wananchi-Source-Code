#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50280 "HR Manager Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "HR Cue";

    layout
    {
        area(content)
        {
            cuegroup(Leave)
            {
                Caption = 'Leave';
                field("Leaves To be Approved"; Rec."Leaves To be Approved")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Leaves';
                    DrillDownPageID = "HR Leave Ledger Entries";
                }

                actions
                {
                    action("Leave Application Card")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Leave Application Card';
                        // RunObject = Page "HR Leave Application Card";
                    }
                    action("Employee Card")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Employee Card';
                        RunObject = Page "HR Employee Card";
                        RunPageMode = Create;
                    }
                }
            }
            cuegroup(Employees)
            {
                Caption = 'Employees';
                field("Employee Requisitions"; Rec."Employee Requisitions")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Employee Requisitions List";
                }
                field("Employee -Active"; Rec."Employee -Active")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee -Active';
                    DrillDownPageID = "HR Employee-List PR";
                }

                actions
                {
                    action("Create Reminders...")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Create Reminders...';
                        Image = CreateReminders;
                        RunObject = Report "Create Reminders";
                    }
                    action("Create Finance Charge Memos...")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Create Finance Charge Memos...';
                        Image = CreateFinanceChargememo;
                        RunObject = Report "Create Finance Charge Memos";
                    }
                }
            }
            cuegroup("Incoming Documents")
            {
                Caption = 'Incoming Documents';
                field("New Incoming Documents"; Rec."New Incoming Documents")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Incoming Documents"; Rec."Approved Incoming Documents")
                {
                    ApplicationArea = Basic;
                }

                actions
                {
                    action(IncomingDocuments)
                    {
                        ApplicationArea = Basic;
                        Caption = 'View Incoming Documents';
                        RunObject = Page "Incoming Documents";
                        RunPageMode = View;
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;

        Rec.SetFilter("Due Date Filter", '<=%1', WorkDate);
        Rec.SetFilter("Overdue Date Filter", '<%1', WorkDate);
    end;
}

