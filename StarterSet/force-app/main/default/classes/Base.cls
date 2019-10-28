/**
 * Base for all classes
 * @author Nakano Shoki
 */
public with sharing virtual class Base {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    public final String className = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    private final String indent = ' ';
    private final Boolean isDebug, isInfo, isWarn, isError;
    public final Boolean isTest = Test.isRunningTest();

    public Base() {
        List<ActiveSetting__mdt> activeSetttingList = [
            SELECT Id,
                   DeveloperName,
                   isActive__c
            FROM   ActiveSetting__mdt
            WHERE  DeveloperName Like 'L_%'
        ];
        for(ActiveSetting__mdt activeSetting : activeSetttingList) {
            switch on activeSetting.DeveloperName {
                when 'L_Debug' {isDebug = activeSetting.isActive__c;}
                when 'L_Info'  {isInfo  = activeSetting.isActive__c;}
                when 'L_Warn'  {isWarn  = activeSetting.isActive__c;}
                when 'L_Error' {isError = activeSetting.isActive__c;}
                when else {
                    warn(activeSetting.DeveloperName);
                }
            }
        }
        info('Class: ' + className);
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
    public void debug(Object message) {
        if(isDebug || isTest) {
            logger(Logginglevel.DEBUG, message);
        }
    }
    /**
     * @description logger(level is INFO)
     *      This process outputs the received value.
     * @param Object message
     * @author Nakano Shoki
     */
    public void info(Object message) {
        if(isInfo || isTest) {
            logger(Logginglevel.INFO, message);
        }
    }
    /**
     * @description logger(level is WARN)
     *      This process outputs the received value.
     * @param Object message
     * @author Nakano Shoki
     */
    public void warn(Object message) {
        if(isWarn || isTest) {
            logger(Logginglevel.WARN, message);
        }
    }
    /**
     * @description logger(level is ERROR)
     *      This process outputs the received value.
     * @param Object message
     * @author Nakano Shoki
     */
    public void error(Object message) {
        if(isError || isTest) {
            logger(Logginglevel.ERROR, message);
        }
    }
    /**
     * @description logger
     *      This process outputs the received value.
     * @param LoggingLevel loggingLevel
     * @param Object message
     * @author Nakano Shoki
     */
    private void logger(LoggingLevel loggingLevel, Object message) {
        System.debug(loggingLevel, message);
        // System.debug(logLevel, logLevel.rightPad(6) + now() + indent + message);
    }
    /**
     * @description Return the current local time
     *      This process return the current local time.
     * @return String(yyyy-mm-dd hh:mm:ss)
     * @author Nakano Shoki
     */
    private String now() {
        return Datetime.now().format('yyyy-mm-dd hh:mm:ss');
    }
    /**
     * @description Exception Handler
     *      This process is a controller class for exception handling.
     * @param Exception e
     * @author Nakano Shoki
     */
    public void exceptionHandler(Exception e) {
        error('Exception.getCause(): ' + e.getCause());
        error('Exception.getTypeName(): ' + e.getTypeName());
        error('Exception.getStackTraceString(): ' + e.getStackTraceString());
        error('Exception.getMessage(): ' + e.getMessage());
        saveExceptionLogRecord(e);
    }
    /**
     * @description Save Exception Info
     *      This process saves the received exception in a platform event.
     *      Tips:If you use addError(...), a rollback is performed and you cannot insert an error log or send an email.
     *           However, Platform Event registrations are not rolled back.
     * @param Exception e
     * @author Nakano Shoki
     */
    public void saveExceptionLogRecord(Exception e) {
        ExceptionNotification__e en = new ExceptionNotification__e(
            ExecutionUserID__c = UserInfo.getUserId(),
            TypeName__c        = e.getTypeName(),
            StackTrace__c      = e.getStackTraceString(),
            Message__c         = e.getMessage()
        );
        EventBus.publish(en);
    }
}