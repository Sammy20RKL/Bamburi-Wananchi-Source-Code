#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50204 "HR Transport Alloc. Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Transport Allocations H";

    layout
    {
        area(content)
        {
            group(Control1000000017)
            {
                field("Transport Allocation No"; Rec."Transport Allocation No")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Allocation"; Rec."Date of Allocation")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Trip"; Rec."Date of Trip")
                {
                    ApplicationArea = Basic;
                }
                field("Purpose of Trip"; Rec."Purpose of Trip")
                {
                    ApplicationArea = Basic;
                }
                field("Vehicle Reg Number"; Rec."Vehicle Reg Number")
                {
                    ApplicationArea = Basic;
                }
                field("Passenger Capacity"; Rec."Passenger Capacity")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination(s)"; Rec."Destination(s)")
                {
                    ApplicationArea = Basic;
                }
                field("Journey Route"; Rec."Journey Route")
                {
                    ApplicationArea = Basic;
                }
                field("Time of Trip"; Rec."Time of Trip")
                {
                    ApplicationArea = Basic;
                }
                field("Opening Odometer Reading"; Rec."Opening Odometer Reading")
                {
                    ApplicationArea = Basic;
                }
                field("Time out"; Rec."Time out")
                {
                    ApplicationArea = Basic;
                }
                field("Closing Odometer Reading"; Rec."Closing Odometer Reading")
                {
                    ApplicationArea = Basic;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

