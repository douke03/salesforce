import { LightningElement, track, wire } from 'lwc';
import getBulletinBoardList from '@salesforce/apex/BulletinBoardController.getImportantBulletinBoardList';

export default class BulletinBoardListView extends LightningElement {
    @track openmodel = false;
    @track subject = '';
    @track bodyText = '';
    @track recordUrl = '';
    @wire(getBulletinBoardList) bulletinBoards;
    openModal(event) {
        event.preventDefault();
        event.stopPropagation();
        this.subject = event.currentTarget.dataset.subject;
        this.bodyText = event.currentTarget.dataset.bodyText;
        this.recordUrl = window.location.origin + '/' + event.currentTarget.dataset.id;
        this.openmodel = true;
    }
    closeModal(event) {
        event.preventDefault();
        event.stopPropagation();
        this.openmodel = false;
    }
}