public with sharing class VFLoginFlowController
    extends Base {
    public PageReference init() {
        PageReference pageRef = ApexPages.currentPage();
        String userAgent = pageRef.getHeaders().get('User-Agent');
        // 'MSIE'or'Trident'が含まれている場合はIE利用者だと判断できる
        if(userAgent.containsIgnoreCase('MSIE') || userAgent.containsIgnoreCase('Trident')) {
            //静的リソースなどに遷移させる
            return new PageReference('http://www.google.com');
        } else {
            return Auth.SessionManagement.finishLoginFlow();
        }
    }
}