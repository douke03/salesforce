@isTest(SeeAllData=false)
private class BaseTest {
    //-------------------------------------------------------
    // Variables
    //-------------------------------------------------------
    private static User testUser;
    //-------------------------------------------------------
    // testSetup
    //-------------------------------------------------------
    @testSetup
    static void setup() {
        testUser = TDF.testUser(TDF.PROFILE_SYSTEM_ADMINISTRATOR);
        insert testUser;
    }
    //-------------------------------------------------------
    // test
    //-------------------------------------------------------
    @isTest
    static void debugT01(){
        System.runAs(testUser) {
            Base base = new Base();
            base.isDebug = true;
            base.debug('debug');
        }
    }
    @isTest
    static void infoT01(){
        System.runAs(testUser) {
            Base base = new Base();
            base.isInfo = true;
            base.info('info');
        }
    }
    @isTest
    static void warnT01(){
        System.runAs(testUser) {
            Base base = new Base();
            base.isWarn = true;
            base.warn('warn');
        }
    }
    @isTest
    static void errorT01(){
        System.runAs(testUser) {
            Base base = new Base();
            base.isError = true;
            base.error('error');
        }
    }
    @isTest
    static void exceptionHandlerT01(){
        System.runAs(testUser) {
            Test.startTest();
            List<ErrorLog__c> elList = new List<ErrorLog__c>();
            Try {
                Account a = new Account();
                insert a;
            } catch(Exception e) {
                Base base = new Base();
                base.exceptionHandler(e);
                elList = [
                    SELECT Id
                    FROM   ErrorLog__c
                ];
            }
            System.assertEquals(1, elList.size());
            Test.stopTest();
        }
    }
}