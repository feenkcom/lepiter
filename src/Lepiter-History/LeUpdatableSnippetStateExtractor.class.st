Class {
	#name : #LeUpdatableSnippetStateExtractor,
	#superclass : #LeSnippetStateExtractor,
	#instVars : [
		'targetState'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #accessing }
LeUpdatableSnippetStateExtractor >> ignoredAttributeNames [
	^ self fixedAttributeNames
]

{ #category : #accessing }
LeUpdatableSnippetStateExtractor >> selectedAttributes [
	| selectedAttributes |
	selectedAttributes := super selectedAttributes.
	
	^ self targetState 
		ifNil: [ selectedAttributes ]
		ifNotNil: [ :aState |
			^ selectedAttributes
				select: [ :anAttribute |
					aState hasAttributeNamed: anAttribute attributeName ] ]
]

{ #category : #accessing }
LeUpdatableSnippetStateExtractor >> targetState [
	^ targetState
]

{ #category : #accessing }
LeUpdatableSnippetStateExtractor >> targetState: anAttributeState [
	targetState := anAttributeState
]
