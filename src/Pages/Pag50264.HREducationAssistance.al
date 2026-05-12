#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50264 "HR Education Assistance"
{
    PageType = Document;
    SourceTable = "HR Education Assistance";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee First Name"; Rec."Employee First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Last Name"; Rec."Employee Last Name")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Details)
            {
                field("Year Of Study"; Rec."Year Of Study")
                {
                    ApplicationArea = Basic;
                }
                field("Study Period"; Rec."Study Period")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = Basic;
                }
                field("Student Number"; Rec."Student Number")
                {
                    ApplicationArea = Basic;
                }
                field("Type Of Institution"; Rec."Type Of Institution")
                {
                    ApplicationArea = Basic;
                }
                field("Enrollment Fee"; Rec."Enrollment Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = Basic;
                }
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = Basic;
                }
                field("Refund Level"; Rec."Refund Level")
                {
                    ApplicationArea = Basic;
                }
                field("Educational Institution"; Rec."Educational Institution")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Subjects Registered")
            {
                fixed(Control1102755054)
                {
                    group(Subjects)
                    {
                        field("Subject Registered1"; Rec."Subject Registered1")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Subject Registered2"; Rec."Subject Registered2")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Subject Registered3"; Rec."Subject Registered3")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Subject Registered4"; Rec."Subject Registered4")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Subject Registered5"; Rec."Subject Registered5")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Subject Registered6"; Rec."Subject Registered6")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Cost Of Subject")
                    {
                        field("Cost Of Subject1"; Rec."Cost Of Subject1")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Cost Of Subject2"; Rec."Cost Of Subject2")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Cost Of Subject3"; Rec."Cost Of Subject3")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Cost Of Subject4"; Rec."Cost Of Subject4")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Cost Of Subject5"; Rec."Cost Of Subject5")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Cost Of Subject6"; Rec."Cost Of Subject6")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Cost Of Books")
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Columns;
                        field("Book Cost Subject1"; Rec."Book Cost Subject1")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Book Cost Subject2"; Rec."Book Cost Subject2")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Book Cost Subject3"; Rec."Book Cost Subject3")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Book Cost Subject4"; Rec."Book Cost Subject4")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Book Cost Subject5"; Rec."Book Cost Subject5")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Book Cost Subject6"; Rec."Book Cost Subject6")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Education Credits")
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Columns;
                        field("Education Credits1"; Rec."Education Credits1")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Education Credits2"; Rec."Education Credits2")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Education Credits3"; Rec."Education Credits3")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Education Credits4"; Rec."Education Credits4")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Education Credits5"; Rec."Education Credits5")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Education Credits6"; Rec."Education Credits6")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Training Credits")
                    {
                        field("Training Credits1"; Rec."Training Credits1")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Training Credits2"; Rec."Training Credits2")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Training Credits3"; Rec."Training Credits3")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Training Credits4"; Rec."Training Credits4")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Training Credits5"; Rec."Training Credits5")
                        {
                            ApplicationArea = Basic;
                        }
                        field("<Training Credits6>"; Rec."Training Credits6")
                        {
                            ApplicationArea = Basic;
                            Caption = '<Training Credits6>';
                        }
                    }
                }
            }
            group("Subjects Results")
            {
                fixed(Control1102755057)
                {
                    group("Subjects& Results")
                    {
                        field(Subject1; Rec."Subject Registered1")
                        {
                            ApplicationArea = Basic;
                        }
                        field(Subject2; Rec."Subject Registered2")
                        {
                            ApplicationArea = Basic;
                        }
                        field(Subject3; Rec."Subject Registered3")
                        {
                            ApplicationArea = Basic;
                        }
                        field(Subject4; Rec."Subject Registered4")
                        {
                            ApplicationArea = Basic;
                        }
                        field(Subject5; Rec."Subject Registered5")
                        {
                            ApplicationArea = Basic;
                        }
                        field(Subject6; Rec."Subject Registered6")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Date Completed")
                    {
                        field("Date Completed1"; Rec."Date Completed1")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Date Completed2"; Rec."Date Completed2")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Date Completed3"; Rec."Date Completed3")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Date Completed4"; Rec."Date Completed4")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Date Completed5"; Rec."Date Completed5")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Date Completed6"; Rec."Date Completed6")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group(Control1102755072)
                    {
                        field(CompletedResult1; Rec.CompletedResult1)
                        {
                            ApplicationArea = Basic;
                        }
                        field(CompletedResult2; Rec.CompletedResult2)
                        {
                            ApplicationArea = Basic;
                        }
                        field(CompletedResult3; Rec.CompletedResult3)
                        {
                            ApplicationArea = Basic;
                        }
                        field(CompletedResult4; Rec.CompletedResult4)
                        {
                            ApplicationArea = Basic;
                        }
                        field(CompletedResult5; Rec.CompletedResult5)
                        {
                            ApplicationArea = Basic;
                        }
                        field(CompletedResult6; Rec.CompletedResult6)
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Rewrite Date")
                    {
                        field("Date Rewrite1"; Rec."Date Rewrite1")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Date Rewrite2"; Rec."Date Rewrite2")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Date Rewrite3"; Rec."Date Rewrite3")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Date Rewrite4"; Rec."Date Rewrite4")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Date Rewrite5"; Rec."Date Rewrite5")
                        {
                            ApplicationArea = Basic;
                        }
                        field("Date Rewrite6"; Rec."Date Rewrite6")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group(Control1102755086)
                    {
                        field(RewriteResult1; Rec.RewriteResult1)
                        {
                            ApplicationArea = Basic;
                        }
                        field(RewriteResult2; Rec.RewriteResult2)
                        {
                            ApplicationArea = Basic;
                        }
                        field(RewriteResult3; Rec.RewriteResult3)
                        {
                            ApplicationArea = Basic;
                        }
                        field(RewriteResult4; Rec.RewriteResult4)
                        {
                            ApplicationArea = Basic;
                        }
                        field(RewriteResult5; Rec.RewriteResult5)
                        {
                            ApplicationArea = Basic;
                        }
                        field(RewriteResult6; Rec.RewriteResult6)
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group(Refunded)
                    {
                        field(Refunded1; Rec.Refunded1)
                        {
                            ApplicationArea = Basic;
                        }
                        field(Refunded2; Rec.Refunded2)
                        {
                            ApplicationArea = Basic;
                        }
                        field(Refunded3; Rec.Refunded3)
                        {
                            ApplicationArea = Basic;
                        }
                        field(Refunded4; Rec.Refunded4)
                        {
                            ApplicationArea = Basic;
                        }
                        field(Refunded5; Rec.Refunded5)
                        {
                            ApplicationArea = Basic;
                        }
                        field(Refunded6; Rec.Refunded6)
                        {
                            ApplicationArea = Basic;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }
}

