/**
 * Exception notification handler
 * @author Nakano Shoki
 */
public without sharing class SampleHandler extends BaseHandler {
    /**
     * @description Before insert
     * @author Nakano Shoki
     */
    public override void beforeInsert(List<Object> newObjects) {
        debug('check work');
        for(Object newObject : newObjects) {
            Sample__c sample = (Sample__c)newObject;
            debug(sample);
            // sample.addError('test');
        }
    }
}