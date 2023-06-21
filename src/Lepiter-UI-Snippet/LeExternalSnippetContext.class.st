Class {
	#name : #LeExternalSnippetContext,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'Lepiter-UI-Snippet-! View Models'
}

{ #category : #'gt - extensions' }
LeExternalSnippetContext >> gtViewPropertiesFor: aView [
	<gtView>
	
	properties ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Properties';
		priority: 100;
		object: [ properties ];
		view: #gtItemsFor:
]

{ #category : #accessing }
LeExternalSnippetContext >> properties [
	^ properties ifNil: [
		properties := OrderedDictionary new ]
]

{ #category : #accessing }
LeExternalSnippetContext >> propertyNamed: aPropertyName [
	^ self properties at: aPropertyName
]

{ #category : #accessing }
LeExternalSnippetContext >> propertyNamed: aPropertyName ifAbsent: anAbsentBlock [
	^ self properties at: aPropertyName ifAbsent: anAbsentBlock
]

{ #category : #accessing }
LeExternalSnippetContext >> propertyNamed: aPropertyName put: aValue [
	^ self properties at: aPropertyName put: aValue
]
