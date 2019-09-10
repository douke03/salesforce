@isTest(SeeAllData=false)
private class BaseTest {
    @isTest
    static void test001(){
        Base base = new Base();
        base.isDebug = true;
        base.isInfo = true;
        base.isWarn = true;
        base.isError = true;
        base.debug('debug');
        base.info('info');
        base.warn('warn');
        base.error('error');
        System.assertEquals('Base', base.className);
    }
}