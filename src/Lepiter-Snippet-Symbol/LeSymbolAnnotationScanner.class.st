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
LeSymbolAnnotationScanner >> scan1 [
	self step.
	('-:_' includes: currentCharacter)
		ifTrue: [ self step.
			currentCharacter == $" ifTrue: [ ^ self scan2 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
LeSymbolAnnotationScanner >> scan2 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan1 ].
	currentCharacter isAlphaNumeric ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeSymbolAnnotationScanner >> scanForToken [
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan1 ].
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ]
				whileTrue.
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeSymbolAnnotationScanner >> tokenActions [
	^ #(nil nil nil #whitespace)
]
