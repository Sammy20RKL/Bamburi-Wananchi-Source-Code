#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50220 "HR Employee Attachments SF"
{
    Caption = 'HR Employee Attachments';
    DeleteAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Attachments';
    SourceTable = "HR Employee Attachments";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = Basic;
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Attachment Imported';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Open)
            {
                ApplicationArea = Basic;
                Caption = 'Open';
                Image = Open;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec."Employee No", Rec."Document Description") then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then
                            //IF InteractTemplLanguage.GET(DocLink."Employee No",DocLink."Language Code (Default)",DocLink."Document Description") THEN
                            InteractTemplLanguage.OpenAttachment;
                    end;
                end;
            }
            action(Create)
            {
                ApplicationArea = Basic;
                Caption = 'Create';
                Ellipsis = true;
                Image = Create_Movement;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec."Employee No", Rec."Document Description") then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if not InteractTemplLanguage.FindFirst then
                        //iF NOT InteractTemplLanguage.GET(DocLink."Employee No",DocLink."Language Code (Default)",DocLink."Document Description") THEN
                        begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Rec."Employee No";
                            InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                            InteractTemplLanguage.Description := Rec."Document Description";
                        end;
                        InteractTemplLanguage.CreateAttachment;
                        CurrPage.Update;
                        DocLink.Attachment := DocLink.Attachment::Yes;
                        DocLink.Modify;
                    end;
                end;
            }
            action("Copy & From")
            {
                ApplicationArea = Basic;
                Caption = 'Copy & From';
                Ellipsis = true;
                Image = Copy;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec."Employee No", Rec."Document Description") then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then
                            //IF InteractTemplLanguage.GET(DocLink."Employee No",DocLink."Language Code (Default)",DocLink."Document Description") THEN

                            InteractTemplLanguage.CopyFromAttachment;
                        CurrPage.Update;
                        DocLink.Attachment := DocLink.Attachment::Yes;
                        DocLink.Modify;
                    end;
                end;
            }
            action(Import)
            {
                ApplicationArea = Basic;
                Caption = 'Import';
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec."Employee No", Rec."Document Description") then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if not InteractTemplLanguage.FindFirst then
                        //IF NOT InteractTemplLanguage.GET(DocLink."Employee No",DocLink."Language Code (Default)",DocLink."Document Description") THEN
                        begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Rec."Employee No";
                            InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                            InteractTemplLanguage.Description := DocLink."Document Description";
                            InteractTemplLanguage.Insert;
                        end;
                        InteractTemplLanguage.ImportAttachment;
                        CurrPage.Update;
                        DocLink.Attachment := DocLink.Attachment::Yes;
                        DocLink.Modify;
                    end;
                end;
            }
            action("E&xport")
            {
                ApplicationArea = Basic;
                Caption = 'E&xport';
                Ellipsis = true;
                Image = Export;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec."Employee No", Rec."Document Description") then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then
                            //iF InteractTemplLanguage.GET(DocLink."Employee No",DocLink."Language Code (Default)",DocLink."Document Description") THEN
                            InteractTemplLanguage.ExportAttachment;
                    end;
                end;
            }
            action(Remove)
            {
                ApplicationArea = Basic;
                Caption = 'Remove';
                Ellipsis = true;
                Image = RemoveContacts;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec."Employee No", Rec."Document Description") then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec."Employee No");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then begin
                            //IF InteractTemplLanguage.GET(DocLink."Employee No",DocLink."Language Code (Default)",DocLink."Document Description") THEN BEGIN
                            InteractTemplLanguage.RemoveAttachment(true);
                            DocLink.Attachment := DocLink.Attachment::No;
                            DocLink.Modify;
                        end;
                    end;
                end;
            }
        }
    }

    var
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        DocLink: Record 51207;


    procedure GetDocument() Document: Text[200]
    begin
        Document := Rec."Document Description";
    end;
}

