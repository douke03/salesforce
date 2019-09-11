@isTest(SeeAllData=false)
private class BaseTest {
    @isTest
    static void debugT01(){
        Base base = new Base();
        base.isDebug = true;
        base.debug('debug');
    }
    @isTest
    static void infoT01(){
        Base base = new Base();
        base.isInfo = true;
        base.info('info');
    }
    @isTest
    static void warnT01(){
        Base base = new Base();
        base.isWarn = true;
        base.warn('warn');
    }
    @isTest
    static void errorT01(){
        Base base = new Base();
        base.isError = true;
        base.error('error');
    }
    @isTest
    static void exceptionHandlerT01(){
        Try {
            Account a = new Account();
            insert a;
        } catch(Exception e) {
            Base base = new Base();
            Test.startTest();
            base.exceptionHandler(e);
            Test.stopTest();
            List<ErrorLog__c> elList = [
                SELECT Id
                FROM   ErrorLog__c
            ];
            System.assertEquals(1, elList.size());
        }
    }
}