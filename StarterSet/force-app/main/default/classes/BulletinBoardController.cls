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
    public static List<BulletinBoard__c> getBBType() {
        String userType = UserInfo.getUserType();
        String soql =
            ' SELECT Type__c' +
            ' FROM   BulletinBoard__c';
        if(userType == 'Standard') {
            soql += ' WHERE  IsAllowInternalPublish__c = true';
        } else {
            soql += ' WHERE  IsAllowExternalPublish__c = true';
        }
        soql += ' WITH   SECURITY_ENFORCED' +
                ' GROUP BY Type__c' +
                ' ORDER BY Type__c';
        return Database.query(soql);
    }
    /**
     * @description test
     * @param none
     * @author Nakano Shoki
     */
    @AuraEnabled(cacheable=true)
    public static List<BulletinBoard__c> getBBData() {
        String userType = UserInfo.getUserType();
        String soql =
            ' SELECT Id,' +
            '        Name,' +
            '        Subject__c,' +
            '        BodyText__c,' +
            '        Type__c,' +
            '        Tag__c,' +
            '        PublishDate__c,' +
            '        LastModifiedDate' +
            ' FROM   BulletinBoard__c';
        if(userType == 'Standard') {
            soql += ' WHERE  IsAllowInternalPublish__c = true';
        } else {
            soql += ' WHERE  IsAllowExternalPublish__c = true';
        }
        soql += ' WITH   SECURITY_ENFORCED' +
                ' ORDER BY PublicationOrder__c,' +
                '          PublishDate__c DESC,' +
                '          CreatedDate DESC';
        return Database.query(soql);
    }
    /**
     * @description test
     * @param none
     * @author Nakano Shoki
     */
    @AuraEnabled(cacheable=true)
    public static List<BulletinBoard__c> getImportantBBData() {
        String userType = UserInfo.getUserType();
        Datetime now = system.now();
        String soql =
            ' SELECT Id,' +
            '        Name,' +
            '        Subject__c,' +
            '        BodyText__c,' +
            '        Type__c,' +
            '        Tag__c,' +
            '        PublishDate__c,' +
            '        LastModifiedDate' +
            ' FROM   BulletinBoard__c';
        if(userType == 'Standard') {
            soql += ' WHERE  IsAllowInternalPublish__c = true';
        } else {
            soql += ' WHERE  IsAllowExternalPublish__c = true';
        }
        soql += '   AND  NoticePostingPeriod__c > :now' +
                ' WITH   SECURITY_ENFORCED' +
                ' ORDER BY PublicationOrder__c,' +
                '          PublishDate__c DESC,' +
                '          CreatedDate DESC';
        return Database.query(soql);
    }
    /**
     * @description test
     * @param none
     * @author Nakano Shoki
     */
    @AuraEnabled(cacheable=false)
    public static List<BulletinBoard__c> getBBDataSosl(String keyword, List<String> types) {
        // String.escapeSingleQuotes(keyword)
        String userType = UserInfo.getUserType();
        String sosl =
            ' FIND :keyword IN ALL FIELDS';
        sosl += ' RETURNING' +
                '     BulletinBoard__c(Id, Name, Subject__c, BodyText__c, Type__c, Tag__c, PublishDate__c, LastModifiedDate)';
        if(userType == 'Standard') {
            sosl += ' WHERE  IsAllowInternalPublish__c = true';
        } else {
            sosl += ' WHERE  IsAllowExternalPublish__c = true';
        }
        sosl += ' WITH   SECURITY_ENFORCED' +
                ' ORDER BY PublicationOrder__c,' +
                '          PublishDate__c DESC,' +
                '          CreatedDate DESC' +
                ' LIMIT 2000';
        List<List <sObject>> searchList = search.query(sosl);
        return (List<BulletinBoard__c>)searchList[0];
    }
}