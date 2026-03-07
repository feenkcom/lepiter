Class {
	#name : #LePragmaAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #'generated-initialization' }
LePragmaAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(8 'expanded' 2) #(8 'false' 3) #(8 'pragma' 4) #(8 'true' 5))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
LePragmaAnnotationScanner >> emptySymbolTokenId [
	^ 16
]

{ #category : #generated }
LePragmaAnnotationScanner >> errorTokenId [
	^ 17
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
	[ self recordMatch: #(8).
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
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(7).
			self step.
			currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ]
				whileTrue.
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
LePragmaAnnotationScanner >> tokenActions [
	^ #(nil nil nil nil nil nil #whitespace)
]
