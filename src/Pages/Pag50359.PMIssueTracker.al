#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50359 "PM Issue Tracker"
{
    PageType = List;
    SourceTable = 51648;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Module Code"; Rec."Module Code")
                {
                    ApplicationArea = Basic;
                }
                field("UAT Level"; Rec."UAT Level")
                {
                    ApplicationArea = Basic;
                }
                field("UAT Item"; Rec."UAT Item")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("USER ID"; Rec."USER ID")
                {
                    ApplicationArea = Basic;
                }
                field("Assigned to"; Rec."Assigned to")
                {
                    ApplicationArea = Basic;
                }
                field("Swizzsoft status"; Rec."Swizzsoft status")
                {
                    ApplicationArea = Basic;
                }
                field("Date Resolved SS"; Rec."Date Resolved SS")
                {
                    ApplicationArea = Basic;
                }
                field("Swizzsoft Comments"; Rec."Swizzsoft Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Status"; Rec."Customer Status")
                {
                    ApplicationArea = Basic;
                }
                field("User Comments"; Rec."User Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Date Raised"; Rec."Date Raised")
                {
                    ApplicationArea = Basic;
                }
                field("Date Resolved"; Rec."Date Resolved")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CoveragePercentStyle := 'None';
        SetStyles;
    end;

    trigger OnOpenPage()
    begin
        if not ((UserId = 'ERP\ADMINISTRATOR') or (UserId = 'JMUTUKU') or (UserId = 'TEST')) then
            Error('Access denied');
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'None';
        if Rec."Customer Status" = Rec."customer status"::WIP then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Customer Status" = Rec."customer status"::Rejected then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Customer Status" = Rec."customer status"::Resolved then
            CoveragePercentStyle := 'favorable';
    end;
}

