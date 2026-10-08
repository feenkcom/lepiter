Trait {
	#name : #TGtShellScriptProgramNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #generated }
TGtShellScriptProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]

{ #category : #generated }
TGtShellScriptProgramNodeVisitor >> visitString: aString [
	^ self visitProgram: aString
]
