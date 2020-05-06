/**
 * Logger classes
 * @author Nakano Shoki
 */
public with sharing class Logger {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    private static final Boolean IS_DEBUG, IS_INFO, IS_WARN, IS_ERROR;
    private static final Boolean IS_TEST = Test.isRunningTest();

    static {
        List<ActiveSetting__mdt> activeSetttingList = [
            SELECT Id,
                   DeveloperName,
                   isActive__c
            FROM   ActiveSetting__mdt
            WHERE  DeveloperName Like 'L_%'
        ];
        for(ActiveSetting__mdt activeSetting : activeSetttingList) {
            switch on activeSetting.DeveloperName {
                when 'L_Debug' {IS_DEBUG = activeSetting.isActive__c;}
                when 'L_Info'  {IS_INFO  = activeSetting.isActive__c;}
                when 'L_Warn'  {IS_WARN  = activeSetting.isActive__c;}
                when 'L_Error' {IS_ERROR = activeSetting.isActive__c;}
                when else {
                    debug(Logginglevel.WARN, activeSetting.DeveloperName);
                }
            }
        }
    }
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    /**
     * @description debug
     *      This process outputs the received value.
     * @param LoggingLevel loggingLevel
     * @param Object message
     * @author Nakano Shoki
     */
    public static void debug(LoggingLevel loggingLevel, Object message) {
        switch on loggingLevel {
            when DEBUG {
                if(IS_DEBUG || IS_TEST) {
                    System.debug(loggingLevel, message);
                }
            }
            when INFO {
                if(IS_INFO || IS_TEST) {
                    System.debug(loggingLevel, message);
                }
            }
            when WARN {
                if(IS_WARN || IS_TEST) {
                    System.debug(loggingLevel, message);
                }
            }
            when ERROR {
                if(IS_ERROR || IS_TEST) {
                    System.debug(loggingLevel, message);
                }
            }
            when else {
                // none
            }
        }
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
}