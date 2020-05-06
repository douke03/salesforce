/**
 * BulletinBoardController
 * @author Nakano Shoki
 */
public with sharing class BulletinBoardController {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    // public BulletinBoardController() {}
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    /**
     * @description test
     * @param none
     * @author Nakano Shoki
     */
    @AuraEnabled(cacheable=true)
    public static List<BulletinBoard__c> getImportantBulletinBoardList() {
        String userType = UserInfo.getUserType();
        Datetime now = system.now();
        String sql =
            ' SELECT Id,' +
            '        Name,' +
            '        Subject__c,' +
            '        BodyText__c,' +
            '        PublishDate__c,' +
            '        LastModifiedDate' +
            ' FROM   BulletinBoard__c';
        if(userType == 'Standard') {
            sql = sql + ' WHERE  IsAllowInternalPublish__c = true';
        } else {
            sql = sql + ' WHERE  IsAllowExternalPublish__c = true';
        }
        sql = sql +
            '   AND  NoticePostingPeriod__c > :now' +
            ' WITH   SECURITY_ENFORCED' +
            ' ORDER BY PublicationOrder__c,' +
            '          PublishDate__c DESC,' +
            '          CreatedDate DESC';
        return Database.query(sql);
    }
    /**
     * @description test
     * @param none
     * @author Nakano Shoki
     */
    @AuraEnabled(cacheable=true)
    public static void getSection() {
        String userType = UserInfo.getUserType();
        String sql =
            ' SELECT Type__c,' +
            '        Tag__c' +
            ' FROM   BulletinBoard__c';
        if(userType == 'Standard') {
            sql = sql + ' WHERE  IsAllowInternalPublish__c = true';
        } else {
            sql = sql + ' WHERE  IsAllowExternalPublish__c = true';
        }
        sql = sql +
            ' WITH   SECURITY_ENFORCED' +
            ' ORDER BY Type__c,' +
            '          Tag__c';
        List<BulletinBoard__c> bbList = Database.query(sql);

    }
}