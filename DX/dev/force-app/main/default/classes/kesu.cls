global class kesu extends BaseBatch implements Schedulable, Database.Batchable<sObject> {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    private final Integer BATCH_SIZE = 1;
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
        Boolean isSuccess = true;
        System.debug('====================================');
        System.debug('========== Start SampleBatch Batch:execute');
        try {
            System.debug('========== userList.Name : ' + userList[0].Name);
        } catch(Exception e) {
            System.debug('========== Exception : ' + e);
            isSuccess = false;
        } finally {
            if(isSuccess) {
                cntSuccessfulCompletion ++;
            }
        }
    }
    public void finish(Database.BatchableContext bc) {
        System.debug('====================================');
        System.debug('========== Start SampleBatch Batch:finish');
        isSuccessfulCompletion(bc.getJobId());
    }
}