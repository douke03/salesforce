public class Verification extends Base{
    public void decimalSample() {
        Decimal decA;
        Decimal decB;
        decA = null;
        decB = -999999999;
        System.debug('decA: ' + decA);
        System.debug('decB: ' + decB);
        try {
            // null > -999999999
            if(decA > decB) {
                System.debug('foo');
            } else {
                System.debug('bar');
            }
            // bar
            // ======================
            // -999999999 > null
            if(decB > decA) {
                System.debug('foo');
            } else {
                System.debug('bar');
            }
            // bar
        } catch(Exception e) {
            // Exceptionは出力せず
            System.debug('Exception');
            System.debug(e.getMessage());
        }
    }
    public void integerSample() {
        Integer intA;
        Integer intB;
        intA = null;
        intB = -999999999;
        System.debug('intA: ' + intA);
        System.debug('intB: ' + intB);
        try {
            // null > -999999999
            if(intA > intB) {
                System.debug('foo');
            } else {
                System.debug('bar');
            }
            // bar
            // ======================
            // -999999999 > null
            if(intB > intA) {
                System.debug('foo');
            } else {
                System.debug('bar');
            }
            // bar
            // System.debug('2/0' + 2/0);
            Integer test = null;
            System.debug('2/null' + 2/test);
        } catch(Exception e) {
            // Exceptionは出力せず
            System.debug('Exception');
            System.debug(e.getMessage());
        }
    }

    public void listSample() {
        List<Integer> intList = new List<Integer>();
        intList.add(1);
        intList.add(2);
        intList.add(3);
        Debug(intList);
        Integer i = 0;
        while(i < intList.size()) {
            Debug('i: ' + i);
            Debug('int: ' + intList[i]);
            if(intList[i] == 2) {
                intList.remove(i);
            } else {
                i++;
            }
        }
        Debug(intList);
    }
    public void nullSample() {
        Date day;
        if(day ==null) {
            Debug('day = null');
        } else {
            Debug('day = ' + day);
        }
    }
}