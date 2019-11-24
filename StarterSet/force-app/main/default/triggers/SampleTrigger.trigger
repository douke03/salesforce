/**
 * This class is a sample implementation of Trigger Class.
 * @author Nakano Shoki
 */
trigger SampleTrigger on Sample__c (before insert, before update) {
    private String CLASS_NAME = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    Type dataType = Type.forName(CLASS_NAME.replace('Trigger', 'Handler'));
    TriggerHandler th = (TriggerHandler)dataType.newInstance();
    th.handle();
}