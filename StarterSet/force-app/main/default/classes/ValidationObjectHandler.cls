/**
 * Exception notification handler
 * @author Nakano Shoki
 */
public without sharing class ValidationObjectHandler
    extends BaseHandler {
    /**
     * @description Before insert
     * @author Nakano Shoki
     */
    public override void beforeInsert(List<sObject> newObjectList) {
        List<ValidationObject__c> validationObjectList = (List<ValidationObject__c>)newObjectList;
        for(ValidationObject__c validationObject : validationObjectList) {
            commonProcessing(validationObject);
        }
    }
    /**
     * @description Before update
     * @author Nakano Shoki
     */
    public override void beforeUpdate(Map<Id, sObject> newObjectMap, Map<Id, sObject> oldObjectMap) {
        Map<Id, ValidationObject__c> validationObjectMap = (Map<Id, ValidationObject__c>)newObjectMap;
        for(ValidationObject__c validationObject : validationObjectMap.values()) {
            commonProcessing(validationObject);
        }
    }
    /**
     * @description Raises a QueryException.
     * @author Nakano Shoki
     */
    public void commonProcessing(ValidationObject__c vo) {
        if(vo.DmlException__c) {
            Account a = new Account();
            insert a;
        }
        if(vo.QueryException__c) {
            for(Integer i = 0; i < 300; i++) {
                Account acc = [SELECT Id FROM Account LIMIT1];
            }
        }
    }
}