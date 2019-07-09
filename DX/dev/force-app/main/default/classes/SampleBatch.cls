/**
 * ■ apexバッチの正常終了検知について
 *
 * 以下のバッチクラスはユーザ数と同じ数だけ
 * バッチのexecute句が実行され、必ずエラーが発生します。
 *
 * バッチが正常終了したか、AsyncApexJobオブジェクトの内容を確認することで判断できます。
 * AsyncApexJob.Status         = バッチの状態
 * AsyncApexJob.TotalJobItems  = execute句が実行された回数
 * AsyncApexJob.NumberOfErrors = 実行したexecute句のうち、想定外の例外が発生した回数
 *
 * 例外が発生しようが、想定外の例外が発生しようが、バッチの実行が完了した時点で
 * 【Status】は[Completed]を応答します。
 * 【NumberOfErrors】は想定外の例外が発生した場合でしかカウントアップしません。
 * 以下のコードだとexecute句は毎回失敗しますが、【NumberOfErrors】の回数は[0]のままです。
 * バッチが正常終了したかを確認したいが、try-catchを使用したい場合、
 * クラス変数に正常終了回数を保持させ、finally句で【TotalJobItems】と比較することをお勧めします。
 */
global class SampleBatch implements Schedulable, Database.Batchable<sObject>, Database.Stateful {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    private final Integer BATCH_SIZE = 1;
    public Integer cntSuccess = 0;
    //-------------------------------------------------------
    // Schedulable
    //-------------------------------------------------------
    global void execute(SchedulableContext ctx){
        System.debug('====================================');
        System.debug('========== Start SampleBatch Schedulable:execute');
        SampleBatch batch = new SampleBatch();
        Database.executeBatch(batch, BATCH_SIZE);
    }
    //-------------------------------------------------------
    // Batch
    //-------------------------------------------------------
    public Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('====================================');
        System.debug('========== Start SampleBatch Batch:start');

        String query = ' SELECT Id' +
                       ' FROM   User' +
                       ' ORDER BY Id';
        System.debug('========== query : ' + query);
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<User> userList) {
        System.debug('====================================');
        System.debug('========== Start SampleBatch Batch:execute');
        try {
            System.debug('========== userList.Name : ' + userList[0].Name);
            // execute処理の最後で正常終了回数をカウントアップ
            cntSuccess ++;
        } catch(Exception e) {
            System.debug('========== Exception : ' + e);
        }
    }
    public void finish(Database.BatchableContext bc) {
        System.debug('====================================');
        System.debug('========== Start SampleBatch Batch:finish');
        AsyncApexJob apexJob = [SELECT Status,
                                       TotalJobItems,
                                       NumberOfErrors
                                FROM   AsyncApexJob
                                WHERE  Id = :bc.getJobId()];
        if(apexJob.Status == 'Completed') {
            // execute実行回数と正常終了回数がequalであれば全ての処理が正常に終了していると判断できる
            if(apexJob.TotalJobItems == cntSuccess) {
                System.debug('========== finished SampleBatch');
            }
            System.debug('========== TotalJobItems : '  + apexJob.TotalJobItems);
            System.debug('========== NumberOfErrors : ' + apexJob.NumberOfErrors);
        } else {
            System.debug(logginglevel.ERROR, '========== Failed SampleBatch');
            System.debug(logginglevel.ERROR, '========== Batch Status : ' + apexJob.Status);
        }
    }
}