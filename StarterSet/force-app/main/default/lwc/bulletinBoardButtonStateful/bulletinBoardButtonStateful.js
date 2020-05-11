import { LightningElement, api, track } from 'lwc';

export default class bulletinBoardButtonStateful extends LightningElement {
    @track isSelected = true;
    @api type;
    clickedType(event) {
        if(this.isSelected) {
            this.isSelected = false;
            event.target.variant = 'inverse';
        } else {
            this.isSelected = true;
            event.target.variant = 'brand';
        }
        const ce = new CustomEvent("clickedtype", {
            detail: {
                type: this.type,
                isSelected: this.isSelected
            }
        });
        this.dispatchEvent(ce);
    }
}