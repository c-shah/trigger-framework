/**
* @author Chintan Shah
* @date 07/16/2013
* @description This class has helper methods.
*/

public with sharing class TriggerFrameworkUtility {
	
	/**
	* @author Chintan Shah
	* @date 07/16/2013
	* @description Gets the type name of the SObject.
	* @param SObject The SObject for which the name to be obtained.
	* @return String - The type name.
	*/
	public static String getSObjectTypeName(SObject so) {
		return so.getSObjectType().getDescribe().getName();
	}

	/**
	 * get formatted name : remove __c if it is there
	 */
	public static String getSObjectTypeNameFormatted(Schema.sObjectType soType) {
		String originalTypeName = soType.getDescribe().getName();
		String formattedName = originalTypeName;
		if (originalTypeName.toLowerCase().endsWith('__c')) {
			Integer index = originalTypeName.toLowerCase().indexOf('__c');
			formattedName = originalTypeName.substring(0, index);
		}
		return formattedName;
	}

	/**
	 * adding method to check the boolean flag on all trigger
	 * and then sObject name level trigger
	 *
	 *
	 * How to use this. The framework already comes with one of the hiearchical setting called :
	 * TriggerFrameworkSettings__c.AllTriggersDisabled - this is false by default.
	 * 		if you need to disable all triggers, you can just check this checkbox. and all triggers will be disabled for a given user/profile/org
	 *
	 * This method also extends it for individual sObject.
	 * You can add <<sObjectType>>TriggerDisabled custom setting under TriggerFrameworkSettings__c, and that setting will be dynamically be read for
	 * that sObject for a given user/profile/org.
	 */
	public static Boolean isTriggerExecutionEnabled(Schema.sObjectType soType) {
		String sObjectName = getSObjectTypeNameFormatted(soType);
		if( fieldExists( 'TriggerFrameworkSettings__c', 'AllTriggersDisabled__c') ) {
			Boolean allTriggersDisabled = (Boolean) TriggerFrameworkSettings__c.getInstance().get('AllTriggersDisabled__c');
			if( allTriggersDisabled == null || allTriggersDisabled == false ) {
				if( fieldExists( 'TriggerFrameworkSettings__c', sObjectName + 'TriggerDisabled__c') ) {
					Boolean sObjectTriggerDisabled = (Boolean) TriggerFrameworkSettings__c.getInstance().get(sObjectName + 'TriggerDisabled__c');
					if( sObjectTriggerDisabled == true ) {
						return false;
					}
				}
			}
		}
		/** by default trigger execution is enabled **/
		return true;
	}

	/**
	 *
	 */
	public static boolean fieldExists(String objectName, String fieldName) {
		try {
			Schema.SObjectType salesforceObject = Schema.getGlobalDescribe().get(objectName);
			Map<String, Schema.SObjectField> fields = salesforceObject.getDescribe().fields.getMap();
			for(String field : fields.keySet() ) {
				if( field.equalsIgnoreCase(fieldName) ) {
					return true;
				}
			}
		} catch(Exception e) {
			System.debug(e);
			return false;
		}
		return false;
	}
}