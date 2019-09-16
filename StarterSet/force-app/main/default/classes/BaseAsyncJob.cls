/**
 * Base for all AsyncJob classes
 * @author Nakano Shoki
 */
public with sharing virtual class BaseAsyncJob extends Base implements Database.Stateful {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    public Integer cntSuccessfulCompletion = 0;
    private final String JOB_STATUS_COMPLETED = 'Completed';
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    /**
     * @description Batch processing end judgment processing
     *      This process searches the processing result with the received job ID and saves the contents in AsyncJobExecutionResult__c.
     *      And returns the success or failure of the saves process.
     * @param ID
     * @return Boolean
     * @author Nakano Shoki
     */
    public Boolean isSuccessfulCompletion(ID jobId) {
        Boolean isSuccess = true;
        AsyncApexJob apexJob = [
            SELECT JobType,
                   Status,
                   CompletedDate,
                   ApexClassID,
                   MethodName,
                   JobItemsProcessed,
                   TotalJobItems,
                   NumberOfErrors
            FROM   AsyncApexJob
            WHERE  Id = :jobId
        ];
        if(apexJob.Status != JOB_STATUS_COMPLETED) {
            isSuccess = false;
        } else {
            if(apexJob.TotalJobItems != cntSuccessfulCompletion) {
                isSuccess = false;
            }
        }
        info('');
        info('JobType : '  + apexJob.JobType);
        info('Status : '  + apexJob.Status);
        info('CompletedDate : '  + apexJob.CompletedDate);
        info('ApexClassID : '  + apexJob.ApexClassID);
        info('MethodName : '  + apexJob.MethodName);
        info('JobItemsProcessed : '  + apexJob.JobItemsProcessed);
        info('TotalJobItems : '  + apexJob.TotalJobItems);
        info('NumberOfErrors : '  + apexJob.NumberOfErrors);
        return isSuccess;
    }
}