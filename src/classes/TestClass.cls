@isTest
public class TestClass {
    @isTest public static void testBudgetUpdateAfterTransaction(){
        // create and insert account
        Account__c acct = new Account__c();
        acct.Name = 'a';
        acct.Account_Type__c = 'Checking';
        acct.Transaction_Type__c = 'Deposit';
        acct.TotalAmount__c = 500;
        insert acct;
         
        // create and isnert budget
       
        Budget__c bud = new Budget__c();
        bud.Name = 'b';
        bud.Budget_Amount__c = 300;
        bud.Month__c = 'March';
          insert bud;
        // create and insert transaction
        
        Transaction__c tran = new Transaction__c();
        tran.Name = 'Beer';
        tran.Transaction_Type__c = 'Expense';
        tran.Amount__c = 150;
        tran.BankAccount__c = acct.id;
        tran.Budget__c = bud.id;
        
        
        
        // call helper method
        TransactionTriggerHelper.decreaseAccount(tran);
                

        
        // test that helper method correctly updated budget and transaction
       Account__c acc = [SELECT TotalAmount__c FROM Account__c LIMIT 1];
        
        System.assertequals(350,acc.TotalAmount__c);
        
        TransactionTriggerHelper.decreaseBudget(tran);
        Budget__c budd = [SELECT Budget_Amount__c FROM Budget__c LIMIT 1];
        
        System.assertEquals(150, budd.Budget_Amount__c);
       
         TransactionTriggerHelper.increaseAccountTotal(tran);
        Account__c accs = [SELECT TotalAmount__c FROM Account__c LIMIT 1];
        Decimal previousAmount= accs.TotalAmount__c;
        Id incomeRecordTypeId = Schema.SObjectType.Transaction__c.getRecordTypeInfosByName()
                  .get('income').getRecordTypeId();
        Transaction__c income = new Transaction__c(name='depositing big money', Transaction_date__c=Date.newInstance(2019,8,8), Amount__c=1.11, BankAccount__c=accs.id, RecordTypeId=incomeRecordTypeId);
        insert income;
        accs = [SELECT TotalAmount__c FROM Account__c LIMIT 1];
        Decimal newAmount = accs.TotalAmount__c;
        System.assertEquals(1.11, newAmount-previousAmount);
        
        
            
      
        
    }
}