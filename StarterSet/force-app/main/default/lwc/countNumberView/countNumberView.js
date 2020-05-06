import { LightningElement, api, wire, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import UserId from '@salesforce/user/Id';
import getViewHistory from '@salesforce/apex/CountNumberView.getViewHistory';
import VIEW_HISTORY from '@salesforce/schema/ViewHistory__c';
import FIELD_ID from '@salesforce/schema/ViewHistory__c.Id';
import FIELD_USER from '@salesforce/schema/ViewHistory__c.ViewUser__c';
import FIELD_VIEW_RECORD_ID from '@salesforce/schema/ViewHistory__c.ViewRecordId__c';
import FIELD_VIEW_COUNT from '@salesforce/schema/ViewHistory__c.ViewCount__c';

export default class CountNumberView extends LightningElement {
    @api recordId;
    @track data;
    @track error;
    connectedCallback() {
        getViewHistory({
            recordId : this.recordId
        })
        .then(result => {
            this.data = result;
            this.error = undefined;
            console.log('Object.keys(result).length: ' + Object.keys(result).length);
            if(Object.keys(result).length == 0) {
                // Create
                console.log('Create');
                const fields = {};
                fields[FIELD_USER.fieldApiName] = UserId;
                fields[FIELD_VIEW_RECORD_ID.fieldApiName] = this.recordId;
                fields[FIELD_VIEW_COUNT.fieldApiName] = 1;
                const recordInput = { apiName: VIEW_HISTORY.objectApiName, fields };
                createRecord(recordInput)
                    .then(insertData => {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success',
                                message: 'ViewHistory created',
                                variant: 'success',
                            }),
                        );
                        console.log('Create is Success');
                    })
                    .catch(error => {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error creating record',
                                message: 'error',
                                variant: 'error',
                            }),
                        );
                        console.log('Create is Error');
                    });
            } else {
                // Update
                console.log('Update');
                const fields = {};
                fields[FIELD_ID.fieldApiName] = result.Id;
                fields[FIELD_VIEW_COUNT.fieldApiName] = result.ViewCount__c + 1;
                const recordInput = { fields };
                updateRecord(recordInput)
                    .then(() => {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success',
                                message: 'ViewHistory updated',
                                variant: 'success'
                            })
                        );
                        console.log('Update is Success');
                    })
                    .catch(error => {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error updating record',
                                message: 'error',
                                variant: 'error'
                            })
                        );
                        console.log('Update is Error');
                    });
            }
        })
        .catch(error => {
            this.data = undefined;
            this.error = error;
        });
    }
}