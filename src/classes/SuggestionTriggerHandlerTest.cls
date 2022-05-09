@IsTest
private class SuggestionTriggerHandlerTest {

    @IsTest
    static void onBeforeInsert_invalidCategoryValue_expectError() {
        Suggestion__c newRecord = new Suggestion__c();
        newRecord.Title__c = 'Sample Title';
        newRecord.Details__c = 'Sample Details';
        newRecord.Category__c = 'Invalid Category';

        try {
            insert newRecord;
            System.assert(false, 'Expected an error to be thrown before reaching this line.');
        } catch (Exception ex) {
            System.assert(true, 'Expected an error to be thrown when setting the category field to a value that is not defined in the picklist.');
        }
    }

    @IsTest
    static void onBeforeInsert_validCategoryValue_expectRecordInserted() {
        String validCategory = Suggestion__c.Category__c.getDescribe().getPicklistValues()[0].getValue();
        Suggestion__c newRecord = new Suggestion__c();
        newRecord.Title__c = 'Sample Title';
        newRecord.Details__c = 'Sample Details';
        newRecord.Category__c = validCategory;

        insert newRecord;

        System.assertNotEquals(null, newRecord.Id, 'Expected the new Suggestion__c to be inserted and to have an Id as proof.');
    }
}