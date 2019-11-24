/**
 * Implement class to call handler
 * @author Nakano Shoki
 */
trigger ExceptionNotificationTrigger on ExceptionNotification__e (after insert) {
    private String CLASS_NAME = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    Type dataType = Type.forName(CLASS_NAME.replace('Trigger', 'Handler'));
    TriggerHandler th = (TriggerHandler)dataType.newInstance();
    th.handle();
}