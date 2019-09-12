/**
 * Base for all Batch classes
 * @author Nakano Shoki
 */
public with sharing virtual class BaseBatch extends Base implements Database.Stateful {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    public Integer cntSuccessfulCompletion = 0;
    private final String JOB_STATUS_COMPLETED = 'Completed';
    /**
     * @description Constructor
     * @author Nakano Shoki
     */
    public BaseBatch() {
    }
    //-------------------------------------------------------
    // Main
    //-------------------------------------------------------
    /**
     * @description Batch processing end judgment processing
     * @param jobId(Database.BatchableContext.getJobId())
     * @return Boolean
     * @author Nakano Shoki
     */
    public Boolean isSuccessfulCompletion(ID jobId) {
        Boolean isSuccess = true;
        AsyncApexJob apexJob = [
            SELECT Status,
                   TotalJobItems,
                   NumberOfErrors
            FROM   AsyncApexJob
            WHERE  Id = :jobId
        ];
        if(apexJob.Status == JOB_STATUS_COMPLETED) {
            // execute実行回数と正常終了回数がequalであれば全ての処理が正常に終了していると判断できる
            if(apexJob.TotalJobItems == cntSuccessfulCompletion) {
                info('finished SampleBatch');
                info('TotalJobItems : '  + apexJob.TotalJobItems);
                info('NumberOfErrors : ' + apexJob.NumberOfErrors);
            } else {
                warn('TotalJobItems : '  + apexJob.TotalJobItems);
                warn('NumberOfErrors : ' + apexJob.NumberOfErrors);
                isSuccess = false;
            }
        } else {
            error('Failed SampleBatch');
            error('Batch Status : ' + apexJob.Status);
            isSuccess = false;
        }
        return isSuccess;
    }
}