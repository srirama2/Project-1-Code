trigger TransactionTrigger on Transaction__c (before insert, after insert) {
    Transaction__c firstTransaction = trigger.new[0];
    Map<ID,Schema.RecordTypeInfo> rt_Map = Transaction__c.sObjectType.getDescribe().getRecordTypeInfosById();
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            if(rt_map.get(firstTransaction.recordTypeID).getName().containsIgnoreCase('Expense')){
                TransactionTriggerHelper.decreaseAccount(firstTransaction);
                TransactionTriggerHelper.decreaseBudget(firstTransaction);
            } else {
                // income
                //  (rt_map.get(firstTransaction.recordTypeID).getName().containsIgnoreCase('Deposit'));{
                TransactionTriggerHelper.increaseAccountTotal(firstTransaction);
            }
        }
    }
}