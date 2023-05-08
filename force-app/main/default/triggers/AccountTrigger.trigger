trigger AccountTrigger on Account (after update) {
    AccountService.createAccountHistory((List<Account>) Trigger.new, (Map<Id, Account>) Trigger.OldMap);
}