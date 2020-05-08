public with sharing class CountNumberView extends Base{
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    public CountNumberView() {
        // none
    }
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    /**
     * @description test
     * @param String recordId
     * @author Nakano Shoki
     */
    @AuraEnabled(cacheable=false)
    public static ViewHistory__c getViewHistory(String recordId) {
        try {
            List<ViewHistory__c> vh = [
                SELECT Id,
                       ViewUser__c,
                       ViewRecordId__c,
                       ViewCount__c
                FROM   ViewHistory__c
                WHERE  ViewRecordId__c = :recordId
                  AND  ViewUser__c = :UserInfo.getUserId()
                LIMIT 1
            ];
            if(vh.size() != 0) {
                return vh[0];
            } else {
                return new ViewHistory__c();
            }
        } catch (Exception e) {
            exceptionHandler(e);
            return new ViewHistory__c();
        }
    }
}