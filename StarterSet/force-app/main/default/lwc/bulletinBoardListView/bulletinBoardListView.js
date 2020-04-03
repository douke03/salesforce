import { LightningElement, track, wire } from 'lwc';
import bulletinBoardList from '@salesforce/apex/BulletinBoardController.getBulletinBoardList';

export default class BulletinBoardListView extends LightningElement {
    @track activeSections = ['A'];
    @wire(bulletinBoardList) bulletinBoards;
}