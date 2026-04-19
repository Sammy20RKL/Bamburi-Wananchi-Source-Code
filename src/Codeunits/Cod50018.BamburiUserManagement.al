#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50018 "Polytech User Management"
{
    // Permissions = TableData "G/L Entry" = rm,
    //               TableData "Cust. Ledger Entry" = rm,
    //               TableData "Vendor Ledger Entry" = rm,
    //               TableData "G/L Register" = rm,
    //               TableData "Item Register" = rm,
    //               TableData "G/L Budget Entry" = rm,
    //               TableData "Sales Shipment Header" = rm,
    //               TableData "Sales Invoice Header" = rm,
    //               TableData "Sales Cr.Memo Header" = rm,
    //               TableData "Purch. Rcpt. Header" = rm,
    //               TableData "Purch. Inv. Header" = rm,
    //               TableData "Purch. Cr. Memo Hdr." = rm,
    //               TableData "Job Ledger Entry" = rm,
    //               TableData "Res. Ledger Entry" = rm,
    //               TableData "Resource Register" = rm,
    //               TableData "Job Register" = rm,
    //               TableData "VAT Entry" = rm,
    //               TableData "Bank Account Ledger Entry" = rm,
    //               TableData "Check Ledger Entry" = rm,
    //               TableData "Phys. Inventory Ledger Entry" = rm,
    //               TableData "Issued Reminder Header" = rm,
    //               TableData "Reminder/Fin. Charge Entry" = rm,
    //               TableData "Issued Fin. Charge Memo Header" = rm,
    //               TableData "Reservation Entry" = rm,
    //               TableData "Item Application Entry" = rm,
    //               TableData "Detailed Cust. Ledg. Entry" = rm,
    //               TableData "Detailed Vendor Ledg. Entry" = rm,
    //               TableData "Change Log Entry" = rm,
    //               TableData "Approval Entry" = rm,
    //               TableData "Approval Comment Line" = rm,
    //               TableData "Posted Approval Entry" = rm,
    //               TableData "Posted Approval Comment Line" = rm,
    //               TableData "Posted Assembly Header" = rm,
    //               TableData "Cost Entry" = rm,
    //               TableData "Cost Register" = rm,
    //               TableData "Cost Budget Entry" = rm,
    //               TableData "Cost Budget Register" = rm,
    //               TableData "Interaction Log Entry" = rm,
    //               TableData "Campaign Entry" = rm,
    //               TableData "FA Ledger Entry" = rm,
    //               TableData "FA Register" = rm,
    //               TableData "Maintenance Ledger Entry" = rm,
    //               TableData "Ins. Coverage Ledger Entry" = rm,
    //               TableData "Insurance Register" = rm,
    //               TableData "Value Entry" = rm,
    //               TableData "Service Ledger Entry" = rm,
    //               TableData "Service Register" = rm,
    //               TableData "Contract Gain/Loss Entry" = rm,
    //               TableData "Filed Service Contract Header" = rm,
    //               TableData "Service Shipment Header" = rm,
    //               TableData "Service Invoice Header" = rm,
    //               TableData "Service Cr.Memo Header" = rm,
    //               TableData "Return Shipment Header" = rm,
    //               TableData "Return Receipt Header" = rm,
    //               TableData "Item Budget Entry" = rm,
    //               TableData "Warehouse Entry" = rm,
    //               TableData "Warehouse Register" = rm;

    trigger OnRun()
    begin
    end;

    var
        Text000: label 'The user name %1 does not exist.';
        Text001: label 'You are renaming an existing user. This will also update all related records. Are you sure that you want to rename the user?';
        Text002: label 'The account %1 already exists.';
        Text003: label 'You do not have permissions for this action.';

    procedure ValidateUserID(UserName: Code[50])
    var
        User: Record User;
    begin
        if UserName <> '' then begin
            User.SetCurrentkey("User Name");
            User.SetRange("User Name", UserName);
            if not User.FindFirst then begin
                User.Reset;
                if not User.IsEmpty then
                    Error(Text000, UserName);
            end;
        end;
    end;

    procedure LookupUserID(var UserName: Code[50])
    var
        SID: Guid;
    begin
        LookupUser(UserName, SID);
    end;

    procedure DisplayUserInformation(Username: Text)
    var
        User: Record User;
    begin
        User.FilterGroup(2);
        User.SetRange("User Name", Username);
        User.FilterGroup(0);
        if not User.FindLast() then
            exit;
        OpenUserPageForSelectedUser(User);
    end;

    local procedure OpenUserPageForSelectedUser(var User: Record User)
    var
        UserLookup: Page "User Lookup";
    begin
        UserLookup.Editable := false;
        UserLookup.SetTableView(User);
        UserLookup.RunModal();
    end;

    procedure LookupUser(var UserName: Code[50]; var SID: Guid): Boolean
    var
        User: Record User;
    begin
        User.Reset;
        User.SetCurrentkey("User Name");
        User."User Name" := UserName;
        if User.Find('=><') then;
        if Page.RunModal(Page::Users, User) = Action::LookupOK then begin
            UserName := User."User Name";
            SID := User."User Security ID";
            exit(true);
        end;

        exit(false);
    end;



    local procedure IsPrimaryKeyField(TableID: Integer; FieldID: Integer; var NumberOfPrimaryKeyFields: Integer): Boolean
    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        RecRef: RecordRef;
        KeyRef: KeyRef;
    begin
        RecRef.Open(TableID);
        KeyRef := RecRef.KeyIndex(1);
        NumberOfPrimaryKeyFields := KeyRef.FieldCount;
        exit(ConfigValidateMgt.IsKeyField(TableID, FieldID));
    end;



    [IntegrationEvent(false, false)]
    procedure OnAfterRenameRecord(var RecRef: RecordRef; TableNo: Integer; NumberOfPrimaryKeyFields: Integer; UserName: Code[50]; Company: Text[30])
    begin
    end;
}

