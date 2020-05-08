import { LightningElement, api } from 'lwc';

export default class ModalInfoMedium extends LightningElement {
    @api subject;
    @api bodyText;
    @api recordUrl;
    connectedCallback() {
    }
}