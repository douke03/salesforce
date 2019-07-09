/**
 * スケジュール登録用のクラス
 * ジョブ登録時にこのクラスを指定する。
 * スケジュール登録後、このクラスはスケジュール削除しない限り編集できない。
 */
global class ScheduleRegistration Implements Schedulable {
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