import { LightningElement, track, wire } from 'lwc';
import getBulletinBoardType from '@salesforce/apex/BulletinBoardController.getBBType';
import getBulletinBoardList from '@salesforce/apex/BulletinBoardController.getBBData';
import getBulletinBoardListSosl from '@salesforce/apex/BulletinBoardController.getBBDataSosl';

export default class bulletinBoard extends LightningElement {
    searchText = '';
    @track searchTypeJson = [];
    @track isOpenmodel = false;
    @track typeList;
    @track bulletinBoards;
    @track error;
    @track subject;
    @track bodyText;
    @track recordUrl;
    @wire(getBulletinBoardType)
        wireTypes({data, error}) {
            if(data) {
                this.typeList = data;
                for(let key of Object.keys(data)) {
                    let json = {
                        type: data[key].Type__c,
                        isSelected: 'true'
                    };
                    this.searchTypeJson.push(json);
                }
            } else if(error) {
                window.console.log(error);
            }
        }
    @wire(getBulletinBoardList)
        wireBBData({data, error}) {
            if(data) {
                this.bulletinBoards = data;
            } else if(error) {
                this.error = error;
            }
        }
    clickedType(event) {
        this.searchTypeJson.find(searchTypeJson => {
            if(searchTypeJson.type == event.detail.type){
                searchTypeJson.isSelected = event.detail.isSelected
            };
        });
        if(1 < this.searchText.trim().length) {
            getBulletinBoardListSosl({
                keyword : this.searchText,
                typeJson : JSON.stringify(this.searchTypeJson)
            })
            .then(result => {
                this.bulletinBoards = result;
                this.error = undefined;
            })
            .catch(error => {
                window.console.log('error');
                this.bulletinBoards = undefined;
                this.error = error;
            });
        } else {
            getBulletinBoardList({
                typeJson : JSON.stringify(this.searchTypeJson)
            })
            .then(result => {
                this.bulletinBoards = result;
                this.error = undefined;
            })
            .catch(error => {
                window.console.log('error');
                this.bulletinBoards = undefined;
                this.error = error;
            });
        }
    }
    test(event) {
        this.searchText = event.target.value;
        if(1 < this.searchText.trim().length) {
            getBulletinBoardListSosl({
                keyword : this.searchText,
                typeJson : JSON.stringify(this.searchTypeJson)
            })
            .then(result => {
                this.bulletinBoards = result;
                this.error = undefined;
            })
            .catch(error => {
                window.console.log('error');
                this.bulletinBoards = undefined;
                this.error = error;
            });
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