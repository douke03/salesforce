/**
 * Base for all handler classes
 * @author Nakano Shoki
 */
public with sharing virtual class BaseHandler extends Base implements TriggerHandler {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    private Boolean isActiveTrigger = true;

    public BaseHandler() {
        String masterLabel = 'T_' + className;
        List<ActiveSetting__mdt> activeSetttingList = [
            SELECT Id,
                   DeveloperName,
                   isActive__c
            FROM   ActiveSetting__mdt
            WHERE  DeveloperName = 'T_All'
               OR  DeveloperName = :masterLabel
        ];
        for(ActiveSetting__mdt activeSetting : activeSetttingList) {
            if(!activeSetting.isActive__c) {
                isActiveTrigger = false;
                break;
            }
        }
    }
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    /**
     * @description Trigger processing handler
     *      All Trigger processes implemented according to the template go through this process.
     * @author Nakano Shoki
     */
    public void handle() {
        if(isActiveTrigger) {
            try {
                if(Trigger.isBefore) {
                    if(Trigger.isInsert) {
                        info('[TRIGGER] Process Before Insert');
                        processBeforeInsert(Trigger.new);
                    }
                    if(Trigger.isUpdate) {
                        info('[TRIGGER] Process Before Update');
                        processBeforeUpdate(Trigger.newMap, Trigger.oldMap);
                    }
                    if(Trigger.isDelete) {
                        info('[TRIGGER] Process Before Delete');
                        processBeforeDelete(Trigger.old);
                    }
                }
                if(Trigger.isAfter) {
                    if(Trigger.isInsert) {
                        info('[TRIGGER] Process After Insert');
                        processAfterInsert(Trigger.new);
                    }
                    if(Trigger.isUpdate) {
                        info('[TRIGGER] Process After Update');
                        processAfterUpdate(Trigger.newMap, Trigger.oldMap);
                    }
                    if(Trigger.isDelete) {
                        info('[TRIGGER] Process After Delete');
                        processAfterDelete(Trigger.old);
                    }
                }
            } catch(Exception e) {
                for(Integer i = 0, j = Trigger.new.size(); i < j; i++) {
                    Trigger.new[i].addError('想定外のエラーが発生しました。システム管理者へお問い合わせください。');
                }
                exceptionHandler(e);
            } finally {
                // none
            }
        } else {
            info(className + 'did not work because ActiveSetting is false.');
        }
    }
    /**
     * @description Process before insert
     *      If implement BeforeInsert process, must override this process.
     * @param List<Object> newObjects
     * @author Nakano Shoki
     */
    public virtual void processBeforeInsert(List<Object> newObjects) {
        for(Object newObject : newObjects) {
            debug(newObject);
        }
    }
    /**
     * @description Process before update
     *      If implement BeforeUpdate process, must override this process.
     * @param Map<Id, Object> newObjectMap
     * @param Map<Id, Object> oldObjectMap
     * @author Nakano Shoki
     */
    public virtual void processBeforeUpdate(Map<Id, Object> newObjectMap, Map<Id, Object> oldObjectMap) {
        for (String key : newObjectMap.keySet()) {
            debug(newObjectMap.get(key));
        }
        for (Object oldObject : oldObjectMap.values()) {
            debug(oldObject);
        }
    }
    /**
     * @description Process before delete
     *      If implement BeforeDelete process, must override this process.
     * @param List<Object> oldObjects
     * @author Nakano Shoki
     */
    public virtual void processBeforeDelete(List<Object> oldObjects) {
        for(Object oldObject : oldObjects) {
            debug(oldObject);
        }
    }
    /**
     * @description Process after insert
     *      If implement AfterInsert process, must override this process.
     * @param List<Object> newObjects
     * @author Nakano Shoki
     */
    public virtual void processAfterInsert(List<Object> newObjects) {
        for(Object newObject : newObjects) {
            debug(newObject);
        }
    }
    /**
     * @description Process after update
     *      If implement AfterUpdate process, must override this process.
     * @param Map<Id, Object> newObjectMap
     * @param Map<Id, Object> oldObjectMap
     * @author Nakano Shoki
     */
    public virtual void processAfterUpdate(Map<Id, Object> newObjectMap, Map<Id, Object> oldObjectMap) {
        for (String key : newObjectMap.keySet()) {
            debug(newObjectMap.get(key));
        }
        for (String key : oldObjectMap.keySet()) {
            debug(oldObjectMap.get(key));
        }
    }
    /**
     * @description Process after delete
     *      If implement AfterDelete process, must override this process.
     * @param List<Object> oldObjects
     * @author Nakano Shoki
     */
    public virtual void processAfterDelete(List<Object> oldObjects) {
        for(Object oldObject : oldObjects) {
            debug(oldObject);
        }
    }
}