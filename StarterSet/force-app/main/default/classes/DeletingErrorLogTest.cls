@isTest(SeeAllData=false)
private class DeletingErrorLogTest {
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
}
