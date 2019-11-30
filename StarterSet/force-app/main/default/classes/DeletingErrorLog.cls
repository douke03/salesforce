/**
 * Class for schedule registration
 * @author Nakano Shoki
 */
global with sharing class DeletingErrorLog Implements Schedulable {
    public Interface SchedulableExecute {
        void execute(SchedulableContext sc);
    }
    global void execute(SchedulableContext sc) {
        String className = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        Type dataType = Type.forName(className + 'Processing');
        if(dataType!=null) {
            SchedulableExecute se = (SchedulableExecute)dataType.NewInstance();
            se.execute(sc);
        }
    }
}