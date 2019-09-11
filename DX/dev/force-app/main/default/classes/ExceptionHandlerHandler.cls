public with sharing class ExceptionHandlerHandler extends BaseHandler {
    public override void processAfterInsert(List<Object> newObjects){
        List<ApexCustomLog__c> acList = new List<ApexCustomLog__c>();
        for(Object newObject : newObjects) {
            ExceptionHandler__e eh = (ExceptionHandler__e)newObject;
            ApexCustomLog__c ac = new ApexCustomLog__c(
                LogLevel__c = 'ERROR',
                ExecutionUser__c = eh.ExecutionUserID__c,
                TypeName__c = eh.TypeName__c,
                StackTrace__c = eh.StackTrace__c,
                LogMessage__c = eh.Message__c
            );
            acList.add(ac);
        }
        insert acList;
    }
}