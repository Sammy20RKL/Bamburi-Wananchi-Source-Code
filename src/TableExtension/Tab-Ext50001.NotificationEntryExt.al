namespace PolyTech.PolyTech;

using System.Environment.Configuration;
using System.Reflection;

tableextension 50001 "Notification Entry Ext" extends "Notification Entry"
{
    fields
    {
        field(50000; "Text"; Code[20])
        {
            Caption = '';
            DataClassification = ToBeClassified;
        }
    }

    procedure CreateNew(NewType: Option "New Record",Approval,Overdue; NewUserID: Code[50]; NewRecord: Variant; NewLinkTargetPage: Integer; NewCustomLink: Text[250])
    var
        DataTypeManagement: Codeunit "Data Type Management";
        NewRecRef: RecordRef;
        NotificationSchedule: Record "Notification Schedule";
    begin
        IF NOT DataTypeManagement.GetRecordRef(NewRecord, NewRecRef) THEN
            EXIT;

        CLEAR(Rec);
        Type := NewType;
        "Recipient User ID" := NewUserID;
        "Triggered By Record" := NewRecRef.RECORDID;
        "Link Target Page" := NewLinkTargetPage;
        "Custom Link" := NewCustomLink;
        INSERT(TRUE);


        NotificationSchedule.ScheduleNotification(Rec);
    end;
}
