// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 56700 "Dividends Processing Codeunit"
// {

//     trigger OnRun()
//     begin
//         //FnGetTheDivTotalPayable('1001');
//     end;

//     var
//         Deposits: Decimal;
//         ShareCapital: Decimal;
//         MemberExitedTable: Record "Membership Exit";
//         DivProg: Record "Dividends Progression";
//         DivTotal: Decimal;
//         "W/Tax": Decimal;
//         CommDiv: Decimal;
//         chargge: Decimal;
//         GenSetUp: Record "Sacco General Set-Up";
//         BDate: Date;
//         FromDate: Date;
//         ToDate: Date;
//         FromDateS: Text;
//         ToDateS: Text;
//         DateFilter: Text;
//         CDiv: Decimal;
//         CInterest: Decimal;
//         Accountclosedon: Date;
//         PayableAmount: Decimal;
//         Amountss: Decimal;
//         DivProgressionTable: Record "Dividends Progression";
//         GrossTotalDiv: Decimal;
//         LineNo: Integer;
//         SFactory: Codeunit "SWIZZSFT Factory";
//         GenJournalLine: Record "Gen. Journal Line";
//         GrossDivOnShares: Decimal;
//         TotalWhtax: Decimal;
//         chargges: Decimal;
//         YearCalc: Text;
//         NetPayableAmount: Decimal;
//         NetPayableAmountFinal: Decimal;
//         ExtraCharge1: Decimal;
//         ExtraCharge2: Decimal;
//         ExtraCharge3: Decimal;
//         LastDateOfTheDividendYear: Date;
//         MembersReg2: Record Customer;


//     procedure FnAnalyseMemberCategory(MemberNo: Code[30]; StartDate: Date; PostingDate: Date)
//     var
//         MembersReg: Record Customer;
//     begin
//         //ERROR(FORMAT(StartDate));
//         //.......................................Get the last day of the year from startdate
//         //20223112D
//         LastDateOfTheDividendYear := 0D;
//         LastDateOfTheDividendYear := CalcDate('<CY>', StartDate);
//         //ERROR(FORMAT(LastDateOfTheDividendYear));
//         //..................................................................................
//         DivProg.Reset;
//         DivProg.SetCurrentkey("Member No");
//         DivProg.SetRange(DivProg."Member No", MemberNo);
//         if DivProg.Find('-') then begin
//             DivProg.DeleteAll;
//         end;
//         //...............................
//         MembersReg2.Reset;
//         MembersReg2.SetRange(MembersReg2."No.", MemberNo);
//         if MembersReg2.Find('-') then begin
//             MembersReg2."Gross Dividend Amount Payable" := 0;
//             ;
//             MembersReg2."Gross Div on share Capital" := 0;
//             MembersReg2."Gross Int On Deposits" := 0;
//             MembersReg2."Bank Charges on processings" := 0;
//             MembersReg2."WithholdingTax on gross div" := 0;
//             MembersReg2.Modify;
//         end;
//         //...............................
//         MembersReg.Reset;
//         MembersReg.SetRange(MembersReg."No.", MemberNo);
//         MembersReg.SetAutocalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//         MembersReg.SetFilter(MembersReg."Shares Retained", '>%1', 0);
//         if MembersReg.Find('-') then begin
//             Deposits := 0;
//             ShareCapital := 0;
//             DivProg.Reset;
//             DivProg.SetCurrentkey("Member No");
//             DivProg.SetRange(DivProg."Member No", MemberNo);
//             if DivProg.Find('-') then begin
//                 DivProg.DeleteAll;
//             end;
//             if MembersReg.Status = MembersReg.Status::Withdrawal then begin
//                 //.......Update dividends reg for withdrawn members//1073
//                 Deposits := MembersReg."Current Shares";
//                 ShareCapital := MembersReg."Shares Retained";
//                 MembersReg."Dividend Amount" := 0;

//                 DivProg.Reset;
//                 DivProg.SetCurrentkey("Member No");
//                 DivProg.SetRange(DivProg."Member No", MemberNo);
//                 if DivProg.Find('-') then begin
//                     DivProg.DeleteAll;
//                 end;

//                 DivTotal := 0;
//                 "W/Tax" := 0;
//                 CommDiv := 0;
//                 chargge := 0;
//                 GenSetUp.Get();
//                 //.................................START ON COMPUTATION
//                 //1)Find account closure date
//                 MemberExitedTable.Reset;
//                 MemberExitedTable.SetRange(MemberExitedTable."Member No.", MemberNo);
//                 if MemberExitedTable.FindLast then begin
//                     Accountclosedon := MemberExitedTable."Closing Date";
//                     //ERROR(FORMAT(Accountclosedon));
//                     if Accountclosedon < LastDateOfTheDividendYear then begin
//                         //Continue without accounting for interest on deposits
//                         //FnDontAccountForWithdrwnMemberInt();
//                         //ERROR('HERE %1',ShareCapital);
//                         //................................................Condition 1 start
//                         //2)calculate evrything til account closure date
//                         //IstMonth START
//                         Evaluate(BDate, '01/01/05');
//                         FromDate := BDate;
//                         ToDate := CalcDate('-1D', StartDate);
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", '%1..%2', FromDate, CalcDate('CY', StartDate));
//                         if MembersReg.Find('-') then begin
//                             Evaluate(BDate, '01/01/05');
//                             FromDate := BDate;
//                             ToDate := CalcDate('-1D', StartDate);
//                             Evaluate(FromDateS, Format(FromDate));
//                             Evaluate(ToDateS, Format(ToDate));
//                             DateFilter := FromDateS + '..' + ToDateS;
//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................
//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 // CInterest:=(((GenSetUp."Interest on Deposits (%)"/100)*((MembersReg."Shares Retained")))*(12/12));
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (12 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 //DivProg."Gross Interest On Deposit":=CInterest;
//                                 //MESSAGE('%1',CInterest);
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (12 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (12 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //.iST MONTH END
//                         //2nd month start
//                         FromDate := StartDate;
//                         ToDate := CalcDate('-1D', CalcDate('1M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));
//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (11 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 //DivProg."Gross Interest On Deposit":=CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (11 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (11 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //2end
//                         //.........................3 start
//                         FromDate := CalcDate('1M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('2M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (10 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 // DivProg."Gross Interest On Deposit":=CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (10 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (10 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //..............................3 stop
//                         //.................4 START
//                         FromDate := CalcDate('2M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('3M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (9 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (9 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (9 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //......................4 END
//                         /////////////////////5 START
//                         FromDate := CalcDate('3M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('4M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (8 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (8 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (8 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //....................5 END;
//                         //........6 START
//                         FromDate := CalcDate('4M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('5M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (7 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (7 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (7 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //........6 END
//                         //...........7 SART
//                         FromDate := CalcDate('5M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('6M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (6 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (6 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (6 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //................7 END
//                         //.....8 START
//                         FromDate := CalcDate('6M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('7M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (5 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (5 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (5 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //.......8 END
//                         //9 START
//                         FromDate := CalcDate('7M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('8M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (4 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (4 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (4 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //.9 END
//                         //10 START
//                         FromDate := CalcDate('8M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('9M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (3 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (3 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (3 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //10 END
//                         //..11 START
//                         FromDate := CalcDate('9M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('10M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (2 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (2 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (2 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //.11 END
//                         //12 START
//                         FromDate := CalcDate('10M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('11M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 CInterest := 0;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (1 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (1 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (1 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //12 END
//                         //....................get the sum amounts
//                         //2030
//                         //.................................................Pass GL START
//                         PayableAmount := 0;
//                         PayableAmount := FnGetTheDivTotalPayable(MemberNo);//Net Amount Paybale to member
//                         GrossTotalDiv := 0;
//                         GrossTotalDiv := FnGetTheGrossDivPayable(MemberNo);
//                         GrossDivOnShares := 0;
//                         GrossDivOnShares := (FnGetTheGrossDivOnSharesPayable(MemberNo));
//                         TotalWhtax := 0;
//                         TotalWhtax := FnGetTotalWhtax(MemberNo);
//                         NetPayableAmount := 0;
//                         NetPayableAmount := FnGetTheNetPayable(MemberNo);
//                         //ERROR();
//                         // //------------------------------------1. CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits---------------------------------------
//                         LineNo := LineNo + 10000;
//                         SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                         GenJournalLine."account type"::Customer, MemberNo, PostingDate, GrossTotalDiv * -1, 'BOSA', '',
//                         'Gross Dividend+Interest on Deposits- ' + Format(PostingDate), '');

//                         // //-------------------------------------
//                         // //------------------------------------1.1 DEBIT DIVIVIDEND PAYABLE GL A/C----------------------------------------------------------------------
//                         LineNo := LineNo + 10000;
//                         GenSetUp.Get();
//                         SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                         GenJournalLine."account type"::"G/L Account", GenSetUp."Dividend Payable Account", PostingDate, GrossTotalDiv, 'BOSA', '',
//                         'Gross Dividend+Interest on Deposits- ' + MemberNo, '');
//                         // //----------------------------------(Debit Dividend Payable GL A/C)----------------------------------------------------------------------------
//                         // //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------
//                         LineNo := LineNo + 10000;
//                         GenSetUp.Get();
//                         SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                         GenJournalLine."account type"::"G/L Account", GenSetUp."WithHolding Tax Account", PostingDate, (TotalWhtax) * -1, 'BOSA', '',
//                         'Witholding Tax on Dividend- ' + MemberNo, '');

//                         LineNo := LineNo + 10000;
//                         YearCalc := Format(Date2dmy(StartDate, 3));
//                         SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                         GenJournalLine."account type"::Customer, MemberNo, PostingDate, (TotalWhtax), 'BOSA', '',
//                         'Witholding Tax on Dividend- ' + YearCalc, '');
//                         // //----------------------------------(bank chargr Witholding tax gl a/c)-----------------------------------------------------------------------------
//                         LineNo := LineNo + 10000;
//                         chargges := 0;
//                         NetPayableAmountFinal := 0;
//                         ExtraCharge1 := 0;
//                         YearCalc := Format(Date2dmy(StartDate, 3));
//                         if (GrossTotalDiv) > 100 then begin
//                             chargges := 50;
//                             ExtraCharge1 := chargges;
//                         end
//                         else
//                             if ((GrossTotalDiv) <= 0) then begin
//                                 chargges := 0;
//                                 ExtraCharge1 := chargges;
//                             end;
//                         SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                         GenJournalLine."account type"::Customer, MemberNo, PostingDate, chargges, 'BOSA', '',
//                         'Bank Charge- ' + YearCalc, '');
//                         LineNo := LineNo + 10000;
//                         SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                         GenJournalLine."account type"::"G/L Account", '101410', PostingDate, (chargges) * -1, 'BOSA', '',
//                         ' Bank Charge- ' + YearCalc, '');
//                         // //------------------------------------2.1. charge WITHHOLDING TAX GL A/C-----------------------------------------------------------------------
//                         //------------------------------------3. DEBITORMAT(PostingDate) MEMBER DIVIDEND A/C_PROCESSING FEE--------------------------------------------------------------
//                         LineNo := LineNo + 10000;
//                         GenSetUp.Get();
//                         SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                         GenJournalLine."account type"::Customer, MemberNo, PostingDate, GenSetUp."Dividend Processing Fee", 'BOSA', '',
//                         'Processing Fee- ' + MemberNo, '');
//                         ExtraCharge2 := 0;
//                         ExtraCharge2 := GenSetUp."Dividend Processing Fee";
//                         //--------------------------------(Debit Member Dividend A/C_Processing Fee)-------------------------------------------------------------------
//                         // //------------------------------------3.1. CREDIT PROCESSING FEE INCOME GL A/C-----------------------------------------------------------------
//                         LineNo := LineNo + 10000;
//                         GenSetUp.Get();
//                         SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                         GenJournalLine."account type"::"G/L Account", GenSetUp."Dividend Process Fee Account", PostingDate, GenSetUp."Dividend Processing Fee" * -1, 'BOSA', '',
//                         'Processing Fee- ' + Format(PostingDate), '');
//                         // //-------------------------s---------(Credit Processing Fee income gl a/c)----------------------------------------------------------------------
//                         //
//                         // //------------------------------------4. DEBIT MEMBER DIVIDEND A/C_EXCISE ON PROCESSING FEE----------------------------------------------------
//                         LineNo := LineNo + 10000;
//                         GenSetUp.Get();
//                         SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                         GenJournalLine."account type"::Customer, MemberNo, PostingDate, (GenSetUp."Dividend Processing Fee" * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', '',
//                         'Excise Duty- ' + Format(PostingDate), '');
//                         ExtraCharge3 := 0;
//                         ExtraCharge3 := (GenSetUp."Dividend Processing Fee" * (GenSetUp."Excise Duty(%)" / 100));
//                         //.................................................END PASS GL
//                         // MESSAGE('charge1 %1',ExtraCharge1);
//                         // MESSAGE('charge2 %1',ExtraCharge2);
//                         // ERROR('charge3 %1',ExtraCharge3);
//                         NetPayableAmountFinal := NetPayableAmount - (ExtraCharge1 + ExtraCharge2 + ExtraCharge3);
//                         MembersReg."Dividend Amount" := NetPayableAmountFinal;
//                         MembersReg."Gross Dividend Amount Payable" := GrossTotalDiv;
//                         MembersReg."Gross Div on share Capital" := GrossDivOnShares;
//                         MembersReg."Gross Int On Deposits" := 0;
//                         MembersReg."Bank Charges on processings" := chargges;
//                         MembersReg."WithholdingTax on gross div" := TotalWhtax;
//                         MembersReg.Modify;
//                         //.......
//                         //........
//                         //................................................Condition 1 stop
//                     end
//                     else if Accountclosedon >= LastDateOfTheDividendYear then begin
//                         //Account for interest on deposits
//                         //          FnAccountForWithdrwnMemberInt();
//                         //..............................................................Condition 2 start
//                         Deposits := MembersReg."Current Shares";
//                         ShareCapital := MembersReg."Shares Retained";

//                         MembersReg."Dividend Amount" := 0;

//                         DivProg.Reset;
//                         DivProg.SetCurrentkey("Member No");
//                         DivProg.SetRange(DivProg."Member No", MemberNo);
//                         if DivProg.Find('-') then begin
//                             DivProg.DeleteAll;
//                         end;

//                         DivTotal := 0;
//                         "W/Tax" := 0;
//                         CommDiv := 0;
//                         chargge := 0;
//                         GenSetUp.Get(0);
//                         //............................   //1st Month december previous year
//                         Evaluate(BDate, '01/01/05');
//                         FromDate := BDate;
//                         ToDate := CalcDate('-1D', StartDate);
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", '%1..%2', FromDate, CalcDate('CY', StartDate));
//                         if MembersReg.Find('-') then begin
//                             Evaluate(BDate, '01/01/05');
//                             FromDate := BDate;
//                             ToDate := CalcDate('-1D', StartDate);
//                             Evaluate(FromDateS, Format(FromDate));
//                             Evaluate(ToDateS, Format(ToDate));
//                             DateFilter := FromDateS + '..' + ToDateS;
//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (12 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (12 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (12 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (12 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //............................end first month
//                         //.........................2 start
//                         FromDate := StartDate;
//                         ToDate := CalcDate('-1D', CalcDate('1M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));
//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (11 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (11 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (11 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (11 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //.........................2 end
//                         //.........................3 start
//                         FromDate := CalcDate('1M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('2M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (10 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (10 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (10 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (10 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //..............................3 stop
//                         //.................4 START
//                         FromDate := CalcDate('2M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('3M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (9 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (9 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (9 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (9 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //......................4 END
//                         /////////////////////5 START
//                         FromDate := CalcDate('3M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('4M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (8 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (8 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (8 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (8 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //....................5 END;
//                         //........6 START
//                         FromDate := CalcDate('4M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('5M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (7 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (7 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (7 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (7 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //........6 END
//                         //...........7 SART
//                         FromDate := CalcDate('5M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('6M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (6 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (6 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (6 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (6 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //................7 END
//                         //.....8 START
//                         FromDate := CalcDate('6M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('7M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (5 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (5 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (5 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (5 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //.......8 END
//                         //9 START
//                         FromDate := CalcDate('7M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('8M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (4 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (4 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (4 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (4 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //.9 END
//                         //10 START
//                         FromDate := CalcDate('8M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('9M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (3 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (3 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (3 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (3 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //10 END
//                         //..11 START
//                         FromDate := CalcDate('9M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('10M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (2 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (2 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (2 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (2 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................
//                         end;
//                         //.11 END
//                         //12 START
//                         FromDate := CalcDate('10M', StartDate);
//                         ToDate := CalcDate('-1D', CalcDate('11M', StartDate));
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));

//                         Evaluate(BDate, '01/01/05');

//                         DateFilter := FromDateS + '..' + ToDateS;
//                         if MembersReg.Find('-') then begin

//                             MembersReg.Reset;
//                             MembersReg.SetCurrentkey("No.");
//                             MembersReg.SetRange(MembersReg."No.", MemberNo);
//                             MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                             //.....................

//                             if MembersReg.Find('-') then begin
//                                 MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                                 if (MembersReg."Current Shares" > 0.01) then begin
//                                     CInterest := 0;
//                                     CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (1 / 12));
//                                 end
//                                 else if (MembersReg."Current Shares" < 0.01) then begin
//                                     CInterest := 0;
//                                 end;
//                                 //...
//                                 if (MembersReg."Shares Retained" > 0.01) then begin
//                                     CDiv := 0;
//                                     CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (1 / 12));
//                                 end
//                                 else if (MembersReg."Shares Retained" < 0.01) then begin
//                                     CDiv := 0;
//                                 end;
//                                 //............
//                                 DivTotal := (CDiv + CInterest);
//                                 DivProg.Init;
//                                 DivProg."Member No" := MembersReg."No.";
//                                 DivProg.Date := ToDate;
//                                 DivProg."Gross Dividends" := CDiv;
//                                 DivProg."Gross Interest On Deposit" := CInterest;
//                                 DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (1 / 12);
//                                 DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                                 DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                                 DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (1 / 12);
//                                 DivProg.Shares := MembersReg."Current Shares";
//                                 DivProg."Share Capital" := MembersReg."Shares Retained";
//                                 DivProg.Insert;
//                             end;
//                             //............................

//                             //12 END
//                             PayableAmount := 0;
//                             PayableAmount := FnGetTheDivTotalPayable(MemberNo);//Net Amount Paybale to member
//                             GrossTotalDiv := 0;
//                             GrossTotalDiv := FnGetTheGrossDivPayable(MemberNo);
//                             GrossDivOnShares := 0;
//                             GrossDivOnShares := (FnGetTheGrossDivOnSharesPayable(MemberNo));
//                             TotalWhtax := 0;
//                             TotalWhtax := FnGetTotalWhtax(MemberNo);
//                             NetPayableAmount := 0;
//                             NetPayableAmount := FnGetTheNetPayable(MemberNo);
//                             //.................................................Pass GL START
//                             // //------------------------------------1. CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits---------------------------------------
//                             LineNo := LineNo + 10000;
//                             SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                             GenJournalLine."account type"::Customer, MemberNo, PostingDate, GrossTotalDiv * -1, 'BOSA', '',
//                             'Gross Dividend+Interest on Deposits- ' + Format(PostingDate), '');

//                             // //-------------------------------------
//                             // //------------------------------------1.1 DEBIT DIVIVIDEND PAYABLE GL A/C----------------------------------------------------------------------
//                             LineNo := LineNo + 10000;
//                             GenSetUp.Get();
//                             SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                             GenJournalLine."account type"::"G/L Account", GenSetUp."Dividend Payable Account", PostingDate, GrossTotalDiv, 'BOSA', '',
//                             'Gross Dividend+Interest on Deposits- ' + MemberNo, '');

//                             // //----------------------------------(Debit Dividend Payable GL A/C)----------------------------------------------------------------------------
//                             // //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------
//                             LineNo := LineNo + 10000;
//                             GenSetUp.Get();
//                             SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                             GenJournalLine."account type"::"G/L Account", GenSetUp."WithHolding Tax Account", PostingDate, (TotalWhtax) * -1, 'BOSA', '',
//                             'Witholding Tax on Dividend- ' + MemberNo, '');

//                             LineNo := LineNo + 10000;
//                             YearCalc := Format(Date2dmy(StartDate, 3));
//                             SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                             GenJournalLine."account type"::Customer, MemberNo, PostingDate, (TotalWhtax), 'BOSA', '',
//                             'Witholding Tax on Dividend- ' + YearCalc, '');
//                             // //----------------------------------(bank chargr Witholding tax gl a/c)-----------------------------------------------------------------------------
//                             LineNo := LineNo + 10000;
//                             chargges := 0;
//                             NetPayableAmountFinal := 0;
//                             ExtraCharge1 := 0;
//                             YearCalc := Format(Date2dmy(StartDate, 3));
//                             if ((GrossTotalDiv) > 285) then begin
//                                 chargges := 200;
//                                 ExtraCharge1 := 0;
//                                 ExtraCharge1 := chargges;
//                             end else
//                                 if ((GrossTotalDiv) > 0) and ((GrossTotalDiv) <= 285) then begin
//                                     chargges := 50;
//                                     ExtraCharge1 := 0;
//                                     ExtraCharge1 := chargges;
//                                 end;
//                             SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                             GenJournalLine."account type"::Customer, MemberNo, PostingDate, chargges, 'BOSA', '',
//                             'Bank Charge- ' + YearCalc, '');
//                             LineNo := LineNo + 10000;
//                             SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                            GenJournalLine."account type"::"G/L Account", '101410', PostingDate, (chargges) * -1, 'BOSA', '',
//                            ' Bank Charge- ' + YearCalc, '');
//                             // //------------------------------------2.1. charge WITHHOLDING TAX GL A/C-----------------------------------------------------------------------
//                             //------------------------------------3. DEBITORMAT(PostingDate) MEMBER DIVIDEND A/C_PROCESSING FEE--------------------------------------------------------------
//                             LineNo := LineNo + 10000;
//                             GenSetUp.Get();
//                             SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                             GenJournalLine."account type"::Customer, MemberNo, PostingDate, GenSetUp."Dividend Processing Fee", 'BOSA', '',
//                             'Processing Fee- ' + MemberNo, '');
//                             ExtraCharge2 := 0;
//                             ExtraCharge2 := GenSetUp."Dividend Processing Fee";
//                             //--------------------------------(Debit Member Dividend A/C_Processing Fee)-------------------------------------------------------------------
//                             // //------------------------------------3.1. CREDIT PROCESSING FEE INCOME GL A/C-----------------------------------------------------------------
//                             LineNo := LineNo + 10000;
//                             GenSetUp.Get();
//                             SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                             GenJournalLine."account type"::"G/L Account", GenSetUp."Dividend Process Fee Account", PostingDate, GenSetUp."Dividend Processing Fee" * -1, 'BOSA', '',
//                             'Processing Fee- ' + Format(PostingDate), '');
//                             // //-------------------------s---------(Credit Processing Fee income gl a/c)----------------------------------------------------------------------

//                             // //------------------------------------4. DEBIT MEMBER DIVIDEND A/C_EXCISE ON PROCESSING FEE----------------------------------------------------
//                             LineNo := LineNo + 10000;
//                             GenSetUp.Get();
//                             SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                             GenJournalLine."account type"::Customer, MemberNo, PostingDate, (GenSetUp."Dividend Processing Fee" * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', '',
//                             'Excise Duty- ' + Format(PostingDate), '');
//                             ExtraCharge3 := 0;
//                             ExtraCharge3 := (GenSetUp."Dividend Processing Fee" * (GenSetUp."Excise Duty(%)" / 100));
//                             //.................................................END PASS GL
//                             // MESSAGE('charge1 %1',ExtraCharge1);
//                             // MESSAGE('charge2 %1',ExtraCharge2);
//                             // ERROR('charge3 %1',ExtraCharge3);
//                             NetPayableAmountFinal := NetPayableAmount - (ExtraCharge1 + ExtraCharge2 + ExtraCharge3);
//                             MembersReg."Dividend Amount" := NetPayableAmountFinal;
//                             MembersReg."Gross Dividend Amount Payable" := GrossTotalDiv;
//                             MembersReg."Gross Div on share Capital" := GrossDivOnShares;
//                             MembersReg."Gross Int On Deposits" := GrossTotalDiv - GrossDivOnShares;
//                             MembersReg."Bank Charges on processings" := chargges;
//                             MembersReg."WithholdingTax on gross div" := TotalWhtax;
//                             MembersReg.Modify;
//                         end;
//                         //..............................................................Condition 2 stop
//                     end;
//                 end
//                 else begin
//                     //2)calculate evrything til account closure date
//                     //IstMonth START
//                     Evaluate(BDate, '01/01/05');
//                     FromDate := BDate;
//                     ToDate := CalcDate('-1D', StartDate);
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", '%1..%2', FromDate, CalcDate('CY', StartDate));
//                     if MembersReg.Find('-') then begin
//                         Evaluate(BDate, '01/01/05');
//                         FromDate := BDate;
//                         ToDate := CalcDate('-1D', StartDate);
//                         Evaluate(FromDateS, Format(FromDate));
//                         Evaluate(ToDateS, Format(ToDate));
//                         DateFilter := FromDateS + '..' + ToDateS;
//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................
//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             // CInterest:=(((GenSetUp."Interest on Deposits (%)"/100)*((MembersReg."Shares Retained")))*(12/12));
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (12 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             //DivProg."Gross Interest On Deposit":=CInterest;
//                             //MESSAGE('%1',CInterest);
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (12 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (12 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //.iST MONTH END
//                     //2nd month start
//                     FromDate := StartDate;
//                     ToDate := CalcDate('-1D', CalcDate('1M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));
//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (11 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             //DivProg."Gross Interest On Deposit":=CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (11 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (11 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //2end
//                     //.........................3 start
//                     FromDate := CalcDate('1M', StartDate);
//                     ToDate := CalcDate('-1D', CalcDate('2M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (10 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             // DivProg."Gross Interest On Deposit":=CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (10 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (10 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //..............................3 stop
//                     //.................4 START
//                     FromDate := CalcDate('2M', StartDate);
//                     ToDate := CalcDate('-1D', CalcDate('3M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (9 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             DivProg."Gross Interest On Deposit" := CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (9 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (9 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //......................4 END
//                     /////////////////////5 START
//                     FromDate := CalcDate('3M', StartDate);
//                     ToDate := CalcDate('-1D', CalcDate('4M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (8 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             DivProg."Gross Interest On Deposit" := CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (8 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (8 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //....................5 END;
//                     //........6 START
//                     FromDate := CalcDate('4M', StartDate);
//                     ToDate := CalcDate('-1D', CalcDate('5M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (7 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             DivProg."Gross Interest On Deposit" := CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (7 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (7 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //........6 END
//                     //...........7 SART
//                     FromDate := CalcDate('5M', StartDate);
//                     ToDate := CalcDate('-1D', CalcDate('6M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (6 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             DivProg."Gross Interest On Deposit" := CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (6 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (6 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //................7 END
//                     //.....8 START
//                     FromDate := CalcDate('6M', StartDate);
//                     ToDate := CalcDate('-1D', CalcDate('7M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (5 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             DivProg."Gross Interest On Deposit" := CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (5 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (5 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //.......8 END
//                     //9 START
//                     FromDate := CalcDate('7M', StartDate);
//                     ToDate := CalcDate('-1D', CalcDate('8M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (4 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             DivProg."Gross Interest On Deposit" := CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (4 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (4 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //.9 END
//                     //10 START
//                     FromDate := CalcDate('8M', StartDate);
//                     ToDate := CalcDate('-1D', CalcDate('9M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (3 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             DivProg."Gross Interest On Deposit" := CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (3 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (3 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //10 END
//                     //..11 START
//                     FromDate := CalcDate('9M', StartDate);
//                     ToDate := CalcDate('-1D', CalcDate('10M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (2 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             DivProg."Gross Interest On Deposit" := CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (2 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (2 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //.11 END
//                     //12 START
//                     FromDate := CalcDate('10M', StartDate);
//                     ToDate := CalcDate('-1D', CalcDate('11M', StartDate));
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));

//                     Evaluate(BDate, '01/01/05');

//                     DateFilter := FromDateS + '..' + ToDateS;
//                     if MembersReg.Find('-') then begin

//                         MembersReg.Reset;
//                         MembersReg.SetCurrentkey("No.");
//                         MembersReg.SetRange(MembersReg."No.", MemberNo);
//                         MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                         //.....................

//                         if MembersReg.Find('-') then begin
//                             MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                             CInterest := 0;
//                             //...
//                             if (MembersReg."Shares Retained" > 0.01) then begin
//                                 CDiv := 0;
//                                 CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (1 / 12));
//                             end
//                             else if (MembersReg."Shares Retained" < 0.01) then begin
//                                 CDiv := 0;
//                             end;
//                             //............
//                             DivTotal := (CDiv + CInterest);
//                             DivProg.Init;
//                             DivProg."Member No" := MembersReg."No.";
//                             DivProg.Date := ToDate;
//                             DivProg."Gross Dividends" := CDiv;
//                             DivProg."Gross Interest On Deposit" := CInterest;
//                             DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (1 / 12);
//                             DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                             DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                             DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (1 / 12);
//                             DivProg.Shares := MembersReg."Current Shares";
//                             DivProg."Share Capital" := MembersReg."Shares Retained";
//                             DivProg.Insert;
//                         end;
//                         //............................
//                     end;
//                     //12 END
//                     //....................get the sum amounts
//                     //2030
//                     //.................................................Pass GL START
//                     PayableAmount := 0;
//                     PayableAmount := FnGetTheDivTotalPayable(MemberNo);//Net Amount Paybale to member
//                     GrossTotalDiv := 0;
//                     GrossTotalDiv := FnGetTheGrossDivPayable(MemberNo);
//                     GrossDivOnShares := 0;
//                     GrossDivOnShares := (FnGetTheGrossDivOnSharesPayable(MemberNo));
//                     TotalWhtax := 0;
//                     TotalWhtax := FnGetTotalWhtax(MemberNo);
//                     NetPayableAmount := 0;
//                     NetPayableAmount := FnGetTheNetPayable(MemberNo);
//                     //ERROR();
//                     // //------------------------------------1. CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits---------------------------------------
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                     GenJournalLine."account type"::Customer, MemberNo, PostingDate, GrossTotalDiv * -1, 'BOSA', '',
//                     'Gross Dividend+Interest on Deposits- ' + Format(PostingDate), '');

//                     // //-------------------------------------
//                     // //------------------------------------1.1 DEBIT DIVIVIDEND PAYABLE GL A/C----------------------------------------------------------------------
//                     LineNo := LineNo + 10000;
//                     GenSetUp.Get();
//                     SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::"G/L Account", GenSetUp."Dividend Payable Account", PostingDate, GrossTotalDiv, 'BOSA', '',
//                     'Gross Dividend+Interest on Deposits- ' + MemberNo, '');
//                     // //----------------------------------(Debit Dividend Payable GL A/C)----------------------------------------------------------------------------
//                     // //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------
//                     LineNo := LineNo + 10000;
//                     GenSetUp.Get();
//                     SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::"G/L Account", GenSetUp."WithHolding Tax Account", PostingDate, (TotalWhtax) * -1, 'BOSA', '',
//                     'Witholding Tax on Dividend- ' + MemberNo, '');

//                     LineNo := LineNo + 10000;
//                     YearCalc := Format(Date2dmy(StartDate, 3));
//                     SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                     GenJournalLine."account type"::Customer, MemberNo, PostingDate, (TotalWhtax), 'BOSA', '',
//                     'Witholding Tax on Dividend- ' + YearCalc, '');
//                     // //----------------------------------(bank chargr Witholding tax gl a/c)-----------------------------------------------------------------------------
//                     LineNo := LineNo + 10000;
//                     chargges := 0;
//                     NetPayableAmountFinal := 0;
//                     ExtraCharge1 := 0;
//                     YearCalc := Format(Date2dmy(StartDate, 3));
//                     if (GrossTotalDiv) > 100 then begin
//                         chargges := 50;
//                         ExtraCharge1 := chargges;
//                     end
//                     else
//                         if ((GrossTotalDiv) <= 0) then begin
//                             chargges := 0;
//                             ExtraCharge1 := chargges;
//                         end;
//                     SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                     GenJournalLine."account type"::Customer, MemberNo, PostingDate, chargges, 'BOSA', '',
//                     'Bank Charge- ' + YearCalc, '');
//                     LineNo := LineNo + 10000;
//                     SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                    GenJournalLine."account type"::"G/L Account", '101410', PostingDate, (chargges) * -1, 'BOSA', '',
//                    ' Bank Charge- ' + YearCalc, '');
//                     // //------------------------------------2.1. charge WITHHOLDING TAX GL A/C-----------------------------------------------------------------------
//                     //------------------------------------3. DEBITORMAT(PostingDate) MEMBER DIVIDEND A/C_PROCESSING FEE--------------------------------------------------------------
//                     LineNo := LineNo + 10000;
//                     GenSetUp.Get();
//                     SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                     GenJournalLine."account type"::Customer, MemberNo, PostingDate, GenSetUp."Dividend Processing Fee", 'BOSA', '',
//                     'Processing Fee- ' + MemberNo, '');
//                     ExtraCharge2 := 0;
//                     ExtraCharge2 := GenSetUp."Dividend Processing Fee";
//                     //--------------------------------(Debit Member Dividend A/C_Processing Fee)-------------------------------------------------------------------
//                     // //------------------------------------3.1. CREDIT PROCESSING FEE INCOME GL A/C-----------------------------------------------------------------
//                     LineNo := LineNo + 10000;
//                     GenSetUp.Get();
//                     SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                     GenJournalLine."account type"::"G/L Account", GenSetUp."Dividend Process Fee Account", PostingDate, GenSetUp."Dividend Processing Fee" * -1, 'BOSA', '',
//                     'Processing Fee- ' + Format(PostingDate), '');
//                     // //-------------------------s---------(Credit Processing Fee income gl a/c)----------------------------------------------------------------------
//                     //
//                     // //------------------------------------4. DEBIT MEMBER DIVIDEND A/C_EXCISE ON PROCESSING FEE----------------------------------------------------
//                     LineNo := LineNo + 10000;
//                     GenSetUp.Get();
//                     SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                     GenJournalLine."account type"::Customer, MemberNo, PostingDate, (GenSetUp."Dividend Processing Fee" * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', '',
//                     'Excise Duty- ' + Format(PostingDate), '');
//                     ExtraCharge3 := 0;
//                     ExtraCharge3 := (GenSetUp."Dividend Processing Fee" * (GenSetUp."Excise Duty(%)" / 100));
//                     //.................................................END PASS GL
//                     // MESSAGE('charge1 %1',ExtraCharge1);
//                     // MESSAGE('charge2 %1',ExtraCharge2);
//                     // ERROR('charge3 %1',ExtraCharge3);
//                     NetPayableAmountFinal := NetPayableAmount - (ExtraCharge1 + ExtraCharge2 + ExtraCharge3);
//                     MembersReg."Dividend Amount" := NetPayableAmountFinal;
//                     MembersReg."Gross Dividend Amount Payable" := GrossTotalDiv;
//                     MembersReg."Gross Div on share Capital" := GrossDivOnShares;
//                     MembersReg."Gross Int On Deposits" := 0;
//                     MembersReg."Bank Charges on processings" := chargges;
//                     MembersReg."WithholdingTax on gross div" := TotalWhtax;
//                     MembersReg.Modify;
//                     //.......
//                 end;

//                 //............................................................................
//                 //....................end get sum amounts
//                 //..................................................END 2030

//             end
//             else if MembersReg.Status <> MembersReg.Status::Withdrawal then begin
//                 //Member is not equal to withdrwal
//                 Deposits := MembersReg."Current Shares";
//                 ShareCapital := MembersReg."Shares Retained";

//                 MembersReg."Dividend Amount" := 0;

//                 DivProg.Reset;
//                 DivProg.SetCurrentkey("Member No");
//                 DivProg.SetRange(DivProg."Member No", MemberNo);
//                 if DivProg.Find('-') then begin
//                     DivProg.DeleteAll;
//                 end;

//                 DivTotal := 0;
//                 "W/Tax" := 0;
//                 CommDiv := 0;
//                 chargge := 0;
//                 GenSetUp.Get(0);
//                 //............................   //1st Month december previous year
//                 Evaluate(BDate, '01/01/05');
//                 FromDate := BDate;
//                 ToDate := CalcDate('-1D', StartDate);
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 MembersReg.Reset;
//                 MembersReg.SetCurrentkey("No.");
//                 MembersReg.SetRange(MembersReg."No.", MemberNo);
//                 MembersReg.SetFilter(MembersReg."Date Filter", '%1..%2', FromDate, CalcDate('CY', StartDate));
//                 if MembersReg.Find('-') then begin
//                     Evaluate(BDate, '01/01/05');
//                     FromDate := BDate;
//                     ToDate := CalcDate('-1D', StartDate);
//                     Evaluate(FromDateS, Format(FromDate));
//                     Evaluate(ToDateS, Format(ToDate));
//                     DateFilter := FromDateS + '..' + ToDateS;
//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (12 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (12 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (12 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (12 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //............................end first month
//                 //.........................2 start
//                 FromDate := StartDate;
//                 ToDate := CalcDate('-1D', CalcDate('1M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));
//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (11 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (11 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (11 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (11 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //.........................2 end
//                 //.........................3 start
//                 FromDate := CalcDate('1M', StartDate);
//                 ToDate := CalcDate('-1D', CalcDate('2M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (10 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (10 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (10 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (10 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //..............................3 stop
//                 //.................4 START
//                 FromDate := CalcDate('2M', StartDate);
//                 ToDate := CalcDate('-1D', CalcDate('3M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (9 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (9 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (9 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (9 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //......................4 END
//                 /////////////////////5 START
//                 FromDate := CalcDate('3M', StartDate);
//                 ToDate := CalcDate('-1D', CalcDate('4M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (8 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (8 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (8 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (8 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //....................5 END;
//                 //........6 START
//                 FromDate := CalcDate('4M', StartDate);
//                 ToDate := CalcDate('-1D', CalcDate('5M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (7 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (7 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (7 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (7 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //........6 END
//                 //...........7 SART
//                 FromDate := CalcDate('5M', StartDate);
//                 ToDate := CalcDate('-1D', CalcDate('6M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (6 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (6 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (6 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (6 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //................7 END
//                 //.....8 START
//                 FromDate := CalcDate('6M', StartDate);
//                 ToDate := CalcDate('-1D', CalcDate('7M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (5 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (5 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (5 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (5 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //.......8 END
//                 //9 START
//                 FromDate := CalcDate('7M', StartDate);
//                 ToDate := CalcDate('-1D', CalcDate('8M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (4 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (4 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (4 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (4 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //.9 END
//                 //10 START
//                 FromDate := CalcDate('8M', StartDate);
//                 ToDate := CalcDate('-1D', CalcDate('9M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (3 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (3 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (3 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (3 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //10 END
//                 //..11 START
//                 FromDate := CalcDate('9M', StartDate);
//                 ToDate := CalcDate('-1D', CalcDate('10M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (2 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (2 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (2 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (2 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //.11 END
//                 //12 START
//                 FromDate := CalcDate('10M', StartDate);
//                 ToDate := CalcDate('-1D', CalcDate('11M', StartDate));
//                 Evaluate(FromDateS, Format(FromDate));
//                 Evaluate(ToDateS, Format(ToDate));

//                 Evaluate(BDate, '01/01/05');

//                 DateFilter := FromDateS + '..' + ToDateS;
//                 if MembersReg.Find('-') then begin

//                     MembersReg.Reset;
//                     MembersReg.SetCurrentkey("No.");
//                     MembersReg.SetRange(MembersReg."No.", MemberNo);
//                     MembersReg.SetFilter(MembersReg."Date Filter", DateFilter);
//                     //.....................

//                     if MembersReg.Find('-') then begin
//                         MembersReg.CalcFields(MembersReg."Current Shares", MembersReg."Shares Retained");
//                         if (MembersReg."Current Shares" > 0.01) then begin
//                             CInterest := 0;
//                             CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((MembersReg."Current Shares"))) * (1 / 12));
//                         end
//                         else if (MembersReg."Current Shares" < 0.01) then begin
//                             CInterest := 0;
//                         end;
//                         //...
//                         if (MembersReg."Shares Retained" > 0.01) then begin
//                             CDiv := 0;
//                             CDiv := (((GenSetUp."Dividend (%)" / 100) * ((MembersReg."Shares Retained"))) * (1 / 12));
//                         end
//                         else if (MembersReg."Shares Retained" < 0.01) then begin
//                             CDiv := 0;
//                         end;
//                         //............
//                         DivTotal := (CDiv + CInterest);
//                         DivProg.Init;
//                         DivProg."Member No" := MembersReg."No.";
//                         DivProg.Date := ToDate;
//                         DivProg."Gross Dividends" := CDiv;
//                         DivProg."Gross Interest On Deposit" := CInterest;
//                         DivProg."Qualifying Share Capital" := ((MembersReg."Shares Retained")) * (1 / 12);
//                         DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
//                         DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
//                         DivProg."Qualifying Shares" := ((MembersReg."Current Shares")) * (1 / 12);
//                         DivProg.Shares := MembersReg."Current Shares";
//                         DivProg."Share Capital" := MembersReg."Shares Retained";
//                         DivProg.Insert;
//                     end;
//                     //............................
//                 end;
//                 //12 END
//                 PayableAmount := 0;
//                 PayableAmount := FnGetTheDivTotalPayable(MemberNo);//Net Amount Paybale to member
//                 GrossTotalDiv := 0;
//                 GrossTotalDiv := FnGetTheGrossDivPayable(MemberNo);
//                 GrossDivOnShares := 0;
//                 GrossDivOnShares := (FnGetTheGrossDivOnSharesPayable(MemberNo));
//                 TotalWhtax := 0;
//                 TotalWhtax := FnGetTotalWhtax(MemberNo);
//                 NetPayableAmount := 0;
//                 NetPayableAmount := FnGetTheNetPayable(MemberNo);
//                 //.................................................Pass GL START
//                 // //------------------------------------1. CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits---------------------------------------
//                 LineNo := LineNo + 10000;
//                 SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                 GenJournalLine."account type"::Customer, MemberNo, PostingDate, GrossTotalDiv * -1, 'BOSA', '',
//                 'Gross Dividend+Interest on Deposits- ' + Format(PostingDate), '');

//                 // LineNo:=LineNo+10000;
//                 // SFactory.FnCreateGnlJournalLine('PAYMENTS','DIVIDEND',FORMAT(PostingDate),LineNo,GenJournalLine."Transaction Type"::Dividend,
//                 // GenJournalLine."Account Type"::Customer,MemberNo,PostingDate,GrossDivOnShares*-1,'BOSA','',
//                 // 'Dividend- '+FORMAT(PostingDate),'');
//                 // //-------------------------------------
//                 // //------------------------------------1.1 DEBIT DIVIVIDEND PAYABLE GL A/C----------------------------------------------------------------------
//                 LineNo := LineNo + 10000;
//                 GenSetUp.Get();
//                 SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                 GenJournalLine."account type"::"G/L Account", GenSetUp."Dividend Payable Account", PostingDate, GrossTotalDiv, 'BOSA', '',
//                 'Gross Dividend+Interest on Deposits- ' + MemberNo, '');

//                 // LineNo:=LineNo+10000;
//                 // GenSetUp.GET();
//                 // SFactory.FnCreateGnlJournalLine('PAYMENTS','DIVIDEND',FORMAT(PostingDate),LineNo,GenJournalLine."Transaction Type"::" ",
//                 // GenJournalLine."Account Type"::"G/L Account",GenSetUp."Dividend Payable Account",PostingDate,GrossDivOnShares,'BOSA','',
//                 // 'Dividend- '+MemberNo,'');
//                 // //----------------------------------(Debit Dividend Payable GL A/C)----------------------------------------------------------------------------
//                 // //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------
//                 LineNo := LineNo + 10000;
//                 GenSetUp.Get();
//                 SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                 GenJournalLine."account type"::"G/L Account", GenSetUp."WithHolding Tax Account", PostingDate, (TotalWhtax) * -1, 'BOSA', '',
//                 'Witholding Tax on Dividend- ' + MemberNo, '');

//                 LineNo := LineNo + 10000;
//                 YearCalc := Format(Date2dmy(StartDate, 3));
//                 SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                 GenJournalLine."account type"::Customer, MemberNo, PostingDate, (TotalWhtax), 'BOSA', '',
//                 'Witholding Tax on Dividend- ' + YearCalc, '');
//                 // //----------------------------------(bank chargr Witholding tax gl a/c)-----------------------------------------------------------------------------
//                 LineNo := LineNo + 10000;
//                 chargges := 0;
//                 NetPayableAmountFinal := 0;
//                 ExtraCharge1 := 0;
//                 YearCalc := Format(Date2dmy(StartDate, 3));
//                 if ((GrossTotalDiv) > 285) and (MembersReg.Status <> MembersReg.Status::Withdrawal) then begin
//                     chargges := 200;
//                     ExtraCharge1 := 0;
//                     ExtraCharge1 := chargges;
//                 end else
//                     if ((GrossTotalDiv) > 0) and ((GrossTotalDiv) <= 285) and (MembersReg.Status <> MembersReg.Status::Withdrawal) then begin
//                         chargges := 50;
//                         ExtraCharge1 := 0;
//                         ExtraCharge1 := chargges;
//                     end;
//                 SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                 GenJournalLine."account type"::Customer, MemberNo, PostingDate, chargges, 'BOSA', '',
//                 'Bank Charge- ' + YearCalc, '');
//                 LineNo := LineNo + 10000;
//                 SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                GenJournalLine."account type"::"G/L Account", '101410', PostingDate, (chargges) * -1, 'BOSA', '',
//                ' Bank Charge- ' + YearCalc, '');


//                 //cj
//                 // //------------------------------------2.1. charge WITHHOLDING TAX GL A/C-----------------------------------------------------------------------
//                 // LineNo:=LineNo+10000;
//                 // IF (GrossTotalDiv)>285 THEN
//                 //     chargges:=200;
//                 //        IF MembersReg.Status=MembersReg.Status::Withdrawal THEN
//                 //          ExtraCharge1:=50;
//                 //     IF ((GrossTotalDiv)>0) AND ((GrossTotalDiv)<=285 )THEN
//                 //     chargges:=50;
//                 // SFactory.FnCreateGnlJournalLine('PAYMENTS','DIVIDEND',FORMAT(PostingDate),LineNo,GenJournalLine."Transaction Type"::" ",
//                 // GenJournalLine."Account Type"::"G/L Account",'301414',PostingDate,(chargges)*-1,'BOSA','',
//                 // ' Bank Charge- '+MemberNo,'');
//                 //------------------------------------3. DEBITORMAT(PostingDate) MEMBER DIVIDEND A/C_PROCESSING FEE--------------------------------------------------------------
//                 LineNo := LineNo + 10000;
//                 GenSetUp.Get();
//                 SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                 GenJournalLine."account type"::Customer, MemberNo, PostingDate, GenSetUp."Dividend Processing Fee", 'BOSA', '',
//                 'Processing Fee- ' + MemberNo, '');
//                 ExtraCharge2 := 0;
//                 ExtraCharge2 := GenSetUp."Dividend Processing Fee";
//                 //--------------------------------(Debit Member Dividend A/C_Processing Fee)-------------------------------------------------------------------
//                 // //------------------------------------3.1. CREDIT PROCESSING FEE INCOME GL A/C-----------------------------------------------------------------
//                 LineNo := LineNo + 10000;
//                 GenSetUp.Get();
//                 SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::" ",
//                 GenJournalLine."account type"::"G/L Account", GenSetUp."Dividend Process Fee Account", PostingDate, GenSetUp."Dividend Processing Fee" * -1, 'BOSA', '',
//                 'Processing Fee- ' + Format(PostingDate), '');
//                 // //-------------------------s---------(Credit Processing Fee income gl a/c)----------------------------------------------------------------------
//                 //
//                 // //------------------------------------4. DEBIT MEMBER DIVIDEND A/C_EXCISE ON PROCESSING FEE----------------------------------------------------
//                 LineNo := LineNo + 10000;
//                 GenSetUp.Get();
//                 SFactory.FnCreateGnlJournalLine('PAYMENTS', 'DIVIDEND', Format(PostingDate), LineNo, GenJournalLine."transaction type"::Dividend,
//                 GenJournalLine."account type"::Customer, MemberNo, PostingDate, (GenSetUp."Dividend Processing Fee" * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', '',
//                 'Excise Duty- ' + Format(PostingDate), '');
//                 ExtraCharge3 := 0;
//                 ExtraCharge3 := (GenSetUp."Dividend Processing Fee" * (GenSetUp."Excise Duty(%)" / 100));
//                 //.................................................END PASS GL
//                 // MESSAGE('charge1 %1',ExtraCharge1);
//                 // MESSAGE('charge2 %1',ExtraCharge2);
//                 // ERROR('charge3 %1',ExtraCharge3);
//                 NetPayableAmountFinal := NetPayableAmount - (ExtraCharge1 + ExtraCharge2 + ExtraCharge3);
//                 MembersReg."Dividend Amount" := NetPayableAmountFinal;
//                 MembersReg."Gross Div on share Capital" := GrossDivOnShares;
//                 MembersReg."Gross Int On Deposits" := GrossTotalDiv - GrossDivOnShares;
//                 MembersReg."WithholdingTax on gross div" := TotalWhtax;
//                 MembersReg."Bank Charges on processings" := chargges;
//                 MembersReg."Gross Dividend Amount Payable" := GrossTotalDiv;
//                 MembersReg.Modify;


//             end;

//         end;
//     end;


//     procedure FnGetTheDivTotalPayable(MemberNo: Code[30]): Decimal
//     var
//         DivProgressionTable: Record "Dividends Progression";
//         Amountss: Decimal;
//     begin

//         Amountss := 0;
//         DivProgressionTable.Reset;
//         DivProgressionTable.SetRange(DivProgressionTable."Member No", MemberNo);
//         if DivProgressionTable.Find('-') then begin
//             repeat
//                 Amountss += ROUND(DivProgressionTable."Net Dividends");
//             //...........................
//             until DivProgressionTable.Next = 0;
//         end;
//         exit(Amountss);
//     end;


//     procedure FnGetTheGrossDivPayable(MemberNo: Code[30]): Decimal
//     var
//         DivProgressionTable: Record "Dividends Progression";
//         GrossDivAmount: Decimal;
//     begin
//         GrossTotalDiv := 0;
//         DivProgressionTable.Reset;
//         DivProgressionTable.SetRange(DivProgressionTable."Member No", MemberNo);
//         if DivProgressionTable.Find('-') then begin
//             repeat
//                 GrossTotalDiv += ROUND(DivProgressionTable."Gross Dividends" + DivProgressionTable."Gross Interest On Deposit");
//             //...........................
//             until DivProgressionTable.Next = 0;
//         end;
//         exit(GrossTotalDiv);
//     end;


//     procedure FnGetTheGrossDivOnSharesPayable(MemberNo: Code[30]): Decimal
//     var
//         DivProgressionTable: Record "Dividends Progression";
//         GrossDivAmountOnShares: Decimal;
//     begin
//         GrossDivAmountOnShares := 0;
//         DivProgressionTable.Reset;
//         DivProgressionTable.SetRange(DivProgressionTable."Member No", MemberNo);
//         if DivProgressionTable.Find('-') then begin
//             repeat
//                 GrossDivAmountOnShares += ROUND(DivProgressionTable."Gross Dividends");
//             //...........................
//             until DivProgressionTable.Next = 0;
//         end;
//         exit(GrossDivAmountOnShares);
//     end;


//     procedure FnGetTotalWhtax(MemberNo: Code[30]): Decimal
//     var
//         DivProgressionTable: Record "Dividends Progression";
//         TotalTax: Decimal;
//     begin
//         TotalTax := 0;
//         DivProgressionTable.Reset;
//         DivProgressionTable.SetRange(DivProgressionTable."Member No", MemberNo);
//         if DivProgressionTable.Find('-') then begin
//             repeat
//                 TotalTax += ROUND(DivProgressionTable."Witholding Tax");
//             //...........................
//             until DivProgressionTable.Next = 0;
//         end;
//         exit(TotalTax);
//     end;


//     procedure FnGetTheNetPayable(MemberNo: Code[30]): Decimal
//     var
//         DivProgressionTable: Record "Dividends Progression";
//         TotalNetPay: Decimal;
//     begin
//         TotalNetPay := 0;
//         DivProgressionTable.Reset;
//         DivProgressionTable.SetRange(DivProgressionTable."Member No", MemberNo);
//         if DivProgressionTable.Find('-') then begin
//             repeat
//                 TotalNetPay += ROUND(DivProgressionTable."Gross Interest On Deposit") + ROUND(DivProgressionTable."Gross Dividends") - ROUND(DivProgressionTable."Witholding Tax");
//             //...........................
//             until DivProgressionTable.Next = 0;
//         end;
//         exit(TotalNetPay);
//     end;


//     procedure FnDontAccountForWithdrwnMemberInt()
//     begin
//     end;


//     procedure FnAccountForWithdrwnMemberInt()
//     begin
//     end;
// }

