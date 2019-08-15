/**
 * Base for all handler classes
 */
public virtual class BaseHandler extends Base implements TriggerHandler {
    /**
     * @description Const
     * @author Nakano Shoki
     */
    public BaseHandler() {
    }
    /**
     * @description Responsible for allocating processing
     * @param None
     * @return None
     * @author Nakano Shoki
     */
    public void handle(){
        try {
            List<Object> newObjects = Trigger.new;
            List<Object> oldObjects = Trigger.old;
            if(Trigger.isBefore) {
                if(Trigger.isInsert) {
                    info('Process Before Insert');
                    processBeforeInsert(newObjects);
                }
                if(Trigger.isUpdate) {
                    info('Process Before Update');
                    processBeforeUpdate(newObjects, oldObjects);
                }
                if(Trigger.isDelete) {
                    info('Process Before Delete');
                    processBeforeDelete(oldObjects);
                }
            }
            if(Trigger.isAfter) {
                if(Trigger.isInsert) {
                    info('Process After Insert');
                    processAfterInsert(newObjects);
                }
                if(Trigger.isUpdate) {
                    info('Process After Update');
                    processAfterUpdate(newObjects, oldObjects);
                }
                if(Trigger.isDelete) {
                    info('Process After Delete');
                    processAfterDelete(oldObjects);
                }
            }
        } catch(Exception e) {
            error(e);
        } finally {
            // none
        }
    }
    /**
     * @description Process before insert
     * @param newObjects
     * @return None
     * @author Nakano Shoki
     */
    public void processBeforeInsert(List<Object> newObjects){
        for(Object newObject : newObjects) {
            debug(newObject);
        }
    }
    /**
     * @description Process before update
     * @param newObjects
     * @param oldObjects
     * @return None
     * @author Nakano Shoki
     */
    public void processBeforeUpdate(List<Object> newObjects, List<Object> oldObjects){
        for(Object newObject : newObjects) {
            debug(newObject);
        }
        for(Object oldObject : oldObjects) {
            debug(oldObject);
        }
    }
    /**
     * @description Process before delete
     * @param oldObjects
     * @return None
     * @author Nakano Shoki
     */
    public void processBeforeDelete(List<Object> oldObjects){
        for(Object oldObject : oldObjects) {
            debug(oldObject);
        }
    }
    /**
     * @description Process after insert
     * @param newObjects
     * @return None
     * @author Nakano Shoki
     */
    public void processAfterInsert(List<Object> newObjects){
        for(Object newObject : newObjects) {
            debug(newObject);
        }
    }
    /**
     * @description Process after update
     * @param newObjects
     * @param oldObjects
     * @return None
     * @author Nakano Shoki
     */
    public void processAfterUpdate(List<Object> newObjects, List<Object> oldObjects){
        for(Object newObject : newObjects) {
            debug(newObject);
        }
        for(Object oldObject : oldObjects) {
            debug(oldObject);
        }
    }
    /**
     * @description Process after delete
     * @param oldObjects
     * @return None
     * @author Nakano Shoki
     */
    public void processAfterDelete(List<Object> oldObjects){
        for(Object oldObject : oldObjects) {
            debug(oldObject);
        }
    }
}
