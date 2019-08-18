public with sharing class AccountExtension {
    private ApexPages.StandardSetController accountController {get; set;}
    public AccountExtension(Apexpages.StandardSetController controller) {
        accountController = controller;
    }
    public PageReference sample() {
        System.debug('sample');
        System.debug('All List');
        for(Object acc : accountController.getRecords()) {
            System.debug(acc);
        }
        System.debug('Selected List');
        for(Object acc : accountController.getSelected()) {
            System.debug(acc);
        }
        PageReference page = accountController.cancel();
        System.debug('page: ' + page);
        return page;
    }
}
