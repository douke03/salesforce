@isTest(SeeAllData=false)
private class BaseTest {
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
            Base.debug('debug');
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void infoT01() {
        System.runAs(testUser) {
            Base.info('info');
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void warnT01() {
        System.runAs(testUser) {
            Base.warn('warn');
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void errorT01() {
        System.runAs(testUser) {
            Base.error('error');
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void exceptionHandlerT01() {
        System.runAs(testUser) {
            Test.startTest();
            Try {
                Account a = new Account();
                insert a;
            } catch(Exception e) {
                Base.exceptionHandler(e);
            }
            Test.stopTest();
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void saveExceptionInfoT01() {
        Boolean isSuccess = false;
        System.runAs(testUser) {
            Test.startTest();
            Try {
                Account a = new Account();
                insert a;
            } catch(Exception e) {
                Base.saveExceptionInfo(e);
            }
            Test.stopTest();
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
}