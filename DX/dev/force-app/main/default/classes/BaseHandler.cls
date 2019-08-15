public virtual class BaseHandler extends Base implements TriggerHandler {
    public BaseHandler() {
    }
    public void handle(){
        List<Object> newObjexts = Trigger.new;
        List<Object> oldObjexts = Trigger.old;
        if(Trigger.isBefore) {
            Info('isBefore');
            if(Trigger.isInsert) {
                Info('isInsert');
                processBeforeInsert(newObjexts);
            }
            if(Trigger.isUpdate) {
                Info('isUpdate');
            }
            if(Trigger.isDelete) {
                Info('isDelete');
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
    public void processBeforeInsert(List<Object> newObjexts){
        Debug('processBeforeInsert');
    }
}
