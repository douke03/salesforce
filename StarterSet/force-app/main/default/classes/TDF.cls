/*
 * Test Data Factory Class
 * @author Nakano Shoki
 */
@isTest
public class TDF {
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
    /**
     * @description return user instance for testing
     * @param List<String> profileNames
     */
    public static User testUser(List<String> profileNames) {
        Profile pf = [
            SELECT Id,
                   Name
            FROM   Profile
            WHERE  Name IN :profileNames
            LIMIT  1
        ];
        return new user(
            UserName          = pf.Name + '_test@dummydomain.com',
            Email             = pf.Name + '_test@dummydomain.com',
            LastName          = pf.Name + '_test',
            Alias             = pf.Name + '_test',
            TimeZoneSidKey    = 'Asia/Tokyo',
            LocaleSidKey      = 'ja_JP',
            EmailEncodingKey  = 'UTF-8',
            LanguageLocaleKey = 'ja',
            ProfileId         = pf.Id
        );
    }
}