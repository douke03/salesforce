/**
 * Exception notification handler
 * @author Nakano Shoki
 */
public without sharing class SampleHandler extends BaseHandler {
    /**
     * @description Before insert
     * @author Nakano Shoki
     */
    public override void processBeforeInsert(List<Object> newObjects) {
        debug('check work');
        for(Object newObject : newObjects) {
            Sample__c sample = (Sample__c)newObject;
            debug(sample);
            // sample.addError('test');
        }
        Account a = new Account();
        insert a;
    }
}