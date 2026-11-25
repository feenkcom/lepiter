"
I decide which subscription registry the announcers of Lepiter models get when they are created: pages and snippets ({{gtMethod:LeContent>>#initialize}}), databases, logical databases and the store monitors all ask {{gtMethod:LeUseMixedSubscriptionRegistryFlag class>>#newAnnouncer}}.
When I am enabled they get a {{gtClass:GtMixedSubscriptionRegistry}}, otherwise a plain {{gtClass:SubscriptionRegistry}}; I am disabled by default. I am read only when a model is created: models that already exist keep their registry, and reloading a database keeps its existing pages, so after enabling me the databases have to be loaded again.
{{gtMethod:LeUseMixedSubscriptionRegistryFlag class>>#usePlainSubscriptionRegistriesIn:}} moves all announcers of a logical database, a database or a page back to plain registries, keeping their subscriptions. Subscriptions made or removed by other processes on the same announcers while it runs can be lost.
{{gtMethod:LeUseMixedSubscriptionRegistryFlag class>>#enabledDuring:}} and {{gtMethod:LeUseMixedSubscriptionRegistryFlag class>>#disabledDuring:}} override me only for the current process and the processes it forks meanwhile ({{gtClass:LeUseMixedSubscriptionRegistryOverride}}); they leave the global value untouched.
"
Class {
	#name : #LeUseMixedSubscriptionRegistryFlag,
	#superclass : #Object,
	#classVars : [
		'Enabled'
	],
	#category : #'Lepiter-Core'
}

{ #category : #configuration }
LeUseMixedSubscriptionRegistryFlag class >> disable [
	Enabled := false
]

{ #category : #configuration }
LeUseMixedSubscriptionRegistryFlag class >> disabledDuring: aBlock [
	^LeUseMixedSubscriptionRegistryOverride value: false during: aBlock
]

{ #category : #configuration }
LeUseMixedSubscriptionRegistryFlag class >> enable [
	Enabled := true
]

{ #category : #configuration }
LeUseMixedSubscriptionRegistryFlag class >> enabledDuring: aBlock [
	^LeUseMixedSubscriptionRegistryOverride value: true during: aBlock
]

{ #category : #testing }
LeUseMixedSubscriptionRegistryFlag class >> isEnabled [
	^LeUseMixedSubscriptionRegistryOverride value
		ifNil: [Enabled ifNil: [true]]
]

{ #category : #'instance creation' }
LeUseMixedSubscriptionRegistryFlag class >> newAnnouncer [
	^self isEnabled
		ifTrue: [Announcer new useMixedSubscriptionRegistry]
		ifFalse: [Announcer new]
]

{ #category : #switching }
LeUseMixedSubscriptionRegistryFlag class >> usePlainSubscriptionRegistriesIn: aLepiterModel [
	aLepiterModel
		withAllAnnouncersDo: [:each | each useSubscriptionRegistry: SubscriptionRegistry new]
]
