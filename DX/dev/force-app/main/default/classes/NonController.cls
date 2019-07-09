public class NonController {
    @AuraEnabled
    public static ResponseDto getEvent() {
        ResponseDto res;
        try {
            List<Event__c> events = [SELECT   Id,
                                              Name
                                     FROM     Event__c
                                     ORDER BY EventDate__c DESC];
            res = new ResponseDto(true);
            res.value.put('events', events);
        } catch(Exception e) {
            res = new ResponseDto(false);
            // エラー文言をComponentに返したい場合は以下
            // res = new ResponseDto(false, 'Componentに返したいエラー文言' + e.getMessage());
        }
        return res;
    }
    @AuraEnabled
    public static ResponseDto getParticipant(Id eventId) {
        ResponseDto res;
        try {
            List<Participant__c> participants = [SELECT   Name,
                                                          Score__c,
                                                          Cup__c,
                                                          Payment__c,
                                                          ScoreBeforeCumulative__c
                                                 FROM     Participant__c
                                                 WHERE    EventId__c = :eventId
                                                 ORDER BY Score__c DESC];
            res = new ResponseDto(true);
            res.value.put('participants', participants);
        } catch(Exception e) {
            res = new ResponseDto(false);
            // エラー文言をComponentに返したい場合は以下
            // res = new ResponseDto(false, 'Componentに返したいエラー文言' + e.getMessage());
        }
        return res;
    }
}