import { LightningElement, track, wire } from 'lwc';
import getBulletinBoardType from '@salesforce/apex/BulletinBoardController.getBBType';
import getBulletinBoardList from '@salesforce/apex/BulletinBoardController.getBBData';

export default class bulletinBoard extends LightningElement {
    typeList;
    @track isOpenmodel = false;
    @track subject;
    @track bodyText;
    @track recordUrl;
    // @wire(getBulletinBoardType) bulletinBoardTypes;
    @wire(getBulletinBoardType)
        test({data, error}) {
            if(data) {
                window.console.log('data');
                window.console.log(data);
            } else if(error) {
                window.console.log('error');
                window.console.log(error);
            }
        }
    @wire(getBulletinBoardList) bulletinBoards;
    connectedCallback() {
        window.console.log('connectedCallback');
        // for(let bbtKey of Object.keys(bulletinBoardTypes)) {
        //     window.console.log(bulletinBoardTypes[bbtKey].Type__c);
        //   }
    }
    clickedType(event) {
        window.console.log('test');
        window.console.log(event.detail.type);
        window.console.log(event.detail.isSelected);
        // if(this.isSelected) {
        //     event.currentTarget.selected = false;
        //     event.currentTarget.variant = 'inverse';
        // } else {
        //     event.currentTarget.selected = true;
        //     event.currentTarget.variant = 'brand';
        // }
    }
    openModalHandler(event) {
        this.subject = event.detail.subject;
        this.bodyText = event.detail.bodyText;
        this.recordUrl = event.detail.recordUrl;
        this.isOpenmodel = event.detail.isOpenmodel;
    }
    closeModal() {
        this.isOpenmodel = false;
    }
}