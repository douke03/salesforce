import { LightningElement, api } from 'lwc';

export default class bulletinBoardTable extends LightningElement {
    @api bulletinBoards;
    openModal(event) {
        const selectedEvent = new CustomEvent("openmodal", {
            detail: {
                subject: event.currentTarget.dataset.subject,
                bodyText: event.currentTarget.dataset.bodyText,
                recordUrl: window.location.origin + '/' + event.currentTarget.dataset.id,
                isOpenmodel: true
            }
        });
        this.dispatchEvent(selectedEvent);
    }
}