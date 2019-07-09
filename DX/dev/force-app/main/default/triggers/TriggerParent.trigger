trigger TriggerParent on Parent__c (before insert, before update, after insert, after update) {
    System.debug('====================================');
    System.debug('========== Start TriggerParent');

}