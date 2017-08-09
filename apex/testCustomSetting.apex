Account a = [ select id from account limit 1];
System.debug( ' a ' + a );

Boolean b = TriggerFrameworkUtility.isTriggerExecutionEnabled(a);
System.debug(' execution enabled : ' + b );

Intervention__c intervention = new Intervention__c('')