/**
 * Deleting Error Log
 * @author Nakano Shoki
 */
global with sharing class DeletingErrorLog Implements Schedulable {
    public Interface SchedulableExecute {
        void execute(SchedulableContext sc);
    }
    global void execute(SchedulableContext sc) {
        String className = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        Type targettype = Type.forName(className + 'Processing');
        if(targettype!=null) {
            SchedulableExecute obj = (SchedulableExecute)targettype.NewInstance();
            obj.execute(sc);
        }
    }
}