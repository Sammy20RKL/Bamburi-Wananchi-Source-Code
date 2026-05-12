#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50994 "Individual Member Risk Rating"
{
    PageType = Card;
    SourceTable = "Individual Customer Risk Rate";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("What is the Customer Category?"; Rec."What is the Customer Category?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Score)
                {
                    Caption = 'Score';
                    GridLayout = Rows;
                    group(Control6)
                    {
                        field("Customer Category Score"; Rec."Customer Category Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control7)
            {
                field("What is the Member residency?"; Rec."What is the Member residency?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control12)
                {
                    GridLayout = Rows;
                    group(Control11)
                    {
                        field("Member Residency Score"; Rec."Member Residency Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control16)
            {
                field("Cust Employment Risk?"; Rec."Cust Employment Risk?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control14)
                {
                    GridLayout = Rows;
                    group(Control13)
                    {
                        field("Cust Employment Risk Score"; Rec."Cust Employment Risk Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control21)
            {
                field("Cust Business Risk Industry?"; Rec."Cust Business Risk Industry?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control19)
                {
                    GridLayout = Rows;
                    group(Control18)
                    {
                        field("Cust Bus. Risk Industry Score"; Rec."Cust Bus. Risk Industry Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control26)
            {
                field("Lenght Of Relationship?"; Rec."Lenght Of Relationship?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control24)
                {
                    GridLayout = Rows;
                    group(Control23)
                    {
                        field("Length Of Relation Score"; Rec."Length Of Relation Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control31)
            {
                field("Cust Involved in Intern. Trade"; Rec."Cust Involved in Intern. Trade")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control29)
                {
                    GridLayout = Rows;
                    group(Control28)
                    {
                        field("Involve in Inter. Trade Score"; Rec."Involve in Inter. Trade Score")
                        {
                            ApplicationArea = Basic;
                            CaptionClass = InternationalTrade;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control61)
            {
                // field("Member Referee Rate"; Rec."Member Referee Rate")
                // {
                //     ApplicationArea = Basic;
                // }
                grid(Control59)
                {
                    GridLayout = Rows;
                    group(Control58)
                    {
                        // field("Referee Score"; Rec."Referee Score")
                        // {
                        //     ApplicationArea = Basic;
                        //     ShowCaption = false;
                        // }
                    }
                }
            }
            group(Control36)
            {
                field("Account Type Taken?"; Rec."Account Type Taken?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control34)
                {
                    GridLayout = Rows;
                    group(Control33)
                    {
                        field("Account Type Taken Score"; Rec."Account Type Taken Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control41)
            {
                field("Card Type Taken"; Rec."Card Type Taken")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control39)
                {
                    GridLayout = Rows;
                    group(Control38)
                    {
                        field("Card Type Taken Score"; Rec."Card Type Taken Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control46)
            {
                field("Channel Taken?"; Rec."Channel Taken?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control44)
                {
                    GridLayout = Rows;
                    group(Control43)
                    {
                        field("Channel Taken Score"; Rec."Channel Taken Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control51)
            {
                field("Electronic Payments?"; Rec."Electronic Payments?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control49)
                {
                    GridLayout = Rows;
                    group(Control48)
                    {
                        field("Electronic Payments Score"; Rec."Electronic Payments Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group("Member Summary")
            {
                Caption = 'Member Summary';
                field("GROSS CUSTOMER AML RISK RATING"; Rec."GROSS CUSTOMER AML RISK RATING")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("BANK'S CONTROL RISK RATING"; Rec."BANK'S CONTROL RISK RATING")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("CUSTOMER NET RISK RATING"; Rec."CUSTOMER NET RISK RATING")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Risk Rate Scale"; Rec."Risk Rate Scale")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        InternationalTrade: label 'Involved In International Trade Score';
}

