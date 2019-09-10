public class Validation extends Base {
    public class Testobj {
        Public String name;
        Public String foo;
        Public String bar;
    }
    public void test() {
        debug('Start');
        List<Testobj> testobj = new List<Testobj>();
        for (Integer i = 0; i < 2; i++) {
            Testobj test = new Testobj();
            test.name = 'name' + i;
            test.foo = 'foo' + i;
            test.bar = 'bar' + i;
            testobj.add(test);
        }
        debug('');
        for (testobj test : testobj) {
            debug(test);
        }
        debug('');
        for (testobj test : testobj) {
            test.name = 'change';
        }
        debug('');
        for (testobj test : testobj) {
            debug(test);
        }
    }
}