/**
 * Class for schedule registration
 * @author Nakano Shoki
 */
global with sharing class DeletingErrorLog Implements Schedulable {
    public Interface SchedulableExecute {
        void execute(SchedulableContext sc);
    }
    global void execute(SchedulableContext sc) {
        String CLASS_NAME = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        Type dataType = Type.forName(CLASS_NAME + 'Processing');
        if(dataType!=null) {
            SchedulableExecute se = (SchedulableExecute)dataType.NewInstance();
            se.execute(sc);
        }
    }
}