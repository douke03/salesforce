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
        info('[TRIGGER] ' + Trigger.operationType);
        if(isActiveTrigger) {
            try {
                switch on Trigger.operationType {
                    when BEFORE_INSERT  {beforeInsert(Trigger.new);}
                    when BEFORE_UPDATE  {beforeUpdate(Trigger.newMap, Trigger.oldMap);}
                    when BEFORE_DELETE  {beforeDelete(Trigger.old);}
                    when AFTER_INSERT   {afterInsert(Trigger.new);}
                    when AFTER_UPDATE   {afterUpdate(Trigger.newMap, Trigger.oldMap);}
                    when AFTER_DELETE   {afterDelete(Trigger.old);}
                    when AFTER_UNDELETE {afterUndelete(Trigger.new);}
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
    public virtual void beforeInsert(List<Object> newObjects) {
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
    public virtual void beforeUpdate(Map<Id, Object> newObjectMap, Map<Id, Object> oldObjectMap) {
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
    public virtual void beforeDelete(List<Object> oldObjects) {
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
    public virtual void afterInsert(List<Object> newObjects) {
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
    public virtual void afterUpdate(Map<Id, Object> newObjectMap, Map<Id, Object> oldObjectMap) {
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
    public virtual void afterDelete(List<Object> oldObjects) {
        for(Object oldObject : oldObjects) {
            debug(oldObject);
        }
    }
    /**
     * @description Process after undelete
     *      If implement AfterUndelete process, must override this process.
     * @param List<Object> newObjects
     * @author Nakano Shoki
     */
    public virtual void afterUndelete(List<Object> newObjects) {
        for(Object newObject : newObjects) {
            debug(newObject);
        }
    }
}