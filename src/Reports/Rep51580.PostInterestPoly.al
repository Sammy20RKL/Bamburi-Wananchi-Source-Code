#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51580 "Post Interest-Poly"
{
    ProcessingOnly = true;
    //WordLayout = './Layouts/PostInterest-Poly.docx';
    //DefaultLayout = Word;
    requestpage
    {
        SaveValues = false;
        layout
        {
        }

    }

    trigger OnPostReport()
    begin
        //Message('Posted Successfully');
    end;

    trigger OnPreReport()
    begin
        InterestHeader.Reset;
        InterestHeader.SetRange("No.", 'INTEREST');
        if InterestHeader.FindFirst then begin
            PeriodicActivities.PostLoanInterest(InterestHeader);
            //........................................................
            //........................................................
        end;
    end;

    var
        InterestHeader: Record "Interest Header";
        PeriodicActivities: Codeunit "Periodic Activities";
        //Temp: Record UnknownRecord51516031;
        Jtemplate: Code[30];
        JBatch: Code[30];
        GenJournalLine: Record "Gen. Journal Line";

    trigger OnInitReport();
    begin

    end;

}
