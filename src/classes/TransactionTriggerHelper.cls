public class TransactionTriggerHelper {

    public static void decreaseAccount(Transaction__c tran) {
        Account__c acct  =  [SELECT account_type__c, totalamount__c FROM account__c WHERE id =:tran.BankAccount__c];
        
        acct.TotalAmount__c = acct.TotalAmount__c - tran.Amount__c;
        
        update acct;
    }
    
    public static void decreaseBudget(Transaction__c tran) {
        
        Budget__c bud = [SELECT budget_amount__c FROM budget__c WHERE id =: tran.Budget__c];
        
        bud.Budget_Amount__c = bud.Budget_Amount__c - tran.Amount__c;
        
        update bud;
    }
    
    public static void increaseAccountTotal(transaction__c deposit) {
        Account__c acct = [SELECT Transaction_type__c, totalamount__c FROM account__c WHERE id =:deposit.BankAccount__c];
        
        acct.TotalAmount__c = acct.TotalAmount__c + deposit.Amount__c;
        
        update acct;
        
    }
    
    
}