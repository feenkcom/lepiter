Class {
	#name : #LeCommonSnippetStateExtractor,
	#superclass : #LeSnippetStateExtractor,
	#category : #'Lepiter-History-State'
}

{ #category : #accessing }
LeCommonSnippetStateExtractor >> ignoredAttributeNames [
	^ self fixedAttributeNames
]

{ #category : #selecting }
LeCommonSnippetStateExtractor >> selectedAttributes [
	| commonAttributesNames |
	commonAttributesNames := self commonMetadataAttributeNames.
	
	^ super selectedAttributes
		select: [ :anAttribute |
			commonAttributesNames includes:  anAttribute attributeName ]
]
