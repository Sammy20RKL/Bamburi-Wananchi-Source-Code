Page 50134 "Dividends Processing Flat Rate"
{
    ApplicationArea = All;
    Caption = 'Dividends Processing Flat Rate-List';
    PageType = List;
    SourceTable = "Dividends Register Flat Rate";
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                }
                field("Dividend Year"; Rec."Dividend Year")
                {
                }
                field("Current Shares"; Rec."Current Shares")
                {
                }
                field("Qualifying Current Shares"; Rec."Qualifying Current Shares")
                {
                }
                field("Gross Interest -Current Shares"; Rec."Gross Interest -Current Shares")
                {
                }
                field("WTX -Current Shares"; Rec."WTX -Current Shares")
                {
                }
                field("Net Interest -Current Shares"; Rec."Net Interest -Current Shares")
                {
                }
                field("FOSA Shares"; Rec."FOSA Shares")
                {
                }
                field("Qualifying FOSA Shares"; Rec."Qualifying FOSA Shares")
                {
                }
                field("Gross Interest -FOSA Shares"; Rec."Gross Interest -FOSA Shares")
                {
                }
                field("WTX -FOSA Shares"; Rec."WTX -FOSA Shares")
                {
                }
                field("Net Interest -FOSA Shares"; Rec."Net Interest -FOSA Shares")
                {
                }
                //...
                field("Computer Shares"; Rec."Computer Shares")
                {
                }
                field("Qualifying Computer Shares"; Rec."Qualifying Computer Shares")
                {
                }
                field("Gross Interest-Computer Shares"; Rec."Gross Interest-Computer Shares")
                {
                }
                field("WTX -Computer Shares"; Rec."WTX -Computer Shares")
                {
                }
                field("Net Interest -Computer Shares"; Rec."Net Interest -Computer Shares")
                {
                }
                //--
                field("Van Shares"; Rec."Van Shares")
                {
                }
                field("Qualifying Van Shares"; Rec."Qualifying Van Shares")
                {
                }
                field("Gross Interest-Van Shares"; Rec."Gross Interest-Van Shares")
                {
                }
                field("WTX -Van Shares"; Rec."WTX -Van Shares")
                {
                }
                field("Net Interest -Van Shares"; Rec."Net Interest -Van Shares")
                {
                }
                //--
                field("Preferential Shares"; Rec."Preferential Shares")
                {
                }
                field("Qualifying Preferential Shares"; Rec."Qualifying Preferential Shares")
                {
                }
                field("Gross Interest-Preferential Shares"; Rec."Gross Int-Preferential Shares")
                {
                }
                field("WTX -Preferential Shares"; Rec."WTX -Preferential Shares")
                {
                }
                field("Net Int-Preferential Shares"; Rec."Net Int-Preferential Shares")
                {
                }
                //--
                field("Lift Shares"; Rec."Lift Shares")
                {
                }
                field("Qualifying Lift Shares"; Rec."Qualifying Lift Shares")
                {
                }
                field("Gross Interest-Lift Shares"; Rec."Gross Int-Lift Shares")
                {
                }
                field("WTX -Lift Shares"; Rec."WTX -Van Shares")
                {
                }
                field("Net Interest -Lift Shares"; Rec."Net Int-Lift Shares")
                {
                }
                //...
                field("Tambaa Shares"; Rec."Tambaa Shares")
                {
                }
                field("Qualifying Tambaa Shares"; Rec."Qualifying Tambaa Shares")
                {
                }
                field("Gross Interest-Tambaa Shares"; Rec."Gross Int-Tambaa Shares")
                {
                }
                field("WTX -Tambaa Shares"; Rec."WTX -Tambaa Shares")
                {
                }
                field("Net Interest -Tambaa Shares"; Rec."Net Int-Tambaa Shares")
                {
                }
                //--
                field("Pepea Shares"; Rec."Pepea Shares")
                {
                }
                field("Qualifying Pepea Shares"; Rec."Qualifying Pepea Shares")
                {
                }
                field("Gross Interest-Pepea Shares"; Rec."Gross Int-Pepea Shares")
                {
                }
                field("WTX -Pepea Shares"; Rec."WTX -Pepea Shares")
                {
                }
                field("Net Interest -Pepea Shares"; Rec."Net Int-Pepea Shares")
                {
                }
                //--
                field("Housing Shares"; Rec."Housing Shares")
                {
                }
                field("Qualifying Housing Shares"; Rec."Qualifying Housing Shares")
                {
                }
                field("Gross Interest-Housing Shares"; Rec."Gross Int-Housing Shares")
                {
                }
                field("WTX -Housing Shares"; Rec."WTX -Housing Shares")
                {
                }
                field("Net Interest -Housing Shares"; Rec."Net Int-Housing Shares")
                {
                }
            }
        }
    }
}
