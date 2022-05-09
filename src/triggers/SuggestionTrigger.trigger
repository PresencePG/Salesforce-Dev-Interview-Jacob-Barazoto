trigger SuggestionTrigger on Suggestion__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TriggerFactory.createAndExecuteHandler(SuggestionTriggerHandler.class);
}