public virtual class BaseHandler extends Base {
    public BaseHandler() {
    }
    public void handle(){
        if(Trigger.isBefore) {
            Debug('isBefore');
            if(Trigger.isInsert) {
                Debug('isInsert');
            }
            if(Trigger.isUpdate) {
                Debug('isUpdate');
            }
            if(Trigger.isDelete) {
                Debug('isDelete');
            }
        }
        if(Trigger.isAfter) {
            Debug('isAfter');
            if(Trigger.isInsert) {
                Debug('isInsert');
            }
            if(Trigger.isUpdate) {
                Debug('isUpdate');
            }
            if(Trigger.isDelete) {
                Debug('isDelete');
            }
        }
    }
}
