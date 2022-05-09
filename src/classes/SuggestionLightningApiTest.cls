@IsTest
private class SuggestionLightningApiTest {

    @IsTest
    static void create_requiredFieldsPopulated_expectRecordInserted() {
        Suggestion__c newRecord = new Suggestion__c();
        newRecord.Title__c = 'Sample Suggestion';
        newRecord.Category__c = 'Fun';
        newRecord.Details__c = 'All that good stuff to suggest.';

        SuggestionLightningApi.create(newRecord);

        System.assertNotEquals(null, newRecord.Id, 'Expected the new record Id to be populated.');
    }

    @IsTest
    static void create_requiredFieldsNotPopulated_expectError() {
        Suggestion__c newRecord = new Suggestion__c();

        try {
            SuggestionLightningApi.create(newRecord);
            System.assert(false, 'We should not make it here and an exception should be thrown.');
        } catch (Exception ex) {
            System.assertEquals(null, newRecord.Id, 'Expected the new record Id to be populated.');
        }
    }
}