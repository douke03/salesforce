/*
 * Test Data Factory Class
 * @author Nakano Shoki
 */
@isTest
public class TDF {
    /** All Profile(Map<Profile.Name, Profile>) */
    static final Map<String, Profile> PROFILES = new Map<String, Profile>();
    /**
     * something write
     */
    static {
        // Set Profiles
        for(Profile pro : [SELECT ID, Name FROM Profile]) {
            PROFILES.put(pro.Name, pro);
        }
    }
    /**
     * @description Create user instance for testing
     *      This process creates a test user instance with the received profile name.
     * @param String profileName
     * @author Nakano Shoki
     */
    public static User testUser(String profileName) {
        List<String> profileNames = new List<String>{profileName};
        return userInstance(profileNames);
    }
    /**
     * @description Create user instance for testing
     *      This process creates a test user instance with the received profile names.
     * @param List<String> profileNames
     * @author Nakano Shoki
     */
    public static User testUser(List<String> profileNames) {
        return userInstance(profileNames);
    }
    /**
     * @description Create user instance for testing
     *      This process return a test user instance with the received profile names.
     * @param List<String> profileNames
     * @author Nakano Shoki
     */
    public static User userInstance(List<String> profileNames) {
        Profile profile = new Profile();
        for(String profileName : profileNames) {
            profile = PROFILES.get(profileName);
            if(profile != null) {
                break;
            }
        }
        System.debug(profileNames);
        for(Profile pro : PROFILES.values()) {
            System.debug(pro);
        }
        return new user(
            UserName          = 'test@dummydomain.com',
            Email             = 'test@dummydomain.com',
            LastName          = 'test',
            Alias             = 'test',
            TimeZoneSidKey    = 'Asia/Tokyo',
            LocaleSidKey      = 'ja_JP',
            EmailEncodingKey  = 'UTF-8',
            LanguageLocaleKey = 'ja',
            ProfileId         = profile.Id
        );
    }
    /**
     * @description Create Account instance for testing
     *      This process return an Account instance.
     * @param String accountName
     * @author Nakano Shoki
     */
    public static Account accountInstance(String accountName) {
        return new Account(
            Name = accountName
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