/**
 * This class is a sample implementation of Trigger Class.
 * @author Nakano Shoki
 */
trigger SampleTrigger on Sample__c (before insert) {
    private String className = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    Type dataType = Type.forName(className.replace('Trigger', 'Handler'));
    TriggerHandler th = (TriggerHandler)dataType.newInstance();
    th.handle();
}