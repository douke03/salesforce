@isTest(SeeAllData=false)
private class DeletingErrorLogTest {
    //-------------------------------------------------------
    // Variables
    //-------------------------------------------------------
    private static User testUser = TDF.testUser(TDF.PROFILE_SYSTEM_ADMINISTRATOR);
    //-------------------------------------------------------
    // testSetup
    //-------------------------------------------------------
    @testSetup
    static void setup() {
    }
    //-------------------------------------------------------
    // test
    //-------------------------------------------------------
    @isTest
    static void deletingErrorLogT01(){
        System.runAs(testUser) {
            Test.startTest();
            String jobId = System.schedule('TestScheduledApex', '0 0 * * * ?', new DeletingErrorLog());
            Test.stopTest();
        }
    }
}