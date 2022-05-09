import { LightningElement, track } from 'lwc';
import { showMessage, handleError } from 'c/utils';
import createSuggestion from '@salesforce/apex/SuggestionLightningApi.create';

export default class SuggestionBox extends LightningElement {

    isProcessing = false;
    @track suggestion = {};

    resetForm(event) {
        this.isProcessing = true;
        this.resetSuggestion();
        this.isProcessing = false;
    }

    saveSuggestion(event) {
        this.isProcessing = true;
        createSuggestion({ record: this.suggestion })
        .then(result => {
            this.resetSuggestion();
            showMessage('success', 'Thanks!', 'We have received your suggestion and your team will review it ASAP.', this);
        })
        .catch(error => {
            handleError(error, 'Oops! We encountered an error processing your suggestion.', this);
        })
        .finally(() => {
            this.isProcessing = false;
        });
    }

    onFieldChange(event) {
        this.suggestion[event.target.name] = event.detail.value;
    }

    resetSuggestion() {
        this.suggestion = {};
    }
}