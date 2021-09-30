Class {
	#name : #LeSnippetActionTarget,
	#superclass : #GtPhlowActionTarget,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Lepiter-UI-Snippet-! View Models'
}

{ #category : #accessing }
LeSnippetActionTarget class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
LeSnippetActionTarget class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]
