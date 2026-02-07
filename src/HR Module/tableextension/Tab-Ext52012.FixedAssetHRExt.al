tableextension 52012 "Fixed Asset HR Ext" extends "Fixed Asset"
{
    fields
    {
        field(52000; Colour; Text[30])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Colour';
        }
        field(52001; "Type of Body"; Text[30])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Type of Body';
        }
        field(52002; "Chassis No."; Code[30])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Chassis No.';
        }
        field(52003; Rating; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Rating';
        }
        field(52004; "Seating/carrying capacity"; Integer)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Seating/carrying capacity';
        }
        field(52005; "Registration No"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Registration No';
        }

        field(52006; "Date of purchase"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of purchase';
        }
        field(52027; Body; Text[30])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Body';
        }
        field(52028; "Car Tracking Company"; Text[30])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Car Tracking Company';
        }
        field(52029; "Tracking Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Tracking Date';
        }
        field(52030; "Tracking Renewal Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Tracking Renewal Date';
        }
        field(52031; "Car Rating"; Text[30])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Car Rating';
        }
        field(52032; YOM; Integer)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'YOM';
        }
        field(52033; Duty; Text[30])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Duty';
        }
        field(52007; "Policy No"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Policy No';
        }
        field(52008; Insurer; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Insurer';
        }
        field(52009; "Insurance Company"; Text[30])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Insurance Company';
        }
        field(52010; "Premium Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Premium Amount';
        }
        field(52011; "Amount of Purchase"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount of Purchase';
        }
        field(52012; "Valuation Firm"; Text[30])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Valuation Firm';
        }
        field(52013; "Last Valued Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Last Valued Date';
        }
        field(52014; "Date of Commencement"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Date of Commencement';
        }
        field(52015; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Expiry Date';
        }
        field(52016; "Fixed Asset Type"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            OptionCaption = ' ,Fleet,House';
            OptionMembers = " ",Fleet,House;
            Caption = 'Fixed Asset Type';
        }
        field(52017; "Current Odometer Reading"; Integer)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Current Odometer Reading';
        }
        field(52018; "On Trip"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'On Trip';
        }
        field(52019; "In Use"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'In Use';
        }
        field(52020; "Tank Capacity"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Tank Capacity';
        }
        field(52021; "Average Km/L"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Average Km/L';
        }
        field(52022; "Logbook No"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Logbook No';
        }
        field(52023; "Maintainence Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Available,"Under Maintenence","Written Off";
            Caption = 'Maintainence Status';
        }
        field(52024; Make; Code[10])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Make';
        }
        field(52025; Model; Text[50])
        {
            DataClassification = CustomerContent;
            Description = 'fleet';
            Caption = 'Model';
        }
        field(52026; "Vehicle Type"; Option)
        {
            OptionMembers = "Company Vehicle","Personal Vehicle","Taxi";
            OptionCaption = 'Company Vehicle, Personal Vehicle,Taxi';
            DataClassification = CustomerContent;
            Caption = 'Vehicle Type';
        }
        field(52034; Valuer; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Property';
            Caption = 'Valuer';
        }
    }
}





