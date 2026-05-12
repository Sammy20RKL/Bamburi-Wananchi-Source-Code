table 59074 "Batches"
{


    fields
    {
        field(1; "Batch No_"; Code[20])
        {
            Caption = 'Batch No.';
        }
        field(2; "Description Remarks"; Text[30])
        {
            Caption = 'Description/Remarks';
        }
        field(3; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Released,Approved,Posted;
            OptionCaption = 'Open,Released,Approved,Posted';
        }
        field(5; "Date Created"; DateTime)
        {
            Caption = 'Date Created';
        }
        field(6; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
        }
        field(9; Date; DateTime)
        {
            Caption = 'Date';
        }
        field(10; "Mode Of Disbursement"; Option)
        {
            Caption = 'Mode Of Disbursement';
            OptionMembers = " ",Cash,EFT,RTGS,Cheque;
            OptionCaption = ' ,Cash,EFT,RTGS,Cheque';
        }
        field(11; "Document No_"; Code[20])
        {
            Caption = 'Document No.';
        }
        field(12; "BOSA Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
            Caption = 'Bank Account';
        }
        field(13; "No_ Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
        field(14; "Approvals Remarks"; Text[150])
        {
            Caption = 'Approvals Remarks';
        }
        field(15; "Cheque No_"; Code[20])
        {
            Caption = 'Cheque No.';
        }
        field(16; "Batch Type"; Option)
        {
            Caption = 'Batch Type';
            OptionMembers = " ",Normal,"Special Advance";
            OptionCaption = ' ,Normal,Special Advance';
        }
        field(17; "Special Advance Posted"; Boolean)
        {
            Caption = 'Special Advance Posted';
        }
        field(18; "FOSA Bank Account"; Code[20])
        {
            Caption = 'FOSA Bank Account';
        }
        field(19; "Post to Loan Control"; Boolean)
        {
            Caption = 'Post to Loan Control';
        }
        field(20; Source; Option)
        {
            Caption = 'Source';
            OptionMembers = " ",BOSA,FOSA;
            OptionCaption = ' ,BOSA,FOSA';
        }
        field(21; "Finance Approval"; Boolean)
        {
            Caption = 'Finance Approval';
        }
        field(22; "Audit Approval"; Boolean)
        {
            Caption = 'Audit Approval';
        }
    }

    keys
    {
        key(PK; "Batch No_")
        {
            Clustered = true;
        }
    }
}