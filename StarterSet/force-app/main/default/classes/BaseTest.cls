@isTest(SeeAllData=false)
private class BaseTest {
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
            Base base = new Base();
            base.isDebug = true;
            base.debug('debug');
        }
    }
    @isTest
    static void infoT01() {
        System.runAs(testUser) {
            Base base = new Base();
            base.isInfo = true;
            base.info('info');
        }
    }
    @isTest
    static void warnT01() {
        System.runAs(testUser) {
            Base base = new Base();
            base.isWarn = true;
            base.warn('warn');
        }
    }
    @isTest
    static void errorT01() {
        System.runAs(testUser) {
            Base base = new Base();
            base.isError = true;
            base.error('error');
        }
    }
    @isTest
    static void exceptionHandlerT01() {
        System.runAs(testUser) {
            Test.startTest();
            Try {
                Account a = new Account();
                insert a;
            } catch(Exception e) {
                Base base = new Base();
                base.exceptionHandler(e);
            }
            Test.stopTest();
        }
    }
    @isTest
    static void saveExceptionLogRecordT01() {
        Boolean isSuccess = false;
        System.runAs(testUser) {
            Test.startTest();
            Try {
                Account a = new Account();
                insert a;
            } catch(Exception e) {
                Base base = new Base();
                base.saveExceptionLogRecord(e);
            }
            Test.stopTest();
        }
    }
}