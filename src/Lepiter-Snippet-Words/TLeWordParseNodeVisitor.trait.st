Trait {
	#name : #TLeWordParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #generated }
TLeWordParseNodeVisitor >> visitWordAnnotation: aWordAnnotation [
	^ self visitWordParse: aWordAnnotation
]

{ #category : #generated }
TLeWordParseNodeVisitor >> visitWordArgument: aWordArgument [
	^ self visitWordParse: aWordArgument
]

{ #category : #generated }
TLeWordParseNodeVisitor >> visitWordExpanded: aWordExpanded [
	^ self visitWordArgument: aWordExpanded
]

{ #category : #generated }
TLeWordParseNodeVisitor >> visitWordHeight: aWordHeight [
	^ self visitWordArgument: aWordHeight
]

{ #category : #generated }
TLeWordParseNodeVisitor >> visitWordParse: aWordParse [
	^ self visitSmaCCParseNode: aWordParse
]

{ #category : #generated }
TLeWordParseNodeVisitor >> visitWordValue: aWordValue [
	^ self visitWordArgument: aWordValue
]
