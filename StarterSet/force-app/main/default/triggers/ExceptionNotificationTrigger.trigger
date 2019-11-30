/**
 * Implement class to call handler
 * @author Nakano Shoki
 */
trigger ExceptionNotificationTrigger on ExceptionNotification__e (after insert) {
    private String className = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    Type dataType = Type.forName(className.replace('Trigger', 'Handler'));
    TriggerHandler th = (TriggerHandler)dataType.newInstance();
    th.handle();
}