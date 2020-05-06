/**
 * Base for all classes
 * @author Nakano Shoki
 */
public with sharing virtual class Base {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    public final String CLASS_NAME = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));

    public Base() {
        info('Class: ' + CLASS_NAME);
    }
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    /**
     * @description logger(level is DEBUG)
     *      This process outputs the received value.
     * @param Object message
     * @author Nakano Shoki
     */
    public static void debug(Object message) {
        Logger.debug(Logginglevel.DEBUG, message);
    }
    /**
     * @description logger(level is INFO)
     *      This process outputs the received value.
     * @param Object message
     * @author Nakano Shoki
     */
    public static void info(Object message) {
        Logger.debug(Logginglevel.INFO, message);
    }
    /**
     * @description logger(level is WARN)
     *      This process outputs the received value.
     * @param Object message
     * @author Nakano Shoki
     */
    public static void warn(Object message) {
        Logger.debug(Logginglevel.WARN, message);
    }
    /**
     * @description logger(level is ERROR)
     *      This process outputs the received value.
     * @param Object message
     * @author Nakano Shoki
     */
    public static void error(Object message) {
        Logger.debug(Logginglevel.ERROR, message);
    }
    /**
     * @description Exception Handler
     *      This process is a controller method for exception handling.
     * @param Exception e
     * @author Nakano Shoki
     */
    public static void exceptionHandler(Exception e) {
        error('Exception.getCause(): ' + e.getCause());
        error('Exception.getTypeName(): ' + e.getTypeName());
        error('Exception.getStackTraceString(): ' + e.getStackTraceString());
        error('Exception.getMessage(): ' + e.getMessage());
        saveExceptionInfo(e);
        // sendAlertEMail(e);
    }
    /**
     * @description Save Exception Info
     *      This process saves the received exception info in a platform event.
     *      Tips:If you use addError(...), a rollback is performed and you cannot insert a record or send an email.
     *           However, Platform Event registrations are not rolled back.
     * @param Exception e
     * @author Nakano Shoki
     */
    public static void saveExceptionInfo(Exception e) {
        ExceptionNotification__e en = new ExceptionNotification__e(
            ExecutionUserID__c = UserInfo.getUserId(),
            TypeName__c        = e.getTypeName(),
            StackTrace__c      = e.getStackTraceString(),
            Message__c         = e.getMessage()
        );
        EventBus.publish(en);
    }
}