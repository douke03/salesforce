/**
 * @author Nakano Shoki
 */
public without sharing class DeletingErrorLogProcessing extends BaseAsyncJob implements DeletingErrorLog.SchedulableExecute, Database.Batchable<sObject> {
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
        Date d = date.today().addMonths(-MONTH_TO_KEEP_LOG);
        Datetime baseDateToDelete = Datetime.newInstance(d.year(), d.month(), d.day());
        String query = ' SELECT Id'
                     + ' FROM   ErrorLog__c'
                     + ' WHERE  CreatedDate <= ' + baseDateToDelete.format('yyyy-MM-dd\'T\'HH:mm:ss.000\'Z\'');
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