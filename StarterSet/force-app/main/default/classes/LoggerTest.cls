@isTest(SeeAllData=false)
private class LoggerTest {
    //-------------------------------------------------------
    // Variables & Setup
    //-------------------------------------------------------
    private static User testUser = TDF.testUser(TDF.PROFILE_SYSTEM_ADMINISTRATOR);

    @testSetup
    static void setup() {
    }
    //-------------------------------------------------------
    // Testing part
    //-------------------------------------------------------
    @isTest
    static void debugT01() {
        System.runAs(testUser) {
            Logger logger = new Logger();
            logger.debug(Logginglevel.DEBUG, 'debug');
        }
    }
    @isTest
    static void debugT02() {
        System.runAs(testUser) {
            Logger logger = new Logger();
            logger.debug(Logginglevel.INFO, 'info');
        }
    }
    @isTest
    static void debugT03() {
        System.runAs(testUser) {
            Logger logger = new Logger();
            logger.debug(Logginglevel.WARN, 'warn');
        }
    }
    @isTest
    static void debugT04() {
        System.runAs(testUser) {
            Logger logger = new Logger();
            logger.debug(Logginglevel.ERROR, 'error');
        }
    }
}