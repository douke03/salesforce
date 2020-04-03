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
    public static List<BulletinBoard__c> getBulletinBoardList() {
        return [
            SELECT Id,
                   Name,
                   Subject__c,
                   BodyText__c
            FROM   BulletinBoard__c
            WHERE  IsPublish__c = true
              AND  NoticePostingPeriod__c > :system.now()
            WITH   SECURITY_ENFORCED
            ORDER BY PublicationOrder__c,
                     PublishDate__c DESC,
                     CreatedDate DESC
        ];
    }
}