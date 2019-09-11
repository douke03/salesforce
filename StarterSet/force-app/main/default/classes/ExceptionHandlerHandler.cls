public without sharing class ExceptionHandlerHandler extends BaseHandler {
    public override void processAfterInsert(List<Object> newObjects){
        List<ErrorLog__c> elList = new List<ErrorLog__c>();
        for(Object newObject : newObjects) {
            ExceptionHandler__e eh = (ExceptionHandler__e)newObject;
            ErrorLog__c el = new ErrorLog__c(
                ExecutionUser__c = eh.ExecutionUserID__c,
                TypeName__c = eh.TypeName__c,
                StackTrace__c = eh.StackTrace__c,
                LogMessage__c = eh.Message__c
            );
            elList.add(el);
        }
        insert elList;
    }
}