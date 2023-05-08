@isTest
public class AccountServiceTest {
    
    @TestSetup
    static void makeData(){
        Account account = new Account(Name = 'Test Name');
        insert account;
    }

    @isTest 
    static void testHistory(){
        Account account = [SELECT id, Name FROM Account LIMIT 1];
        account.Name = 'Test Updated';
        update account;

        List<Account_History__c> histories = AccountHistoryDAO.getAccountHistoriesFromAccount(account.id);
        System.assertEquals(histories[0].New_value__c, 'Test Updated');        
    }
}