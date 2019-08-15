trigger AccountTrigger on Account (before insert, before delete) {
    private String className = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    Type t = Type.forName(className.replace('Trigger', 'Handler'));
    TriggerHandler handler = (TriggerHandler)t.newInstance();
    handler.handle();
}