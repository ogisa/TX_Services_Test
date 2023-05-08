public class AccountService {

    public static void createAccountHistory(List<Account> newAccounts, Map<Id, Account> oldAccountsMap) {

        List<Account_History__c> allAccountHistories = new List<Account_History__c>();

        for(Account newAccount : newAccounts){
            allAccountHistories.addAll(getDifference(newAccount, oldAccountsMap.get(newAccount.Id)));
        }

        insert allAccountHistories;
    }

    public static List<Account_History__c> getDifference(Account newAccount, Account oldAccount){

        Schema.SObjectType objType = newAccount.getSObjectType(); 
        Map<String, Schema.SObjectField> fieldNameMap = Schema.SObjectType.Account.fields.getMap(); 
        List<Account_History__c> accountHistories = new List<Account_History__c>();

        for (String fieldName : fieldNameMap.keyset()) {

            if(newAccount.get(fieldName) != oldAccount.get(fieldName)){ 

                Account_History__c accountHistory = new Account_History__c(
                    Account__c = newAccount.Id,
                    Old_value__c = String.valueOf(oldAccount.get(fieldName)),
                    New_value__c = String.valueOf(newAccount.get(fieldName)),
                    Field_API_name__c = fieldName,
                    Field_label__c = fieldNameMap.get(fieldName).getDescribe().getLabel()
                );

                accountHistories.add(accountHistory);
            }
        }
        return accountHistories;
    }
}