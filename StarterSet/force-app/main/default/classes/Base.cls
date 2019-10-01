/**
 * Base for all classes
 * @author Nakano Shoki
 */
public with sharing virtual class Base {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    public String className = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    private String assert = '======== ';
    @TestVisible
    private Boolean isDebug = false;
    @TestVisible
    private Boolean isInfo  = false;
    @TestVisible
    private Boolean isWarn  = false;
    @TestVisible
    private Boolean isError = false;

    public Base() {
        info('Call: ' + className);
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
    }
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    /**
     * @description logger(level is DEBUG)
     *      This process outputs the received value.
     * @param Object
     * @author Nakano Shoki
     */
    public void debug(Object message) {
        if(isDebug) {
            System.debug(Logginglevel.DEBUG, assert + message);
        }
    }
    /**
     * @description logger(level is INFO)
     *      This process outputs the received value.
     * @param Object
     * @author Nakano Shoki
     */
    public void info(Object message) {
        if(isInfo) {
            System.debug(Logginglevel.INFO, assert + message);
        }
    }
    /**
     * @description logger(level is WARN)
     *      This process outputs the received value.
     * @param Object
     * @author Nakano Shoki
     */
    public void warn(Object message) {
        if(isWarn) {
            System.debug(Logginglevel.WARN, assert + message);
        }
    }
    /**
     * @description logger(level is ERROR)
     *      This process outputs the received value.
     * @param Object
     * @author Nakano Shoki
     */
    public void error(Object message) {
        if(isError) {
            System.debug(Logginglevel.ERROR, assert + message);
        }
    }
    /**
     * @description Exception Handler
     *      This process is a controller class for exception handling.
     * @param Exception
     * @author Nakano Shoki
     */
    public void exceptionHandler(Exception e) {
        error('e.getCause(): ' + e.getCause());
        error('e.getTypeName(): ' + e.getTypeName());
        error('e.getStackTraceString(): ' + e.getStackTraceString());
        error('e.getMessage(): ' + e.getMessage());
        saveExceptionLogRecord(e);
    }
    /**
     * @description Save Exception Info
     *      This process saves the received exception in an ErrorLog__c.
     * @param Exception
     * @return Boolean
     * @author Nakano Shoki
     */
    public void saveExceptionLogRecord(Exception e) {
        ErrorLog__c el = new ErrorLog__c(
            ExecutionUser__c = UserInfo.getUserId(),
            TypeName__c      = e.getTypeName(),
            StackTrace__c    = e.getStackTraceString(),
            LogMessage__c    = e.getMessage()
        );
        insert el;
    }
}