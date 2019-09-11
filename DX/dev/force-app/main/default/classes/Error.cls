public class Error extends Base {
    public void test() {
        try {
            User u = new user();
            insert u;
        } catch(Exception e){
            exceptionHandler(e);
        }
    }
}