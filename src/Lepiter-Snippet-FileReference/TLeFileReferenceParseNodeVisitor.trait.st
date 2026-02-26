Trait {
	#name : #TLeFileReferenceParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #generated }
TLeFileReferenceParseNodeVisitor >> visitFileReferenceAnnotation: aFileReferenceAnnotation [
	^ self visitFileReferenceParse: aFileReferenceAnnotation
]

{ #category : #generated }
TLeFileReferenceParseNodeVisitor >> visitFileReferenceArgument: aFileReferenceArgument [
	^ self visitFileReferenceParse: aFileReferenceArgument
]

{ #category : #generated }
TLeFileReferenceParseNodeVisitor >> visitFileReferenceExpanded: aFileReferenceExpanded [
	^ self visitFileReferenceArgument: aFileReferenceExpanded
]

{ #category : #generated }
TLeFileReferenceParseNodeVisitor >> visitFileReferenceHeight: aFileReferenceHeight [
	^ self visitFileReferenceArgument: aFileReferenceHeight
]

{ #category : #generated }
TLeFileReferenceParseNodeVisitor >> visitFileReferenceLabel: aFileReferenceLabel [
	^ self visitFileReferenceArgument: aFileReferenceLabel
]

{ #category : #generated }
TLeFileReferenceParseNodeVisitor >> visitFileReferenceParse: aFileReferenceParse [
	^ self visitSmaCCParseNode: aFileReferenceParse
]

{ #category : #generated }
TLeFileReferenceParseNodeVisitor >> visitFileReferencePath: aFileReferencePath [
	^ self visitFileReferenceArgument: aFileReferencePath
]

{ #category : #generated }
TLeFileReferenceParseNodeVisitor >> visitFileReferenceRange: aFileReferenceRange [
	^ self visitFileReferenceArgument: aFileReferenceRange
]
