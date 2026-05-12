#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56033 "Loan Products Setup Card"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Products Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Charge Interest Upfront"; Rec."Charge Interest Upfront")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    begin
                        if Rec."Charge Interest Upfront" = true then Error('Load All Loan Interest MUST be false');
                        if Rec.Source <> Rec.Source::FOSA then Error('Only FOSA Products Apply');
                    end;
                }
                // field("Load All Loan Interest"; Rec.intere "Load All Loan Interest")
                // {
                //     ApplicationArea = Basic;
                //     trigger OnValidate()
                //     begin
                //         if Rec."Charge Interest Upfront" = true then Error('Charge Interest Upfront MUST be false');
                //         if Rec.Source <> Rec.Source::FOSA then Error('Only FOSA Products Apply');
                //     end;
                // }
                field("Interest rate"; Rec."Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate-Outstanding >1.5"; Rec."Interest Rate-Outstanding >1.5")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Rate-Total Outstanding above 1.5 M';
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Principle (M)"; Rec."Grace Period - Principle (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Interest (M)"; Rec."Grace Period - Interest (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Use Cycles"; Rec."Use Cycles")
                {
                    ApplicationArea = Basic;
                }

                field("Instalment Period"; Rec."Instalment Period")
                {
                    ApplicationArea = Basic;
                }
                field("No of Installment"; Rec."No of Installment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Maximum Instalments';
                }
                field("Default Installements"; Rec."Default Installements")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Calculation Days"; Rec."Penalty Calculation Days")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Percentage"; Rec."Penalty Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ApplicationArea = Basic;
                }
                field("Min No. Of Guarantors"; Rec."Min No. Of Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Min Re-application Period"; Rec."Min Re-application Period")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Multiplier"; Rec."Shares Multiplier")
                {
                    ApplicationArea = Basic;
                    Caption = 'BOSA Deposits Multiplier';
                }
                field("Penalty Calculation Method"; Rec."Penalty Calculation Method")
                {
                    ApplicationArea = Basic;
                }
                field("Self guaranteed Multiplier"; Rec."Self guaranteed Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Expiry Date"; Rec."Loan Product Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Paid Account"; Rec."Penalty Paid Account")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Charged Account"; Rec."Penalty Charged Account")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Loan Amount"; Rec."Min. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Loan Amount"; Rec."Max. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Recovery"; Rec."Check Off Recovery")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Account"; Rec."Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Account"; Rec."Loan Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Receivable Interest Account"; Rec."Receivable Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Receivable Insurance Accounts"; Rec."Receivable Insurance Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Multiple Running Loans"; Rec."Allow Multiple Running Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Commision Account"; Rec."Top Up Commision Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Levy on Bridging Loans Account';
                }
                field("Top Up Commision"; Rec."Top Up Commision")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bridging Levy %';
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Deposits Multiplier"; Rec."Deposits Multiplier")
                {
                    ApplicationArea = Basic;
                }
                // field("Sacco Deposits"; Rec."Sacco Deposits")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Pepea Deposits"; Rec."Pepea Deposits")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Dont Recover Repayment"; Rec."Dont Recover Repayment")
                {
                    ApplicationArea = Basic;
                }
                // field("Post to Deposits"; Rec."Post to Deposits")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Share Cap %"; Rec."Share Cap %")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Max Share Cap"; Rec."Max Share Cap")
                // {
                //     ApplicationArea = Basic;
                // }

                // field("Loan Bank Account"; Rec."Loan Bank Account")
                // {
                //     ApplicationArea = Basic;
                // }
            }
            group("Qualification Criteria")
            {
                Caption = 'Qualification Criteria';
                field("Appraise Deposits"; Rec."Appraise Deposits")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits';
                }
                field("Appraise Shares"; Rec."Appraise Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Shares';
                }
                field("Appraise Salary"; Rec."Appraise Salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary';
                }
                field("Appraise Guarantors"; Rec."Appraise Guarantors")
                {
                    ApplicationArea = Basic;
                }
                // field("Appraise Business"; Rec."Appraise Business")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Appraise Dividend"; Rec."Appraise Dividend")
                {
                    ApplicationArea = Basic;
                }
                field("Requires Loan Offset"; Rec."Requires Loan Offset")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Collateral"; Rec."Appraise Collateral")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Product)
            {
                Caption = 'Product';
                action("Product Charges")
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Charges';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charges";
                    RunPageLink = "Product Code" = field(Code);
                }
            }
        }
    }
}

