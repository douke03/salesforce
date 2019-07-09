/*quickAddController.js*/
({
    init : function (cmp, event, helper) {
        console.log('testです');/*
        window.setTimeout(
            $A.getCallback(function() {
                console.log('close');
                var dismissActionPanel = $A.get("e.force:closeQuickAction");
                dismissActionPanel.fire();
            }), 1500
        );*/
    },
    handleClick : function (cmp, event, helper) {
        console.log('handleClick');
        console.log('開きます');
        window.open('https://canon-electec-nakano-dev-ed.lightning.force.com/lightning/o/Record__c/list?filterName=00B7F00000DtKwyUAF');
        window.open('https://canon-electec-nakano-dev-ed.lightning.force.com/lightning/o/Drink__c/list?filterName=Recent');
        // var urlEvent = $A.get("e.force:navigateToURL");
		// URLを直接指定して呼び出します。
		// urlEvent.setParams({"url":'https://canon-electec-nakano-dev-ed.lightning.force.com/lightning/o/Record__c/list?filterName=00B7F00000DtKwyUAF'});
		// urlEvent.fire();
    },/*
    clickAdd: function(component, event, helper) {

        // Get the values from the form
        var n1 = component.find("num1").get("v.value");
        var n2 = component.find("num2").get("v.value");

        // Display the total in a "toast" status message
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": "Quick Add: " + n1 + " + " + n2,
            "message": "The total is: " + (n1 + n2) + "."
        });
        resultsToast.fire();
        // Close the action panel
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    }*/
})