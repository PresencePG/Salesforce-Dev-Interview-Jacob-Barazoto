/**
 * @description The LWC Compatible API for suggestions submitted online.
 */
public with sharing class SuggestionLightningApi {

    @AuraEnabled
    public static void create(Suggestion__c record) {
        try {
            insert record;
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}