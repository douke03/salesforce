({
    init : function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label:'のんべえ',     fieldName:'Name',                     type: 'text'    },
            {label:'得点',         fieldName:'Score__c',                 type: 'number'  },
            {label:'杯数',         fieldName:'Cup__c',                   type: 'number'  },
            {label:'支払額',       fieldName:'Payment__c',               type: 'currency'},
            {label:'支払額',       fieldName:'Payment__c',               type: 'currency'},
            {label:'支払額',       fieldName:'Payment__c',               type: 'currency'},
            {label:'支払額',       fieldName:'Payment__c',               type: 'currency'},
            {label:'得点(計算前)', fieldName:'ScoreBeforeCumulative__c', type: 'number'  }
        ]);
        helper.init(cmp);
    },
    onChange : function (cmp, event, helper) {
        console.log(event);
        cmp.set('v.eventId', cmp.find('select').get('v.value'));
        helper.getParticipant(cmp);
    }
})