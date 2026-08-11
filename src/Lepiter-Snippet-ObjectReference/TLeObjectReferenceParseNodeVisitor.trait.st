Trait {
	#name : #TLeObjectReferenceParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #generated }
TLeObjectReferenceParseNodeVisitor >> visitObjectReferenceAnnotation: anObjectReferenceAnnotation [
	^self visitObjectReferenceParse: anObjectReferenceAnnotation
]

{ #category : #generated }
TLeObjectReferenceParseNodeVisitor >> visitObjectReferenceArgument: anObjectReferenceArgument [
	^self visitObjectReferenceParse: anObjectReferenceArgument
]

{ #category : #generated }
TLeObjectReferenceParseNodeVisitor >> visitObjectReferenceExpanded: anObjectReferenceExpanded [
	^self visitObjectReferenceArgument: anObjectReferenceExpanded
]

{ #category : #generated }
TLeObjectReferenceParseNodeVisitor >> visitObjectReferenceFallbackLabel: anObjectReferenceFallbackLabel [
	^self visitObjectReferenceArgument: anObjectReferenceFallbackLabel
]

{ #category : #generated }
TLeObjectReferenceParseNodeVisitor >> visitObjectReferenceHeight: anObjectReferenceHeight [
	^self visitObjectReferenceArgument: anObjectReferenceHeight
]

{ #category : #generated }
TLeObjectReferenceParseNodeVisitor >> visitObjectReferenceId: anObjectReferenceId [
	^self visitObjectReferenceArgument: anObjectReferenceId
]

{ #category : #generated }
TLeObjectReferenceParseNodeVisitor >> visitObjectReferenceLabel: anObjectReferenceLabel [
	^self visitObjectReferenceArgument: anObjectReferenceLabel
]

{ #category : #generated }
TLeObjectReferenceParseNodeVisitor >> visitObjectReferenceParse: anObjectReferenceParse [
	^self visitSmaCCParseNode: anObjectReferenceParse
]

{ #category : #generated }
TLeObjectReferenceParseNodeVisitor >> visitObjectReferenceShow: anObjectReferenceShow [
	^self visitObjectReferenceArgument: anObjectReferenceShow
]
