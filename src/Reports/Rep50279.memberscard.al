#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50279 "Members Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/members_card.rdl';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("Members Register"; Customer)
        {
            column(ReportForNavId_2; 2)
            {
            }
            column(InvNo; "Members Register"."No.")
            {
            }
            column(InvName; "Members Register".Name)
            {
            }
            column(InvEmail; "Members Register"."E-Mail (Personal)")
            {
            }
            column(InvId; "Members Register"."ID No.")
            {
            }
            column(InvPicture; "Members Register".Image)
            {
            }
            column(Siignature; "Members Register".Signature)
            {
            }
            column(CName; CompInfo.Name)
            {
            }
            column(CAddress; CompInfo.Address)
            {
            }
            column(CPic; CompInfo.Picture)
            {
            }
            column(TodayStr; TodayStr)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.Get;
                CompInfo.CalcFields(CompInfo.Picture);

                //CalcFields(Picture);

                //Date of Issue
                Month := Date2dmy(Today, 2);
                Year := Date2dmy(Today, 3);
                case Month of
                    1:
                        TodayStr := 'Date of Issue: January ' + Format(Year);
                    2:
                        TodayStr := 'Date of Issue: February ' + Format(Year);
                    3:
                        TodayStr := 'Date of Issue: March ' + Format(Year);
                    4:
                        TodayStr := 'Date of Issue: April ' + Format(Year);
                    5:
                        TodayStr := 'Date of Issue: May ' + Format(Year);
                    6:
                        TodayStr := 'Date of Issue: June ' + Format(Year);
                    7:
                        TodayStr := 'Date of Issue: July ' + Format(Year);
                    8:
                        TodayStr := 'Date of Issue: August ' + Format(Year);
                    9:
                        TodayStr := 'Date of Issue: September ' + Format(Year);
                    10:
                        TodayStr := 'Date of Issue: October ' + Format(Year);
                    11:
                        TodayStr := 'Date of Issue: November ' + Format(Year);
                    12:
                        TodayStr := 'Date of Issue: December ' + Format(Year);
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInfo: Record "Company Information";
        LevelCaptionLbl: label 'Level';
        ProgrammeCaptionLbl: label 'Programme';
        NamesCaptionLbl: label 'Names';
        Signature_CaptionLbl: label 'Signature:';
        STUDENT_ID_CARDCaptionLbl: label 'STUDENT ID CARD';
        Valid: Integer;
        TodayStr: Text;
        Month: Integer;
        Year: Integer;
}

