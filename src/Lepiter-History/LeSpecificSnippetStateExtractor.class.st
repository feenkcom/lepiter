Class {
	#name : #LeSpecificSnippetStateExtractor,
	#superclass : #LeSnippetStateExtractor,
	#category : #'Lepiter-History-State'
}

{ #category : #accessing }
LeSpecificSnippetStateExtractor >> ignoredAttributeNames [
	^ self fixedAttributeNames, self commonMetadataAttributeNames
]
