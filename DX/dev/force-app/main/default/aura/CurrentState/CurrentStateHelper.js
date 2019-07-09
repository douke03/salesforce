({
    init : function (cmp) {
        this.getEvent(cmp);
        // window.setInterval(
        //     $A.getCallback(function() {
        //         this.getParticipant(cmp);
        //     }), 15000
        // );
    },
    getEvent : function (cmp) {
        var action = cmp.get('c.getEvent');
        action.setCallback(this, function(data) {
            var res = data.getReturnValue();
            if (action.getState() == "SUCCESS" && res.isSuccess) {
                var events = res.value.events;
                cmp.set("v.events", events);
                cmp.set("v.eventId", events[0].Id);
                this.getParticipant(cmp);
            } else {
                // 失敗した場合の処理
            }
        });
        $A.enqueueAction(action);
    },
    getParticipant : function (cmp) {
        var action = cmp.get('c.getParticipant');
        action.setParams({
            'eventId': cmp.get('v.eventId')
        });
        action.setCallback(this, function(data) {
            var res = data.getReturnValue();
            if (action.getState() == "SUCCESS" && res.isSuccess) {
                cmp.set('v.participants', res.value.participants);
            } else {
                // 失敗した場合の処理
            }
        });
        $A.enqueueAction(action);
    }
})