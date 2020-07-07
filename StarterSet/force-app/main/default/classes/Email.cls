public with sharing class Email extends Base{
    //-------------------------------------------------------
    // CustomException & Variables
    //-------------------------------------------------------
    public Map<String, Id> orgAddressMap = new Map<String, Id>();
    public List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
    public Email() {
        List<OrgWideEmailAddress> oweaList = [
            SELECT Id,
                   DisplayName
            FROM   OrgWideEmailAddress
            ORDER BY Id
        ];
        for(OrgWideEmailAddress owea : oweaList) {
            orgAddressMap.put(owea.DisplayName, owea.Id);
        }
    }
    //-------------------------------------------------------
    // Processing part
    //-------------------------------------------------------
    public void sendMail(String senderName) {
        Id senderId = orgAddressMap.get(senderName);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        // 組織の共有アドレスのID
        mail.setToAddresses(new List<String>{'nanaedashokudai@gmail.com'});
        mail.setOrgWideEmailAddressId(senderId);
        mail.setSubject('TestSubject');
        mail.setPlainTextBody('Test');
        mailList.add(mail);
        mail.setToAddresses(new List<String>{'nanaedashokudaiA@gmail.com'});
        mailList.add(mail);
        mail.setToAddresses(new List<String>{'nanaedashokudaiB@gmail.com'});
        mailList.add(mail);
        Messaging.sendEmail(new Messaging.Email[] { mail });
    }
}