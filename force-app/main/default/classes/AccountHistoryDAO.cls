public class AccountHistoryDAO {
    @AuraEnabled
    public static List<Account_History__c> getAccountHistoriesFromAccount(String id){
        List<Account_History__c> accountHistories =  [
            SELECT Account__c, Field_label__c, Field_API_name__c, Old_value__c, New_value__c, CreatedById, CreatedBy.Name, CreatedDate
            FROM Account_History__c
            WHERE Account__c = :id
            ORDER BY CreatedDate DESC
        ];
        return accountHistories.isEmpty() ? null : accountHistories;
    }
}