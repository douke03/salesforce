trigger CustomObject1Trigger on CustomObject1__e (after insert) {
    ApexCustomLog__c acl = new ApexCustomLog__c();
    acl.LogLevel__c = 'ERROR';
    insert acl;
}