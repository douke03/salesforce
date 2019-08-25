public with sharing class AccountHandler extends BaseHandler {
    public override void processBeforeInsert(List<Object> newObjects){
        for(Object newObject : newObjects) {
            debug('override');
            Account acc = (Account)newObject;
            debug(acc);
        }
    }
}