/**
 * Base for all classes
 *      基本的な機能を盛り込んだクラス
 *      継承して使ってね
 * @author Nakano Shoki
 */
public virtual class Base {
    private String className = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    private String assert = '========== ';
    // カスタムメタデータに持たせた方がいいかも？
    private Boolean isDebug = true;
    private Boolean isInfo = true;
    /**
     * @description Const
     *      Set ClassName
     * @author Nakano Shoki
     */
    public Base() {
        Info('Start: ' + className);
    }
    /**
     * @description logger
     *      Logging level is DEBUG
     * @param message
     * @return None
     * @author Nakano Shoki
     */
    public void Debug(Object message) {
        if(isDebug) {
            System.debug(Logginglevel.DEBUG,assert + message);
        }
    }
    /**
     * @description logger
     *      Logging level is INFO
     * @param message
     * @return None
     * @author Nakano Shoki
     */
    public void Info(Object message) {
        if(isInfo) {
            System.debug(Logginglevel.INFO,assert + message);
        }
    }
}