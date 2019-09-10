public class Error {
    public void test() {
        try {
            User u = new user();
            insert u;
        } catch(Exception e){
            CustomObject1__e newsEvent = new CustomObject1__e(
                Location__c='Mountain City');
            Database.SaveResult sr = EventBus.publish(newsEvent);
            ApexCustomLog__c acl = new ApexCustomLog__c();
            acl.LogLevel__c = 'ERROR';
        }
    }
}