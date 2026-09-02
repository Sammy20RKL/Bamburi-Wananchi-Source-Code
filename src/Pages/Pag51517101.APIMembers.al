page 51517101 "API Members"
{
    PageType = API;
    APIPublisher = 'swizzsoft';
    APIGroup = 'bamburi';
    APIVersion = 'v1.0';
    EntityName = 'member';
    EntitySetName = 'members';
    SourceTable = Customer;
    DelayedInsert = true;
    ODataKeyFields = "No.";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(memberNo; Rec."No.") { }
                field(name; Rec.Name) { }
                field(customerType; Rec."Customer Type") { }
                field(accountCategory; Rec."Account Category") { }
                field(status; Rec.Status) { }
                field(registrationDate; Rec."Registration Date") { }
                field(gender; Rec.Gender) { }
                field(mobilePhoneNo; Rec."Mobile Phone No") { }
                field(currentSavings; Rec."Current Savings") { }
                field(currentShares; Rec."Current Shares") { }
                field(totalLoansOutstanding; Rec."Total Loans Outstanding") { }
            }
        }
    }
}
