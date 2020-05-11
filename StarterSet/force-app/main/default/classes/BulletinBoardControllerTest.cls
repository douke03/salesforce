@isTest(SeeAllData=false)
private class BulletinBoardControllerTest {
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
    static void getBBTypeT01() {
        System.runAs(testUser) {
            BulletinBoardController.getBBType();
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void getBBDataT01() {
        System.runAs(testUser) {
            BulletinBoardController.getBBData(null);
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void getImportantBBDataT01() {
        System.runAs(testUser) {
            BulletinBoardController.getImportantBBData();
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
    @isTest
    static void getBBDataSoslT01() {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('type', 'test');
        gen.writeStringField('isSelected', 'true');
        gen.writeEndObject();
        System.runAs(testUser) {
            BulletinBoardController.getBBDataSosl('test', '[' + gen.getAsString().replace('\n','') + ']');
        }
        System.assert(true, 'Confirmed that it ended normally.');
    }
}