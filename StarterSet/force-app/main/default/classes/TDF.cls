/*
 * Test Data Factory Class
 * @author Nakano Shoki
 */
@isTest
public class TDF {
    /**
     * @description Create user instance for testing
     *      This process creates a test user instance with the received profile name.
     * @param String
     * @author Nakano Shoki
     */
    public static User testUser(String profileName) {
        List<String> profileNames = new List<String>();
        profileNames.add(profileName);
        return userInstance(profileNames);
    }
    /**
     * @description Create user instance for testing
     *      This process creates a test user instance with the received profile names.
     * @param List<String>
     * @author Nakano Shoki
     */
    public static User testUser(List<String> profileNames) {
        return userInstance(profileNames);
    }
    /**
     * @description Create user instance for testing
     *      This process return a test user instance with the received profile names.
     * @param List<String>
     * @author Nakano Shoki
     */
    public static User userInstance(List<String> profileNames) {
        Profile pf = [
            SELECT Id,
                   Name
            FROM   Profile
            WHERE  Name IN :profileNames
            LIMIT  1
        ];
        return new user(
            UserName          = 'test@dummydomain.com',
            Email             = 'test@dummydomain.com',
            LastName          = 'test',
            Alias             = 'test',
            TimeZoneSidKey    = 'Asia/Tokyo',
            LocaleSidKey      = 'ja_JP',
            EmailEncodingKey  = 'UTF-8',
            LanguageLocaleKey = 'ja',
            ProfileId         = pf.Id
        );
    }
    public static final List<String> PROFILE_SYSTEM_ADMINISTRATOR = new List<String>{
        'System Administrator',
        'システム管理者'
    };
    public static final List<String> PROFILE_STANDARD_USER = new List<String>{
        'Standard User',
        '標準ユーザ'
    };
    public static final List<String> PROFILE_SOLUTION_MANAGER = new List<String>{
        'Solution Manager',
        'ソリューション管理者'
    };
    public static final List<String> PROFILE_READY_ONLY = new List<String>{
        'Ready Only',
        '参照のみ'
    };
    public static final List<String> PROFILE_MARKETING_USER = new List<String>{
        'Marketing User',
        'マーケティングユーザ'
    };
    public static final List<String> PROFILE_CONTRACT_MANEGER = new List<String>{
        'Contract Manager',
        '契約 管理者'
    };
}