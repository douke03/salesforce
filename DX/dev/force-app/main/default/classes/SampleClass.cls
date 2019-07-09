public class SampleClass {
    public void main() {
        String CurrentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
        System.debug(CurrentClassName);
    }
}