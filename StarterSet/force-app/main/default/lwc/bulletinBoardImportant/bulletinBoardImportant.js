import { LightningElement, track, wire } from 'lwc';
import getBulletinBoardList from '@salesforce/apex/BulletinBoardController.getImportantBBData';

export default class bulletinBoardImportant extends LightningElement {
    @track isOpenmodel = false;
    @track bulletinBoards;
    @track isShowTable = true;
    @track subject;
    @track bodyText;
    @track recordUrl;
    @wire(getBulletinBoardList)
        wireBBData({data, error}) {
            if(data) {
                this.bulletinBoards = data;
                if(this.bulletinBoards.length > 0) {
                    this.isShowTable = true;
                } else {
                    this.isShowTable = undefined;
                }
            } else if(error) {
                this.error = error;
            }
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