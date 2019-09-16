/**
 * Implement class to call handler
 * @author Nakano Shoki
 */
trigger ExceptionNotificationTrigger on ExceptionNotification__e (after insert) {
    private String className = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    Type t = Type.forName(className.replace('Trigger', 'Handler'));
    TriggerHandler handler = (TriggerHandler)t.newInstance();
    handler.handle();
}