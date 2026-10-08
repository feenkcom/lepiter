Class {
	#name : #GtShellScriptScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Snippet-Shell-Parser'
}

{ #category : #generated }
GtShellScriptScanner >> emptySymbolTokenId [
	^ 4
]

{ #category : #generated }
GtShellScriptScanner >> errorTokenId [
	^ 5
]

{ #category : #generated }
GtShellScriptScanner >> scanForToken [
	self step.
	true
		ifTrue: [ [ self recordMatch: #(1).
			self step.
			true ] whileTrue ].
	^ self reportLastMatch
]
