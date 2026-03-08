Trait {
	#name : #TLeSymbolParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #generated }
TLeSymbolParseNodeVisitor >> visitSymbolAnnotation: aSymbolAnnotation [
	^ self visitSymbolParse: aSymbolAnnotation
]

{ #category : #generated }
TLeSymbolParseNodeVisitor >> visitSymbolName: aSymbolName [
	^ self visitSymbolParse: aSymbolName
]

{ #category : #generated }
TLeSymbolParseNodeVisitor >> visitSymbolParse: aSymbolParse [
	^ self visitSmaCCParseNode: aSymbolParse
]
