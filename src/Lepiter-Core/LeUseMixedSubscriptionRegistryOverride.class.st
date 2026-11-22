"
I override {{gtClass:LeUseMixedSubscriptionRegistryFlag}} for the current process, during {{gtMethod:LeUseMixedSubscriptionRegistryFlag class>>#enabledDuring:}} and {{gtMethod:LeUseMixedSubscriptionRegistryFlag class>>#disabledDuring:}}. Processes forked meanwhile inherit the override; other processes keep the global value.
"
Class {
	#name : #LeUseMixedSubscriptionRegistryOverride,
	#superclass : #DynamicVariable,
	#category : #'Lepiter-Core'
}

{ #category : #testing }
LeUseMixedSubscriptionRegistryOverride class >> isInheritable [
	^true
]
