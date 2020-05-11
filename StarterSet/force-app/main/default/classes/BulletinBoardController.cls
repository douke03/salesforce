/**
 * BulletinBoardController
 * @author Nakano Shoki
 */
public with sharing class BulletinBoardController {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    private static final String USER_TYPE;

    static {
        USER_TYPE = UserInfo.getUserType();
    }
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    /**
     * @description
     *      This process returns BulletinBoard__c.Type__c.
     * @param none
     * @author Nakano Shoki
     */
    @AuraEnabled(cacheable=true)
    public static List<BulletinBoard__c> getBBType() {
        String soql =
            ' SELECT Type__c' +
            ' FROM   BulletinBoard__c';
        if(USER_TYPE == 'Standard') {
            soql += ' WHERE  IsAllowInternalPublish__c = true';
        } else {
            soql += ' WHERE  IsAllowExternalPublish__c = true';
        }
        soql += ' GROUP BY Type__c' +
                ' ORDER BY Type__c';
        // System.debug(soql);
        return Database.query(soql);
    }
    /**
     * @description
     *      This process returns BulletinBoard__c records.
     * @param String typeJson(allow null)
     * @author Nakano Shoki
     */
    @AuraEnabled(cacheable=true)
    public static List<BulletinBoard__c> getBBData(String typeJson) {
        List<String> types = jsonToTypeList(typeJson);
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
        if(USER_TYPE == 'Standard') {
            soql += ' WHERE  IsAllowInternalPublish__c = true';
        } else {
            soql += ' WHERE  IsAllowExternalPublish__c = true';
        }
        if(types.size() > 0) {
            soql += '   AND  Type__c IN :types';
        }
        soql += ' ORDER BY PublicationOrder__c,' +
                '          PublishDate__c DESC,' +
                '          CreatedDate DESC';
        // System.debug(soql);
        return Database.query(soql);
    }
    /**
     * @description
     *      This process returns important BulletinBoard__c records.
     * @param none
     * @author Nakano Shoki
     */
    @AuraEnabled(cacheable=true)
    public static List<BulletinBoard__c> getImportantBBData() {
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
        if(USER_TYPE == 'Standard') {
            soql += ' WHERE  IsAllowInternalPublish__c = true';
        } else {
            soql += ' WHERE  IsAllowExternalPublish__c = true';
        }
        soql += '   AND  NoticePostingPeriod__c > :now' +
                ' ORDER BY PublicationOrder__c,' +
                '          PublishDate__c DESC,' +
                '          CreatedDate DESC';
        // System.debug(soql);
        return Database.query(soql);
    }
    /**
     * @description
     *      This process returns BulletinBoard__c records.
     * @param String keyword(not allow null)
     * @param String typeJson(allow null)
     * @author Nakano Shoki
     */
    @AuraEnabled(cacheable=false)
    public static List<BulletinBoard__c> getBBDataSosl(String keyword, String typeJson) {
        List<String> types = jsonToTypeList(typeJson);
        String userType = UserInfo.getUserType();
        String sosl =
            ' FIND :keyword IN ALL FIELDS';
        sosl += ' RETURNING' +
                '     BulletinBoard__c(Id, Name, Subject__c, BodyText__c, Type__c, Tag__c, PublishDate__c, LastModifiedDate';
        if(USER_TYPE == 'Standard') {
            sosl += ' WHERE  IsAllowInternalPublish__c = true';
        } else {
            sosl += ' WHERE  IsAllowExternalPublish__c = true';
        }
        if(types.size() > 0) {
            sosl += '   AND  Type__c IN :types';
        }
        sosl += ' ORDER BY PublicationOrder__c,' +
                '          PublishDate__c DESC,' +
                '          CreatedDate DESC' +
                ' LIMIT 2000)';
        List<List <sObject>> searchList = search.query(sosl);
        // System.debug(sosl);
        return (List<BulletinBoard__c>)searchList[0];
    }
    /**
     * @description
     *      This process converts String JSON into String List.
     * @param String typeJson(allow null)
     * @author Nakano Shoki
     */
    private static List<String> jsonToTypeList(String typeJson) {
        List<String> types = new List<String>();
        if(String.isNotBlank(typeJson)) {
            List<Object> typeMapList = (List<Object>)JSON.deserializeUntyped(typeJson);
            for(Object typeMap : typeMapList) {
                Map<String, Object> tm = (Map<String, Object>)typeMap;
                if(Boolean.valueOf(tm.get('isSelected'))) {
                    types.add((String)tm.get('type'));
                }
            }
        }
        return types;
    }
}