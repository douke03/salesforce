/**
 * EventAction : Event用Actionクラス
 *
 * Created : 2018/07/23 Shoki N.
 * Updated : None
 */
public class EventAction {
    //-------------------------------------------------------
    // Main processing
    //-------------------------------------------------------
    /**
     * @author  Shoki N.
     * @date    2018/07/23
     * @description
     *      プロセスビルダーから呼び出される共通処理
     * @param  List<RequestParam>
     */
    @InvocableMethod
    public static void main(List<RequestParam> params) {
        System.debug('====================================');
        System.debug('========== Start main');
        System.debug('========== @param params : ' + params);
        for (RequestParam param : params) {
            switch on param.methodName {
                when 'CalculatePaymentAmount' {
                    CalculatePaymentAmount(param.objId);
                }
                when else {
                    System.debug('None');
                }
            }
        }
    }
    /**
     * @author  Shoki N.
     * @date    2018/07/23
     * @description
     *      支払額の計算用メソッド。
     *      eventIdを元に参加者を抽出し、一人当たりの支払額を計算する。
     *      計算結果を参加者レコードに挿入、更新する。
     *      一人当たりの支払額 = 会計/SUM(参加者.得点)*参加者.得点
     *      ※支払額が不足しない様、切り上げ処理を行う。
     * @param  Id eventId
     */
    private static void CalculatePaymentAmount(Id eventId) {
        System.debug('====================================');
        System.debug('========== Start CalculatePaymentAmount');
        System.debug('========== @param eventId : ' + eventId);
        // 参加者一覧を取得
        List<Participant__c> participants = new List<Participant__c>();
        participants = [SELECT   Score__c,
                                 Payment__c,
                                 EventId__r.Payment__c
                        FROM     Participant__c
                        WHERE    EventId__c = :eventId
                        ORDER BY Name];

        if(participants.size() > 0) {
            Decimal sumScore = Decimal.valueOf(0);
            Decimal payment = Decimal.valueOf(0);
            // 合計得点を取得
            for(Participant__c participant : participants) {
                sumScore = sumScore + participant.Score__c;
            }
            // 得点あたりの支払額を取得
            Decimal pricePerPoint = participants[0].EventId__r.Payment__c / sumScore;

            List<Participant__c> updateList = new List<Participant__c>();
            for(Participant__c participant : participants) {
                // 支払額 = 得点あたりの支払額 * 得点
                payment = participant.Score__c * pricePerPoint;
                participant.Payment__c = payment.round(System.RoundingMode.UP);
                updateList.add(participant);
            }
            try {
                update updateList;
            } catch(Exception e) {
                System.debug('error');
            }
        }
    }
}