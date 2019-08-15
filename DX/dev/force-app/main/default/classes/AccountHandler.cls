public class AccountHandler extends BaseHandler implements TriggerHandler {
    public void main(){
        Debug('test');
        handle();
    }
    public void test(){
        Debug('bar');
    }
}