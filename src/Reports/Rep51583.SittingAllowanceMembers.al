#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51583 "Sitting Allowance Members"
{
    RDLCLayout = './Layouts/sittingAllowanceMembers2.rdl';
    DefaultLayout = RDLC;
    ApplicationArea = Basic;

    dataset
    {
        dataitem("Payments Line"; "Payment Line New")
        {
            DataItemTableView = where("Account No." = const('400554'));//, Posted = filter(true));//("Account No." = const('400554'));//("Payment Type" = filter('SITTING ALLOWANCE'));////201214
            RequestFilterFields = "Date Posted", "Member Type", "Board Member Name";

            column(AccountName_PaymentLine; "Payments Line"."Account Name") { }
            column(MemberType_PaymentLine; "Member Type") { }
            column(Board_Member_Name; "Board Member Name") { }
            column(Amount_PaymentLine; "Payments Line".Amount) { }
            column(NetAmount_PaymentLine; "Payments Line"."Net Amount") { }
            column(Date_PaymentLine; "Payments Line"."Date Posted") { }
        }
    }
    requestpage
    {
        SaveValues = false;
        layout
        {
        }
    }
    var
        Customer: Record Customer;

}
