Report 50300 "Update Member Dormancy"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            var
                DateFormula: Text;
                Lastdate: Date;
            begin
                IF (Customer.Status = Customer.Status::Withdrawal) OR (Customer.Status = Customer.Status::Deceased)
                 or (Customer.Status = Customer.Status::"Awaiting Withdrawal") or (Customer.Status = Customer.Status::Blocked) THEN
                    CurrReport.SKIP;
                GenSetup.GET();
                Cust.Reset();
                Cust.SetRange(Cust."No.", "No.");
                if Cust.FindSet() then begin
                    repeat
                        DormancyDate := 0D;
                        cust.CalcFields(Cust."Last Payment Date");
                        if Cust."Last Payment Date" <> 0D then begin
                            DormancyDate := CALCDATE(GenSetup."Max. Non Contribution Periods", Cust."Last Payment Date");
                            IF DormancyDate > Today THEN begin
                                Cust.Status := Cust.Status::Active;
                                Cust.Modify;
                            end;
                            IF DormancyDate < Today THEN begin
                                Cust.Status := Cust.Status::Dormant;
                                Cust.MODIFY;
                            end;
                        END else if Cust."Last Payment Date" = 0D then
                                Cust.Status := Cust.Status::Dormant;
                        Cust.MODIFY;
                    until Cust.next = 0;
                end;
            end;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
        DormancyDate: Date;
        Cust: Record Customer;
        GenSetup: Record "Sacco General Set-Up";
}