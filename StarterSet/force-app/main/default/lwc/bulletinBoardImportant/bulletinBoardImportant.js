import { LightningElement, track, wire } from 'lwc';
import getBulletinBoardList from '@salesforce/apex/BulletinBoardController.getImportantBBData';

export default class bulletinBoardImportant extends LightningElement {
    @track isOpenmodel = false;
    @track subject;
    @track bodyText;
    @track recordUrl;
    @wire(getBulletinBoardList) bulletinBoards;
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