"
LeSubSettings provides a means of grouping together settings under a common property, e.g. all the settings relating to PharoLink.

The settings are stored as a Dictionary under the parent property.
"
Class {
	#name : #LeSubSettings,
	#superclass : #Object,
	#instVars : [
		'dbProperties'
	],
	#category : 'Lepiter-Store-Settings'
}

{ #category : #accessing }
LeSubSettings >> dbProperties [
	^ dbProperties
]

{ #category : #accessing }
LeSubSettings >> dbProperties: anObject [
	dbProperties := anObject
]

{ #category : #ui }
LeSubSettings >> gtSettingsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Settings';
		priority: 1;
		items: [ self settingsNames ];
		column: #Item 
			text: [ :item | item ] 
			width: 170;
		column: #Value 
			text: [ :item | item value: self ];
		send: [ :item | item value: self ]
]

{ #category : #ui }
LeSubSettings >> settingsNames [

	^ #()
]

{ #category : #'private - accessing' }
LeSubSettings >> subProperties [
	"Answer the dictionary for the sub-properties"

	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
LeSubSettings >> subProperties: aDictionary [
	"Set the dictionary for the sub-properties"

	^ self subclassResponsibility
]

{ #category : #private }
LeSubSettings >> updateProperty: propertyName value: aJSONObject [
	| subDictionary |

	subDictionary := self subProperties copy.
	aJSONObject ifNil: 
		[ subDictionary removeKey: propertyName ifAbsent: [ ].
		^ self subProperties: subDictionary ].
	(subDictionary at: propertyName ifAbsent: [nil]) = aJSONObject ifTrue: [ ^ self ].
	subDictionary at: propertyName put: aJSONObject.
	self subProperties: subDictionary.
]
