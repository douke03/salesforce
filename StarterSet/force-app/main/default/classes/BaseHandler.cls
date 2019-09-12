/**
 * Base for all handler classes
 * @author Nakano Shoki
 */
public with sharing virtual class BaseHandler extends Base implements TriggerHandler {
    /**
     * @description Constructor
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
                    info('[TRIGGER] Process Before Insert');
                    processBeforeInsert(newObjects);
                }
                if(Trigger.isUpdate) {
                    info('[TRIGGER] Process Before Update');
                    processBeforeUpdate(newObjects, oldObjects);
                }
                if(Trigger.isDelete) {
                    info('[TRIGGER] Process Before Delete');
                    processBeforeDelete(oldObjects);
                }
            }
            if(Trigger.isAfter) {
                if(Trigger.isInsert) {
                    info('[TRIGGER] Process After Insert');
                    processAfterInsert(newObjects);
                }
                if(Trigger.isUpdate) {
                    info('[TRIGGER] Process After Update');
                    processAfterUpdate(newObjects, oldObjects);
                }
                if(Trigger.isDelete) {
                    info('[TRIGGER] Process After Delete');
                    processAfterDelete(oldObjects);
                }
            }
        } catch(Exception e) {
            exceptionHandler(e);
        } finally {
            debug('Finally');
            // none
        }
    }
    /**
     * @description Process before insert
     * @param newObjects
     * @return None
     * @author Nakano Shoki
     */
    public virtual void processBeforeInsert(List<Object> newObjects){
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
    public virtual void processBeforeUpdate(List<Object> newObjects, List<Object> oldObjects){
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
    public virtual void processBeforeDelete(List<Object> oldObjects){
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
    public virtual void processAfterInsert(List<Object> newObjects){
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
    public virtual void processAfterUpdate(List<Object> newObjects, List<Object> oldObjects){
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
    public virtual void processAfterDelete(List<Object> oldObjects){
        for(Object oldObject : oldObjects) {
            debug(oldObject);
        }
    }
}