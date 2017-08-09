# Trigger Framework with hierarchical kill switch


## Addition to existing trigger framework by Hari K.


### Original Frameowrk:
https://krishhari.wordpress.com/2013/07/22/an-architecture-framework-to-handle-triggers-in-the-force-com-platform/

### Modiification :
added hierchical trigger kill switch to stop processing trigger logic.


### How to use: 

 The framework already comes with one of the hiearchical setting called :
 TriggerFrameworkSettings__c.AllTriggersDisabled 
 this is false by default. If you need to disable all triggers, you can just check this checkbox. and all triggers will be disabled for a given user/profile/org

  We can also enable/disable trigger on individual sObject.  
  You can add <<sObjectType>>TriggerDisabled custom setting under TriggerFrameworkSettings__c, and that setting will be dynamically be read for that sObject for a given user/profile/org.
