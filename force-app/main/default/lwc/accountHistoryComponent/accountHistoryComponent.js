import { LightningElement,api } from 'lwc';
import findHistory from '@salesforce/apex/AccountHistoryDAO.getAccountHistoriesFromAccount';

const COLUMNS = [
    { label: 'Field label', fieldName: 'Field_label__c' },
    { label: 'Field API name', fieldName: 'Field_API_name__c' },
    { label: 'Old value', fieldName: 'Old_value__c'},
    { label: 'New value', fieldName: 'New_value__c' },
    { label: 'Change made by: ', fieldName: 'UserURL', type: 'url', 
        typeAttributes: {
            label: {
                fieldName: 'CreatedName'
            }
        } 
    },
    { label: 'Change was made on: ', fieldName: 'CreatedDate',  type: 'date',
    typeAttributes:{
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
        hour: "2-digit",
        minute: "2-digit"
    }}
];

export default class AccountHistoryComponent extends LightningElement {
    columns = COLUMNS;
    records;
    _recordId;

    @api set recordId(value) {
        this._recordId = value;
        findHistory({ id: this.recordId })
        .then((result) => {
            this.records = result;
            if(this.records){
                this.records.forEach(item => {
                    item['CreatedName'] = item.CreatedBy.Name;
                    item['UserURL'] = '/lightning/r/User/' + item.CreatedById + '/view'
                });
            }
                        
        })
    }

    get recordId() {
        return this._recordId;
    }
}