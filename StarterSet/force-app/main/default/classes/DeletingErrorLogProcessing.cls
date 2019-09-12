/**
 * @author Nakano Shoki
 */
public without sharing class DeletingErrorLogProcessing extends BaseAsyncJob implements Database.Batchable<sObject> {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    @TestVisible
    private final Integer BATCH_SIZE = 200;
    private final Integer MONTH_TO_KEEP_LOG = 3;
    //-------------------------------------------------------
    // Schedulable
    //-------------------------------------------------------
    public void Execute(SchedulableContext sc) {
        DeletingErrorLogProcessing batch = new DeletingErrorLogProcessing();
        Database.executeBatch(batch, BATCH_SIZE);
    }
    //-------------------------------------------------------
    // Batch
    //-------------------------------------------------------
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Date baseDateToDelete = date.today().addMonths(-MONTH_TO_KEEP_LOG);
        String query = ' SELECT Id'
                     + ' FROM   ErrorLog__c'
                     + ' WHERE  CreatedDate =< ' + String.valueOf(baseDateToDelete);
        debug('query : ' + query);
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<ErrorLog__c> elList) {
        Boolean isSuccess = true;
        try {
            delete elList;
        } catch(Exception e) {
            exceptionHandler(e);
            isSuccess = false;
        } finally {
            if(isSuccess) {
                cntSuccessfulCompletion ++;
            }
        }
    }
    public void finish(Database.BatchableContext bc) {
        isSuccessfulCompletion(bc.getJobId());
    }
}