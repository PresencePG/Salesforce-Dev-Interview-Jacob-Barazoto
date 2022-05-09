/**
 * Reusable utility methods
 */

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const showMessage = (msgType, msgTitle, msgBody, self) => {
    var msgMode = 'dismissable';
    if ( msgType == 'error') {
        msgMode = 'pester';
    }
    const evt = new ShowToastEvent({
        title: msgTitle,
        message: msgBody,
        variant: msgType,
        mode: msgMode
    });
   self.dispatchEvent(evt);
};

const handleError = (error, errorMessage, self) => {
    if(error){
        errorMessage = JSON.stringify(error);
        if (error.body) {
            errorMessage = JSON.stringify(error.body);
            if (error.body.message) {
                errorMessage = error.body.message;
            }
        }
    }
    showMessage('error', 'Error', errorMessage, self);
};

export { showMessage, handleError };