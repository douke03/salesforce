/**
 * Exception notification handler
 * @author Nakano Shoki
 */
public without sharing class ExceptionNotificationHandler extends BaseHandler {
    /**
     * @description After insert
     *      Save as an ErrorLog__c when an ExceptionNotification__e is created.
     * @author Nakano Shoki
     */
    public override void afterInsert(List<Object> newObjectList) {
        List<ExceptionNotification__e> excNotificationList = (List<ExceptionNotification__e>)newObjectList;
        List<ErrorLog__c> errorLogList = new List<ErrorLog__c>();
        for(ExceptionNotification__e excNotification : excNotificationList) {
            ErrorLog__c errorLog = new ErrorLog__c(
                ExecutionUser__c = excNotification.ExecutionUserID__c,
                TypeName__c = excNotification.TypeName__c,
                StackTrace__c = excNotification.StackTrace__c,
                LogMessage__c = excNotification.Message__c
            );
            errorLogList.add(errorLog);
        }
        insert errorLogList;
    }
}