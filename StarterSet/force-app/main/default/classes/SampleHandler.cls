/**
 * Exception notification handler
 * @author Nakano Shoki
 */
public without sharing class SampleHandler
    extends BaseHandler {
    /**
     * @description Before insert
     * @author Nakano Shoki
     */
    public override void beforeInsert(List<sObject> newObjectList) {
        debug('check work');
        List<Sample__c> sampleList = (List<Sample__c>)newObjectList;
        for(Sample__c sample : sampleList) {
            debug(sample);
            // sample.addError('test');
        }
    }
    /**
     * @description Before update
     * @author Nakano Shoki
     */
    public override void beforeUpdate(Map<Id, sObject> newObjectMap, Map<Id, sObject> oldObjectMap) {
        debug('check work');
        Map<Id, Sample__c> sampleMap = (Map<Id, Sample__c>)newObjectMap;
        for(Sample__c sample : sampleMap.values()) {
            debug(sample);
            for(Integer i = 0; i < 300; i++) {
                Account acc = [SELECT Id FROM Account LIMIT1];
            }
            // sample.addError('test');
        }
    }
}