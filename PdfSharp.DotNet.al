dotnet
{
    assembly("PdfSharp")
    {
        type("PdfSharp.Pdf.IO.PdfReader"; PdfReader) { }
        type("PdfSharp.Pdf.PdfDocument"; PdfDocument) { }
        type("PdfSharp.Pdf.Security.PdfSecuritySettings"; PdfSecuritySettings) { }
    }

    assembly("mscorlib")
    {
        type("System.Convert"; Convert) { }
        type("System.IO.File"; File) { }
        type("System.IO.Path"; Path) { }
    }
}