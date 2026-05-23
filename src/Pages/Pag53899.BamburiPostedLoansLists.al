
page 53899 "Bamburi  Posted Loans Lists"
{
    ApplicationArea = All;
    Caption = 'Posted Loans Details';
    PageType = List;
    DeleteAllowed = false;
    SourceTable = "Loans Register";
    SourceTableView = where("Outstanding Balance" = filter(> 0));
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control1000000000)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                }

                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Unfavorable;
                }

                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Unfavorable;
                }


                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Installments';
                    Editable = false;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Months in Arrears"; Rec."No of Months in Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Deduct Checkoff"; Rec."Deduct Checkoff")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        ExistingLoan: Record "Loans Register";
                    begin
                        if Rec."Deduct Checkoff" then begin
                            ExistingLoan.Reset();
                            ExistingLoan.SetRange("Client Code", Rec."Client Code");
                            ExistingLoan.SetRange("Loan Product Type", Rec."Loan Product Type");
                            ExistingLoan.SetRange("Deduct Checkoff", true);
                            ExistingLoan.SetFilter("Loan  No.", '<>%1', Rec."Loan  No.");
                            ExistingLoan.SetFilter("Outstanding Balance", '>%1', 0);

                            if ExistingLoan.FindFirst() then
                                Error('Client %1 already has Deduct Checkoff enabled on Loan No. %2 under Product Type [%3]. You cannot enable it on multiple loans of the same product.',
                                    Rec."Client Code",
                                    ExistingLoan."Loan  No.",
                                    Rec."Loan Product Type");
                        end;
                    end;
                }
                field("Run Interest"; Rec."Run Interest")
                {
                    ApplicationArea = Basic;
                    // field("Deduct Checkoff"; Rec."Deduct Checkoff")
                    // {
                    //     ApplicationArea = Basic;
                    //     trigger OnValidate()
                    //     var
                    //         ExistingLoan: Record "Loans Register";
                    //     begin
                    //         if Rec."Deduct Checkoff" then begin
                    //             ExistingLoan.Reset();
                    //             ExistingLoan.SetRange("Client Code", Rec."Client Code");
                    //             ExistingLoan.SetRange("Loan Product Type", Rec."Loan Product Type");
                    //             ExistingLoan.SetRange("Deduct Checkoff", true);
                    //             ExistingLoan.SetFilter("Loan  No.", '<>%1', Rec."Loan  No.");
                    //             ExistingLoan.SetFilter("Outstanding Balance", '>%1', 0);

                    //             if ExistingLoan.FindFirst() then
                    //                 Error('Client %1 already has Deduct Checkoff enabled on Loan No. %2 under Product Type [%3]. You cannot enable it on multiple loans of the same product.',
                    //                     Rec."Client Code",
                    //                     ExistingLoan."Loan  No.",
                    //                     Rec."Loan Product Type");
                    //         end;
                    //     end;
                    // }
                    // field("Run Interest"; Rec."Run Interest")
                    // {
                    //     ApplicationArea = Basic;

                    // }
                    // field(Cleard; Rec.Cleard)
                    // {
                    //     ApplicationArea = Basic;
                    // }
                }
            }
        }
    }
}