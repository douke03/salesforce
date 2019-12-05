/**
 * Deleting error log
 * @author Nakano Shoki
 */
public without sharing class DeletingErrorLogProcessing
    extends BaseAsyncJob
    implements DeletingErrorLog.SchedulableExecute,
               Database.Batchable<sObject> {
    //-------------------------------------------------------
    // Variables & Schedulable
    //-------------------------------------------------------
    private final Integer BATCH_SIZE = 200;
    @TestVisible
    private final Integer MONTH_TO_KEEP_LOG = 3;

    public void Execute(SchedulableContext sc) {
        DeletingErrorLogProcessing batch = new DeletingErrorLogProcessing();
        Database.executeBatch(batch, BATCH_SIZE);
    }
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    /**
     * @description Get records past retention period.
     * @author Nakano Shoki
     */
    public Database.QueryLocator start(Database.BatchableContext bc) {
        info(CLASS_NAME + ': start');
        try {
            Date d = date.today().addMonths(-MONTH_TO_KEEP_LOG);
            Datetime baseDateToDelete = Datetime.newInstance(d.year(), d.month(), d.day());
            String query = ' SELECT Id'
                        + ' FROM   ErrorLog__c'
                        + ' WHERE  CreatedDate <= ' + baseDateToDelete.format('yyyy-MM-dd\'T\'HH:mm:ss.000\'Z\'');
            debug('query: ' + query);
            return Database.getQueryLocator(query);
        } catch(Exception e) {
            exceptionHandler(e);
            throw new AsyncJobException(e);
        }
    }
    /**
     * @description Delete the records.
     * @author Nakano Shoki
     */
    public void execute(Database.BatchableContext bc, List<ErrorLog__c> errorLogList) {
        info(CLASS_NAME + ': execute');
        if(isActiveAsyncJob) {
            Savepoint sp = Database.setSavepoint();
            try {
                delete errorLogList;
            } catch(Exception e) {
                Database.rollback(sp);
                exceptionHandler(e);
                throw new AsyncJobException(e);
            }
        } else {
            info(CLASS_NAME + 'did not work because ActiveSetting is false.');
        }
    }
    /**
     * @description Save the execution result.
     * @author Nakano Shoki
     */
    public void finish(Database.BatchableContext bc) {
        try {
            info(CLASS_NAME + ': finish');
            isSuccessfulCompletion(bc.getJobId());
        } catch(Exception e) {
            exceptionHandler(e);
            throw new AsyncJobException(e);
        }
    }
}