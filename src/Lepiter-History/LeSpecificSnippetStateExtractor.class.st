Class {
	#name : #LeSpecificSnippetStateExtractor,
	#superclass : #LeSnippetStateExtractor,
	#instVars : [
		'targetState'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #accessing }
LeSpecificSnippetStateExtractor >> ignoredAttributeNames [
	^ self fixedAttributeNames, self commonMetadataAttributeNames
]

{ #category : #accessing }
LeSpecificSnippetStateExtractor >> selectedAttributes [
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
LeSpecificSnippetStateExtractor >> targetState [
	^ targetState
]

{ #category : #accessing }
LeSpecificSnippetStateExtractor >> targetState: anObject [
	targetState := anObject
]
