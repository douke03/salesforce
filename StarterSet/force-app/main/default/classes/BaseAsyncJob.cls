/**
 * Base for all AsyncJob classes
 * @author Nakano Shoki
 */
public with sharing virtual class BaseAsyncJob extends Base implements Database.Stateful {
    //-------------------------------------------------------
    // CustomException & Variables
    //-------------------------------------------------------
    public class AsyncJobException extends Exception {}
    public Boolean isActiveAsyncJob = true;
    private final String JOB_STATUS_COMPLETED = 'Completed';

    public BaseAsyncJob() {
        String masterLabel = 'A_' + className;
        List<ActiveSetting__mdt> activeSetttingList = [
            SELECT Id,
                   DeveloperName,
                   isActive__c
            FROM   ActiveSetting__mdt
            WHERE  DeveloperName = 'A_All'
               OR  DeveloperName = :masterLabel
        ];
        for(ActiveSetting__mdt activeSetting : activeSetttingList) {
            if(!activeSetting.isActive__c) {
                isActiveAsyncJob = false;
                break;
            }
        }
    }
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    /**
     * @description Batch processing end judgment processing
     *      This process searches the processing result with the received job ID and saves the contents in AsyncJobExecutionResult__c.
     *      And returns the success or failure of the saves process.
     * @param ID jobId
     * @return Boolean
     * @author Nakano Shoki
     */
    public Boolean isSuccessfulCompletion(ID jobId) {
        Boolean isSuccess = false;
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
        ApexClass ac = [
            SELECT Id,
                   Name
            FROM   ApexClass
            WHERE  ID = :apexJob.ApexClassID
        ];
        if(apexJob.Status == JOB_STATUS_COMPLETED) {
            if(apexJob.NumberOfErrors == 0) {
                isSuccess = true;
            }
        }
        info('call: isSuccessfulCompletion');
        info('JobType: '  + apexJob.JobType);
        info('Status: '  + apexJob.Status);
        info('CompletedDate: '  + apexJob.CompletedDate);
        info('ApexClassName: '  + ac.Name);
        info('MethodName: '  + apexJob.MethodName);
        info('JobItemsProcessed: '  + apexJob.JobItemsProcessed);
        info('TotalJobItems: '  + apexJob.TotalJobItems);
        info('NumberOfErrors: '  + apexJob.NumberOfErrors);
        return isSuccess;
    }
}