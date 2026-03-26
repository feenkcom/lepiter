Class {
	#name : #LeSymbolAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #'generated-initialization' }
LeSymbolAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(3 'symbol' 2))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
LeSymbolAnnotationScanner >> emptySymbolTokenId [
	^ 8
]

{ #category : #generated }
LeSymbolAnnotationScanner >> errorTokenId [
	^ 9
]

{ #category : #generated }
LeSymbolAnnotationScanner >> scanForToken [
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ]
				whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isAlphaNumeric or: [ '-:_' includes: currentCharacter ])
		ifTrue: [ [ self recordMatch: #(3).
			self step.
			currentCharacter isAlphaNumeric or: [ '-:_' includes: currentCharacter ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeSymbolAnnotationScanner >> tokenActions [
	^ #(nil nil nil #whitespace)
]
