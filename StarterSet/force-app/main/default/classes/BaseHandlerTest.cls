@isTest(SeeAllData=false)
private class BaseHandlerTest {
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
    static void handleT01() {
        System.runAs(testUser) {
            BaseHandler bh = new BaseHandler();
            bh.handle();
        }
    }
}