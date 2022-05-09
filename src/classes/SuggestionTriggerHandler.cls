/**
 * @description Contains all the trigger code for the Suggestion__c custom object.
 */
public without sharing class SuggestionTriggerHandler implements TriggerHandler {

    /* Insert Operations */
    public void beforeInsert( List<sObject> newSObjects) {
        this.validateCategoryValues((List<Suggestion__c>)newSObjects);
    }
    public void afterInsert( Map<Id,sObject> newSObjects) {}

    /* Update Operations */
    public void beforeUpdate( Map<Id,sObject> newSObjects, Map<Id,sObject> oldSObjects) {}
    public void afterUpdate( Map<Id,sObject> newSObjects, Map<Id,sObject> oldSObjects) {}

    /* Delete Operations */
    public void beforeDelete( Map<Id,sObject> newSObjects, Map<Id,sObject> oldSObjects) {}
    public void afterDelete( Map<Id,sObject> newSObjects, Map<Id,sObject> oldSObjects) {}

    /* Undelete Operations */
    public void afterUnDelete( Map<Id,sObject> newSObjects, Map<Id,sObject> oldSObjects) {}

    private void validateCategoryValues(List<Suggestion__c> newSuggestionRecords) {
        Set<String> validCategoryValues = getCategoryPicklistValues();

        for (Suggestion__c record : newSuggestionRecords) {
            // If a category value was specified and it isn't one of the picklist values, throw an error.
            if (String.isNotBlank(record.Category__c) && !validCategoryValues.contains(record.Category__c)) {
                record.Category__c.addError('The category value must be Work, Interviewing, Fun, or Other.');
            }
        }
    }

    private Set<String> getCategoryPicklistValues() {
        Set<String> picklistValues = new Set<String>();

        for (Schema.PicklistEntry picklistEntry : Suggestion__c.Category__c.getDescribe().getPicklistValues()) {
            picklistValues.add(picklistEntry.getValue());
        }

        return picklistValues;
    }
}