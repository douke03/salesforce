trigger TriggerChild on Child__c (before insert, before update, after insert, after update) {
    System.debug('====================================');
    System.debug('========== Start TriggerChild');
    
    if(Trigger.isBefore){
        if(Trigger.isInsert) {
            for (Child__c newChild : Trigger.new) {
                if(newChild.Confirm__c == TRUE) {
                    System.debug('========== 更新後の確定=TRUE');
                    newChild.ConfirmLock__c = True;
                }
            }
        }
        if(Trigger.isUpdate) {
            for (Child__c newChild : Trigger.new) {
                Child__c oldChild = Trigger.oldMap.get(newChild.Id);
                if(oldChild.Confirm__c == FALSE && newChild.Confirm__c == TRUE) {
                    System.debug('========== 更新前の確定=FALSE');
                    System.debug('========== 更新後の確定=TRUE');
                    newChild.ConfirmLock__c = True;
                }
            }
        }
    }

    if(Trigger.isAfter){
        for (Child__c newChild : Trigger.new) {
            if(newChild.Confirm__c == TRUE) {
                List<Child__c> childs = new List<Child__c>();
                List<Child__c> otherChilds = [SELECT NAME,
                                                     Confirm__c,
                                                     ConfirmLock__c
                                              FROM   Child__c
                                              WHERE  ID != :newChild.ID];
                for (Child__c otherChild : otherChilds) {
                    System.debug('========== otherChild.Name: ' + otherChild.Name);
                    otherChild.Confirm__c = False;
                    otherChild.ConfirmLock__c = False;
                    childs.add(otherChild);
                }
                update childs;
            }
        }
    }
}