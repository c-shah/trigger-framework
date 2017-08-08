Account a = [ select id from account limit 1];
System.debug( ' a ' + a );

Boolean b = TriggerFrameworkUtility.isTriggerExecutionEnabled(a);
System.debug(' execution enabled : ' + b );