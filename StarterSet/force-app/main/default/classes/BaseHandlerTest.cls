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
    @isTest
    static void beforeInsertT01() {
        Account acc = TDF.accountInstance('test');
        insert acc;
        List<Account> accList = new List<Account>();
        accList.add(acc);
        System.runAs(testUser) {
            BaseHandler bh = new BaseHandler();
            bh.beforeInsert(accList);
        }
    }
    @isTest
    static void beforeUpdateT01() {
        Account acc = TDF.accountInstance('test');
        insert acc;
        Map<ID, Account> accMap = new Map<ID, Account>();
        accMap.put(acc.ID, acc);
        System.runAs(testUser) {
            BaseHandler bh = new BaseHandler();
            bh.beforeUpdate(accMap, accMap);
        }
    }
    @isTest
    static void beforeDeleteT01() {
        Account acc = TDF.accountInstance('test');
        insert acc;
        List<Account> accList = new List<Account>();
        accList.add(acc);
        System.runAs(testUser) {
            BaseHandler bh = new BaseHandler();
            bh.beforeDelete(accList);
        }
    }
    @isTest
    static void afterInsertT01() {
        Account acc = TDF.accountInstance('test');
        insert acc;
        List<Account> accList = new List<Account>();
        accList.add(acc);
        System.runAs(testUser) {
            BaseHandler bh = new BaseHandler();
            bh.afterInsert(accList);
        }
    }
    @isTest
    static void afterUpdateT01() {
        Account acc = TDF.accountInstance('test');
        insert acc;
        Map<ID, Account> accMap = new Map<ID, Account>();
        accMap.put(acc.ID, acc);
        System.runAs(testUser) {
            BaseHandler bh = new BaseHandler();
            bh.afterUpdate(accMap, accMap);
        }
    }
    @isTest
    static void afterDeleteT01() {
        Account acc = TDF.accountInstance('test');
        insert acc;
        List<Account> accList = new List<Account>();
        accList.add(acc);
        System.runAs(testUser) {
            BaseHandler bh = new BaseHandler();
            bh.afterDelete(accList);
        }
    }
    @isTest
    static void afterUndeleteT01() {
        Account acc = TDF.accountInstance('test');
        insert acc;
        List<Account> accList = new List<Account>();
        accList.add(acc);
        System.runAs(testUser) {
            BaseHandler bh = new BaseHandler();
            bh.afterUndelete(accList);
        }
    }
}