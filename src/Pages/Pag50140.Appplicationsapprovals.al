#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50140 "Appplications approvals"
{
    CardPageID = "S-Mobile Applications Card";
    Editable = false;
    PageType = List;
    SourceTable = "SwizzKash Applications";
    SourceTableView = where(Status = filter("Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Time Applied"; Rec."Time Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approve;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::"Pending Approval" then begin
                        if Vendor.Get(Rec."Account No") then begin
                            Vendor."S-Mobile No" := Rec.Telephone;
                            Vendor.Modify;
                            Rec.Status := Rec.Status::Approved;
                            Rec.Modify;

                            Message('Application has been approved');

                        end
                    end
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        StatusPermissions.Reset;
        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::Smobile);
        if StatusPermissions.Find('-') = false then
            Error('You do not have permissions to edit member information.');
    end;

    var
        Vendor: Record Vendor;
        StatusPermissions: Record 51452;
}

