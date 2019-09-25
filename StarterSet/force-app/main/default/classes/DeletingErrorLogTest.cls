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
    static void deletingErrorLogT01() {
        Test.startTest();
        System.runAs(testUser) {
            String jobId = System.schedule('TestScheduledApex', '0 0 * * * ?', new DeletingErrorLog());
        }
        Test.stopTest();
    }
    @isTest
    static void deletingErrorLogProcessingT01() {
        DeletingErrorLogProcessing batchable = new DeletingErrorLogProcessing();
        List<ErrorLog__c> elList = new List<ErrorLog__c>();
        for(Integer i = 0; i < 2; i++) {
            ErrorLog__c el = new ErrorLog__c();
            elList.add(el);
        }
        insert elList;
        Date d = date.today().addMonths(- batchable.MONTH_TO_KEEP_LOG);
        Datetime baseDateToDelete = Datetime.newInstance(d.year(), d.month(), d.day());
        for(Integer i = 0, j = elList.size(); i < j; i++) {
            Test.setCreatedDate(elList.get(i).Id, baseDateToDelete.addDays(i));
        }
        Test.startTest();
        System.runAs(testUser) {
            Database.executeBatch(batchable);
        }
        Test.stopTest();
        List<ErrorLog__c> afterElList = [SELECT ID FROM ErrorLog__c];
        System.assertequals(1, afterElList.size());
    }
}