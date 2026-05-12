#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
tableextension 56007 "Purchases&PayablesSetUpExt" extends "Purchases & Payables Setup"
{

    fields
    {
        field(10000; "Combine Special Orders Default"; Option)
        {
            Caption = 'Combine Special Orders Default';
            OptionCaption = 'Always Combine,,Never Combine';
            OptionMembers = "Always Combine",,"Never Combine";
        }
        field(10001; "Use Vendor's Tax Area Code"; Boolean)
        {
            Caption = 'Use Vendor''s Tax Area Code';
        }
        field(50001; "Requisition No"; Code[10])
        {
            Caption = 'Requisition No';
            TableRelation = "No. Series";
        }
        field(50002; "Quotation Request No"; Code[10])
        {
            Caption = 'Quatation Request No';
            TableRelation = "No. Series";
        }
        field(50003; "Stores Requisition No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50004; "Max. Purchase Requisition"; Decimal)
        {
        }
        field(50005; "Tender Request No"; Code[10])
        {
            Caption = 'Tender Request No';
            TableRelation = "No. Series";
        }
        field(50006; "Stores Issue No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50007; "Requisition Default Vendor"; Code[30])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                /* Vendor.RESET;
                 IF Vendor.GET(xRec."Requisition Default Vendor") THEN BEGIN
                   Vendor."Requisition Default Vendor":=FALSE;
                   Vendor.MODIFY;
                 END;

                  Vendor.RESET;
                  IF Vendor.GET("Requisition Default Vendor") THEN BEGIN
                   Vendor."Requisition Default Vendor":=TRUE;
                   Vendor.MODIFY;
                 END;*/

            end;
        }
        field(50008; "Use Procurement Limits"; Boolean)
        {
        }
        field(50009; "Inspection Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(54249; "No. Of Order Copies"; Integer)
        {
        }
        field(54250; "Copies Print Text"; Text[250])
        {
            Description = 'Text to show on print out';
        }
        field(54252; "LPO Expiry Period"; Integer)
        {
        }
        field(54253; "Allow Posting to Main Sub"; Boolean)
        {
            Caption = 'Allow Posting to Main Sub';
        }
        field(54254; "Implementing Partner"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(54255; "Study Form Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(54256; "Vendor Category Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(54257; "Vendor Contact Nos."; Code[10])
        {
        }
        field(54258; "Vendor Category Entries Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(54259; "Proposal Code Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(54260; "Start Order from Requisition"; Boolean)
        {
        }
    }

    keys
    {

    }

    fieldgroups
    {
    }

    var
        Text001: label 'Job Queue Priority must be zero or positive.';
}

