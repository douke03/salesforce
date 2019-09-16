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
    public override void processAfterInsert(List<Object> newObjects){
        List<ErrorLog__c> elList = new List<ErrorLog__c>();
        for(Object newObject : newObjects) {
            ExceptionNotification__e en = (ExceptionNotification__e)newObject;
            ErrorLog__c el = new ErrorLog__c(
                ExecutionUser__c = en.ExecutionUserID__c,
                TypeName__c = en.TypeName__c,
                StackTrace__c = en.StackTrace__c,
                LogMessage__c = en.Message__c
            );
            elList.add(el);
        }
        insert elList;
    }
}