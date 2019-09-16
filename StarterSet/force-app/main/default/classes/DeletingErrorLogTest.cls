@isTest(SeeAllData=false)
private class DeletingErrorLogTest {
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
    static void deletingErrorLogT01(){
        Test.startTest();
        System.runAs(testUser) {
            String jobId = System.schedule('TestScheduledApex', '0 0 * * * ?', new DeletingErrorLog());
        }
        Test.stopTest();
    }
    @isTest
    static void deletingErrorLogeEecuteT01(){
        ErrorLog__c el = new ErrorLog__c();
        insert el;
        Test.startTest();
        System.runAs(testUser) {
            DeletingErrorLogProcessing batchable = new DeletingErrorLogProcessing();
            Database.executeBatch(batchable);
        }
        Test.stopTest();
    }
}