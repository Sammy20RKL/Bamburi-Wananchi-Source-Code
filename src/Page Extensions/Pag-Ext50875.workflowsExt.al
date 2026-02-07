pageextension 50875 "workflowsExt" extends Workflows
{
    trigger OnOpenPage()
    var
        CustomWorkFlowEvents: Codeunit "Custom Workflow Events";
        WorkflowRepsonse: Codeunit "Custom Workflow Responses";
    begin
        CustomWorkFlowEvents.AddEventsToLib();//();
        WorkflowRepsonse.AddResponsesToLib();//();
        Message('Done!');
    end;
}
