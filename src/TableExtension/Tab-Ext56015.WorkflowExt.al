namespace PolyTech.PolyTech;

using System.Automation;

tableextension 56015 "Workflow Ext" extends Workflow
{

    trigger OnInsert()
    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        WFEventHandler: Codeunit "Workflow Event Handling";
        SurestepWFEvents: Codeunit "Custom Workflow Events";
        WFResponseHandler: Codeunit "Workflow Response Handling";

        WorkflowEventHandler: Codeunit "Custom Workflow Events";
        WorkflowResponseHandler: Codeunit "Custom Workflow Responses";
    begin
        // Register Workflow Event
        // WorkflowEventHandler.MyWorkflowEvent(RecId, WorkflowContext);
        // WFHandler.AddEventToLibrary();

        // Register Workflow Response
        // WorkflowResponseHandler.HandleMyWorkflowResponse(RecId, WorkflowContext);
    end;
}
