#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50559 "Loan Collateral Register Card"
{
    PageType = Card;
    SourceTable = "Loan Collateral Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type"; Rec."Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description"; Rec."Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Posting Group"; Rec."Collateral Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner"; Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = Basic;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Insurance Details")
            {
                field("Insurance Effective Date"; Rec."Insurance Effective Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Expiration Date"; Rec."Insurance Expiration Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Policy No."; Rec."Insurance Policy No.")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Annual Premium"; Rec."Insurance Annual Premium")
                {
                    ApplicationArea = Basic;
                }
                field("Policy Coverage"; Rec."Policy Coverage")
                {
                    ApplicationArea = Basic;
                }
                field("Total Value Insured"; Rec."Total Value Insured")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Type"; Rec."Insurance Type")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Vendor No."; Rec."Insurance Vendor No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Depreciation Details")
            {
                field("Asset Value"; Rec."Asset Value")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Depreciation Completion Date"; Rec."Depreciation Completion Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Date of Loan Complition';
                    Editable = false;
                }
                field("Depreciation Percentage"; Rec."Depreciation Percentage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collateral Depreciation Method"; Rec."Collateral Depreciation Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Asset Depreciation Amount"; Rec."Asset Depreciation Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Asset Value @Loan Completion"; Rec."Asset Value @Loan Completion")
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
            action("Calculate Depreciation")
            {
                ApplicationArea = Basic;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    VarNoofYears := ROUND((Rec."Depreciation Completion Date" - Today) / 365, 1, '>');

                    //===========Update Year 1 Depreciation==================================
                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindSet = false then begin
                        VarDepreciationValue := Rec."Asset Value" * (Rec."Depreciation Percentage" / 100);

                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', Today);
                        ObjCollateralDeprReg."Transaction Description" := 'Year 1 Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := Rec."Asset Value" - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;

                    end;
                    //=============End of Update Year 1 Depreciation==========================


                    //===========Update Year 2 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * (Rec."Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", Rec."Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;

                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= Rec."Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 2 Depreciation==========================

                    //===========Update Year 3 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * (Rec."Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", Rec."Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= Rec."Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 3 Depreciation==========================

                    //===========Update Year 4 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * (Rec."Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", Rec."Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= Rec."Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 4 Depreciation==========================

                    //===========Update Year 5 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * (Rec."Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", Rec."Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= Rec."Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 5 Depreciation==========================

                    //===========Update Year 6 Depreciation==================================

                    ObjCollateralDeprReg.Reset;
                    ObjCollateralDeprReg.SetRange(ObjCollateralDeprReg."Document No", Rec."Document No");
                    if ObjCollateralDeprReg.FindLast then begin
                        VarCurrentNBV := ObjCollateralDeprReg."Collateral NBV";
                        VarDepreciationValue := ObjCollateralDeprReg."Collateral NBV" * (Rec."Depreciation Percentage" / 100);
                    end;

                    ObjDepreciationRegister.Reset;
                    ObjDepreciationRegister.SetRange(ObjDepreciationRegister."Document No", Rec."Document No");
                    if ObjDepreciationRegister.FindSet then begin
                        VarDepreciationNo := ObjDepreciationRegister.Count + 1;
                    end;
                    if (CalcDate('1Y', ObjCollateralDeprReg."Transaction Date")) <= Rec."Depreciation Completion Date" then begin
                        ObjCollateralDeprReg.Init;
                        ObjCollateralDeprReg."Document No" := Rec."Document No";
                        ObjCollateralDeprReg."Transaction Date" := CalcDate('1Y', ObjCollateralDeprReg."Transaction Date");
                        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(VarDepreciationNo) + ' Depreciation';
                        ObjCollateralDeprReg."Depreciation Amount" := VarDepreciationValue;
                        ObjCollateralDeprReg."Collateral NBV" := VarCurrentNBV - VarDepreciationValue;
                        ObjCollateralDeprReg.Insert;
                    end;
                    //=============End of Update Year 6 Depreciation==========================
                end;
            }
            action("Depreciation Schedule")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Collateral Depr. Schedule";
                RunPageLink = "Document No" = field("Document No");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FnGetVisibility();
    end;

    var
        ObjCollateralDeprReg: Record "Collateral Depr Register";
        ObjCollateralDetails: Record "Loan Collateral Details";
        VarNoofYears: Integer;
        VarDepreciationValue: Decimal;
        ObjDepreciationRegister: Record "Collateral Depr Register";
        VarDepreciationNo: Integer;
        ObjDeprCollateralMaster: Record "Collateral Depr Register";
        VarCurrentNBV: Decimal;
        ReceivedAtHQVisible: Boolean;
        StrongRoomVisible: Boolean;
        LawyerVisible: Boolean;
        InsuranceAgentVisible: Boolean;
        BranchVisible: Boolean;
        IssuetoMemberVisible: Boolean;
        IssuetoAuctioneerVisible: Boolean;
        SafeCustodyVisible: Boolean;

    local procedure FnGetVisibility()
    begin
        if Rec.Action = Rec.Action::"Receive at HQ" then begin
            ReceivedAtHQVisible := true;
        end;
        if (Rec.Action = Rec.Action::"Dispatch to Branch") or (Rec.Action = Rec.Action::"Receive at Branch") then begin
            BranchVisible := true;
        end;
        if (Rec.Action = Rec.Action::"Issue to Lawyer") or (Rec.Action = Rec.Action::"Receive From Lawyer") then begin
            LawyerVisible := true;
        end;
        if Rec.Action = Rec.Action::"Issue to Auctioneer" then begin
            IssuetoAuctioneerVisible := true;
        end;
        if Rec.Action = Rec.Action::"Issue to Insurance Agent" then begin
            InsuranceAgentVisible := true;
        end;
        if Rec.Action = Rec.Action::"Release to Member" then begin
            IssuetoMemberVisible := true;
        end;
        if Rec.Action = Rec.Action::"Retrieve From Strong Room" then begin
            SafeCustodyVisible := true;
        end;
    end;
}

