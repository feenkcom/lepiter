Class {
	#name : #GtShellScriptStringNode,
	#superclass : #GtShellScriptProgramNode,
	#category : #'Lepiter-Snippet-Shell-Parser'
}

{ #category : #generated }
GtShellScriptStringNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitString: self
]
