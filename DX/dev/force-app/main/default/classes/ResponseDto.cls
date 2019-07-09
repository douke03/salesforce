/**
 * ResponseDto : ComponentController用応答格納クラス
 *
 * Created : 2018/07/30 Shoki N.
 * Updated : None
 *
 */
public class ResponseDto {
    //-------------------------------------------------------
    // Variables & Constants
    //-------------------------------------------------------
    @AuraEnabled public Boolean isSuccess  {get;set;}
    @AuraEnabled public String  errMessage {get;set;}
    @AuraEnabled public Map<Object, Object> value {get;set;}
    //-------------------------------------------------------
    // Constructor
    //-------------------------------------------------------
    /**
     * @author Shoki N.
     * @date   2018/07/30
     * @description
     *      コンストラクタ
     * @param  isSuccess
     *      true or false
    */
    public ResponseDto(Boolean isSuccess) {
        this.isSuccess  = isSuccess;
        this.errMessage = '';
        this.value      = new Map<Object, Object>();
    }
    /**
     * @author Shoki N.
     * @date   2018/07/30
     * @description
     *      コンストラクタ
     *      エラー発生時時にエラー文言を返したい場合はこちらを利用
     * @param  isSuccess
     *      true or false
     * @param  message
     *      componentに返したいエラー文言
    */
    public ResponseDto(Boolean isSuccess, String message) {
        this.isSuccess  = isSuccess;
        this.errMessage = message;
        this.value      = new Map<Object, Object>();
    }
}