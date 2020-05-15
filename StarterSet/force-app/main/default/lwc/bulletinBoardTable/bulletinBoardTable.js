import { LightningElement, api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';
import USER_TYPE_FIELD from '@salesforce/schema/User.UserType';

export default class bulletinBoardTable extends LightningElement {
    @api bulletinBoards;
    @track error;
    @track userType;
    @track url;
    @wire(getRecord, {
        recordId: USER_ID,
        fields: [USER_TYPE_FIELD]
    }) wireuser({error, data}) {
        if (data) {
            window.console.log(data.fields.UserType.value);
            this.userType = data.fields.UserType.value;
        } else if (error) {
            this.error = error ;
        }
    }
    openModal(event) {
        const href = window.location.href;
        const origin = window.location.origin;
        const afterOrigin = href.replace(origin, '');
        window.console.log(afterOrigin.split('/')[1]);
        if(this.userType == 'Standard') {
            window.console.log('Standard');
            this.url = window.location.origin + '/' + event.currentTarget.dataset.id;
        } else {
            window.console.log('other');
            this.url = window.location.origin + '/' + afterOrigin.split('/')[1] + '/' + event.currentTarget.dataset.id;
        }
        const ce = new CustomEvent("openmodal", {
            detail: {
                subject: event.currentTarget.dataset.subject,
                bodyText: event.currentTarget.dataset.bodyText,
                recordUrl: this.url,
                isOpenmodel: true
            }
        });
        this.dispatchEvent(ce);
    }
}