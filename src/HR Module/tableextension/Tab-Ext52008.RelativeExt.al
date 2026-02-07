tableextension 52008 "RelativeExt" extends Relative
{
    fields
    {
        field(52000; "Medical Scheme No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Medical Scheme No';
        }
        field(52001; "Employee Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Code';
        }
        field(52002; "National ID/Passport No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'National ID/Passport No';
        }
        field(52003; "Fiscal Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Fiscal Year';
        }
        field(52004; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(52005; Gender; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " Male",Female;
            Caption = 'Gender';
        }
        field(52006; "In-Patient Entitlement"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'In-Patient Entitlement';
        }
        field(52007; "Out-Patient Entitlment"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Out-Patient Entitlment';
        }
        field(52008; "Amount Spend (In-Patient)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Spend (In-Patient)';
        }
        field(52009; "Amout Spend (Out-Patient)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amout Spend (Out-Patient)';
        }
        field(52010; "Policy Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Policy Start Date';
        }
        field(52011; "Medical Cover Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","In House",Outsourced;
            Caption = 'Medical Cover Type';
        }
        field(52012; "Date of Birth"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Birth';
        }
    }
}
