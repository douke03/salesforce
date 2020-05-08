import { LightningElement, api, track } from 'lwc';
export default class badge extends LightningElement {
    @api badgeValue;
    @track badgeValueList = '';
    connectedCallback() {
        this.badgeValueList = this.badgeValue.split(';');
    }
}