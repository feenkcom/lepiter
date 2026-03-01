Trait {
	#name : #TLePragmaParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #generated }
TLePragmaParseNodeVisitor >> visitPragmaAnnotation: aPragmaAnnotation [
	^ self visitPragmaParse: aPragmaAnnotation
]

{ #category : #generated }
TLePragmaParseNodeVisitor >> visitPragmaArgument: aPragmaArgument [
	^ self visitPragmaParse: aPragmaArgument
]

{ #category : #generated }
TLePragmaParseNodeVisitor >> visitPragmaName: aPragmaName [
	^ self visitPragmaArgument: aPragmaName
]

{ #category : #generated }
TLePragmaParseNodeVisitor >> visitPragmaParse: aPragmaParse [
	^ self visitSmaCCParseNode: aPragmaParse
]
