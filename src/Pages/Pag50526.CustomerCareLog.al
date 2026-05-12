#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50526 "Customer Care Log"
{
    PageType = Card;
    SourceTable = "Customer Care Logs";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Calling As"; Rec."Calling As")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin


                        if Rec."Calling As" = Rec."calling as"::"As Member" then
                            Page.Run(39004305, Rec);
                    end;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Mode"; Rec."Contact Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Calling For"; Rec."Calling For")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Current Deposits"; Rec."Current Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No';
                }
                field("Passport No"; Rec."Passport No")
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Query Code"; Rec."Query Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Application User"; Rec."Application User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Time"; Rec."Application Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Receive User"; Rec."Receive User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Receive date"; Rec."Receive date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Receive Time"; Rec."Receive Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Resolved User"; Rec."Resolved User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Resolved Date"; Rec."Resolved Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Resolved Time"; Rec."Resolved Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Caller Reffered To"; Rec."Caller Reffered To")
                {
                    ApplicationArea = Basic;
                }
                field("Date Sent"; Rec."Date Sent")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Sent"; Rec."Time Sent")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sent By"; Rec."Sent By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Detailed Member Page")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Member Account Card";
                RunPageLink = "No." = field("Member No");
            }
            action("Send To")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Caller Reffered To");
                    Rec."Date Sent" := WorkDate;
                    Rec."Time Sent" := Time;
                    Rec."Sent By" := UserId;
                    Rec.Modify;
                end;
            }
            action(Receive)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec."Receive User" := UserId;
                    Rec."Receive date" := WorkDate;
                    Rec."Receive Time" := Time;
                    Rec.Modify;
                end;
            }
            action(Reselved)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin

                    if Rec.Status = Rec.Status::Resolved then begin
                        Error('Customer query has already been %1', Rec.Status);
                    end;



                    //TO ENABLE RESOLUTION OF CUSTOMER QUERIES LOGGED INTO THE SYSTEM
                    CustCare.SetRange(CustCare.No, Rec.No);
                    if CustCare.Find('-') then begin
                        CustCare.Status := CustCare.Status::Resolved;
                        CustCare."Resolved User" := UserId;
                        CustCare."Resolved Date" := WorkDate;
                        CustCare."Resolved Time" := Time;
                        CustCare.Modify;
                    end;

                    CurrPage.Editable := false;
                    /*
                    CQuery.RESET;
                    CQuery.SETRANGE(CQuery.No,No);
                    IF CQuery.FIND('-') THEN BEGIN
                    REPORT.RUN(39004018,TRUE,FALSE,CQuery);
                    END;
                         */

                end;
            }
        }
    }

    var
        Cust: Record Customer;
        PvApp: Record "Responsibility Center BR";
        CustCare: Record "Customer Care Logs";
        CQuery: Record "Customer Care Logs";
}

