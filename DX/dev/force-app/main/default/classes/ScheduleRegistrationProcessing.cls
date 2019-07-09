/**
 * スケジュール登録用クラスの処理クラス
 * スケジュール登録用クラスの処理部分を担う。(今回の場合はScheduleRegistration.cls)
 * スケジュール登録後も呼び出し元クラスが直接参照していないので自由に編集可能。
 * 試してはないが変更セットを利用したアップデートも可能かと思われる。
 * ※このコメントはスケジュール登録後に追加した。
 */
public class ScheduleRegistrationProcessing implements ScheduleRegistration.SchedulableExecute, Database.Batchable<sObject>, Database.Stateful {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    @TestVisible
    private final Integer BATCH_SIZE = 200;
    public Integer cntSuccess = 0;
    //-------------------------------------------------------
    // Schedulable
    //-------------------------------------------------------
    public void Execute(SchedulableContext sc) {
        System.debug('====================================');
        System.debug('========== Start ScheduleRegistrationProcessing Schedulable:execute');
        ScheduleRegistrationProcessing batch = new ScheduleRegistrationProcessing();
        Database.executeBatch(batch, BATCH_SIZE);
    }
    //-------------------------------------------------------
    // Batch
    //-------------------------------------------------------
    public Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('====================================');
        System.debug('========== Start ScheduleRegistrationProcessing Batch:start');

        String query = ' SELECT Id' +
                       ' FROM   User' +
                       ' ORDER BY Id';
        System.debug('========== query : ' + query);
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<User> userList) {
        System.debug('====================================');
        System.debug('========== Start ScheduleRegistrationProcessing Batch:execute');
        try {
            System.debug('バッチ処理');
            cntSuccess ++;
        } catch(Exception e) {
            System.debug('========== Exception : ' + e);
        }
    }
    public void finish(Database.BatchableContext bc) {
        System.debug('====================================');
        System.debug('========== Start ScheduleRegistrationProcessing Batch:finish');
        AsyncApexJob apexJob = [SELECT Status,
                                       TotalJobItems,
                                       NumberOfErrors
                                FROM   AsyncApexJob
                                WHERE  Id = :bc.getJobId()];
        if(apexJob.Status == 'Completed') {
            if(apexJob.TotalJobItems == cntSuccess) {
                System.debug('========== finished ScheduleRegistrationProcessing');
            }
            System.debug('========== TotalJobItems : '  + apexJob.TotalJobItems);
            System.debug('========== NumberOfErrors : ' + apexJob.NumberOfErrors);
        } else {
            System.debug(logginglevel.ERROR, '========== Failed ScheduleRegistrationProcessing');
            System.debug(logginglevel.ERROR, '========== Batch Status : ' + apexJob.Status);
        }
    }
}