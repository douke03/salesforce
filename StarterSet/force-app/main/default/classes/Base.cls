/**
 * Base for all classes
 * @author Nakano Shoki
 */
public with sharing virtual class Base {
    @TestVisible
    private String className = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    private String assert = '========== ';
    // カスタムメタデータに持たせた方がいいかも？
    @TestVisible
    private Boolean isDebug = true;
    @TestVisible
    private Boolean isInfo = true;
    @TestVisible
    private Boolean isWarn = true;
    @TestVisible
    private Boolean isError = true;
    /**
     * @description Constructor
     * @author Nakano Shoki
     */
    public Base() {
        info('Call: ' + className);
    }
    /**
     * @description logger
     *      Logging level is DEBUG
     * @param message
     * @return None
     * @author Nakano Shoki
     */
    public void debug(Object message) {
        if(isDebug) {
            System.debug(Logginglevel.DEBUG, assert + message);
        }
    }
    /**
     * @description logger
     *      Logging level is INFO
     * @param message
     * @return None
     * @author Nakano Shoki
     */
    public void info(Object message) {
        if(isInfo) {
            System.debug(Logginglevel.INFO, assert + message);
        }
    }
    /**
     * @description logger
     *      Logging level is WARN
     * @param message
     * @return None
     * @author Nakano Shoki
     */
    public void warn(Object message) {
        if(isWarn) {
            System.debug(Logginglevel.WARN, assert + message);
        }
    }
    /**
     * @description logger
     *      Logging level is ERROR
     * @param message
     * @return None
     * @author Nakano Shoki
     */
    public void error(Object message) {
        if(isError) {
            System.debug(Logginglevel.ERROR, assert + message);
        }
    }
    /**
     * @description Exception Handler
     *      Insert Plattform Event
     * @param e
     * @return None
     * @author Nakano Shoki
     */
    public void exceptionHandler(Exception e) {
        error('e.getCause(): ' + e.getCause());
        error('e.getTypeName(): ' + e.getTypeName());
        error('e.getStackTraceString(): ' + e.getStackTraceString());
        error('e.getMessage(): ' + e.getMessage());
        ExceptionNotification__e en = new ExceptionNotification__e(
            ExecutionUserID__c = UserInfo.getUserId(),
            TypeName__c        = e.getTypeName(),
            StackTrace__c      = e.getStackTraceString(),
            Message__c         = e.getMessage()
        );
        Database.SaveResult sr = EventBus.publish(en);
    }
}