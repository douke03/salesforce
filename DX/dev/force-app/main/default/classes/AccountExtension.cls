public with sharing class AccountExtension {
    private ApexPages.StandardSetController myController {get; set;}
    public AccountExtension(Apexpages.StandardSetController controller) {
        myController = controller;
    }
    public PageReference sample() {
        System.debug('sample');
        System.debug('All List');
        for(Object acc : myController.getRecords()) {
            System.debug(acc);
        }
        System.debug('Selected List');
        for(Object acc : myController.getSelected()) {
            System.debug(acc);
        }
        PageReference page = myController.cancel();
        System.debug('page: ' + page);
        return page;
    }
}
