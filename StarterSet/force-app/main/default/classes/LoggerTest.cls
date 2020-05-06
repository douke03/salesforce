@isTest(SeeAllData=false)
private class LoggerTest {
    //-------------------------------------------------------
    // Variables & Setup
    //-------------------------------------------------------
    private static User testUser = TDF.testUser(TDF.PROFILE_SYSTEM_ADMINISTRATOR);

    // @testSetup
    // static void setup() {
    // }
    //-------------------------------------------------------
    // Testing part
    //-------------------------------------------------------
    @isTest
    static void debugT01() {
        System.runAs(testUser) {
            Logger.debug(Logginglevel.DEBUG, 'debug');
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void debugT02() {
        System.runAs(testUser) {
            Logger.debug(Logginglevel.INFO, 'info');
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void debugT03() {
        System.runAs(testUser) {
            Logger.debug(Logginglevel.WARN, 'warn');
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void debugT04() {
        System.runAs(testUser) {
            Logger.debug(Logginglevel.ERROR, 'error');
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
}