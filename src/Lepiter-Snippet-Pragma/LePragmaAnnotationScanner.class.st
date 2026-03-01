Class {
	#name : #LePragmaAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #'generated-initialization' }
LePragmaAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(5 'pragma' 2))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
LePragmaAnnotationScanner >> emptySymbolTokenId [
	^ 12
]

{ #category : #generated }
LePragmaAnnotationScanner >> errorTokenId [
	^ 13
]

{ #category : #generated }
LePragmaAnnotationScanner >> scan1 [
	self step.
	(':_' includes: currentCharacter)
		ifTrue: [ self step.
			currentCharacter == $" ifTrue: [ ^ self scan2 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
LePragmaAnnotationScanner >> scan2 [
	[ self recordMatch: #(5).
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan1 ].
	currentCharacter isAlphaNumeric ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LePragmaAnnotationScanner >> scanForToken [
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan1 ].
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(3) ].
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
LePragmaAnnotationScanner >> tokenActions [
	^ #(nil nil nil #whitespace)
]
