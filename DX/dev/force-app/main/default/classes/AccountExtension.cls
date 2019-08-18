public with sharing class AccountExtension {
    private ApexPages.StandardSetController accountController {get; set;}
    public AccountExtension(Apexpages.StandardSetController controller) {
        accountController = controller;
    }
    public PageReference sample() {
        System.debug('All List');
        // List Viewに表示されているrecordの一覧(loadされているrecordに限る)
        for(Object acc : accountController.getRecords()) {
            System.debug(acc);
        }
        System.debug('Selected List');
        // List Viewに表示されているrecordの内、チェックボックスありの一覧(loadされているrecordに限る)
        for(Object acc : accountController.getSelected()) {
            System.debug(acc);
        }
        PageReference page = accountController.cancel();
        System.debug('page: ' + page);
        return page;
    }
}