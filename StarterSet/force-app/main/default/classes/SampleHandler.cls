/**
 * Exception notification handler
 * @author Nakano Shoki
 */
public without sharing class SampleHandler extends BaseHandler {
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
}