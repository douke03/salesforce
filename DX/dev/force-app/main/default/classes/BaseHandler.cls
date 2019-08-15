public virtual class BaseHandler extends Base implements TriggerHandler {
    public BaseHandler() {
    }
    public void handle(){
        List<Object> newObjects = Trigger.new;
        List<Object> oldObjects = Trigger.old;
        if(Trigger.isBefore) {
            Info('isBefore');
            if(Trigger.isInsert) {
                Info('isInsert');
                processBeforeInsert(newObjects);
            }
            if(Trigger.isUpdate) {
                Info('isUpdate');
            }
            if(Trigger.isDelete) {
                Info('isDelete');
                processBeforeDelete(newObjects, oldObjects);
            }
        }
        if(Trigger.isAfter) {
            Info('isAfter');
            if(Trigger.isInsert) {
                Info('isInsert');
            }
            if(Trigger.isUpdate) {
                Info('isUpdate');
            }
            if(Trigger.isDelete) {
                Info('isDelete');
            }
        }
    }
    public void processBeforeInsert(List<Object> newObjects){
        for(Object newObject : newObjects) {
            Debug(newObject);
        }
    }
    public void processBeforeDelete(List<Object> newObjects, List<Object> oldObjects){
        for(Object newObject : newObjects) {
            Debug(newObject);
        }
        for(Object oldObject : oldObjects) {
            Debug(oldObject);
        }
    }
}
