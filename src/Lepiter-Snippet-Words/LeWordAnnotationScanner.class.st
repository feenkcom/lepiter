Class {
	#name : #LeWordAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #'generated-initialization' }
LeWordAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(8 'expanded' 2) #(8 'false' 3) #(8 'height' 4) #(8 'true' 5) #(8 'word' 6))
		do: [ :each | (keywordMap at: each first ifAbsentPut: [ Dictionary new ]) at: (each at: 2) put: each last ].
	^ keywordMap
]

{ #category : #generated }
LeWordAnnotationScanner >> emptySymbolTokenId [
	^ 19
]

{ #category : #generated }
LeWordAnnotationScanner >> errorTokenId [
	^ 20
]

{ #category : #generated }
LeWordAnnotationScanner >> scanForToken [
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter isDigit
		ifTrue:
			[ [ self recordMatch: #(10).
			self step.
			currentCharacter isDigit ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ [ self recordMatch: #(9).
			self step.
			currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ] whileTrue.
			^ self reportLastMatch ].
	currentCharacter isLetter
		ifTrue:
			[ [ self recordMatch: #(8).
			self step.
			currentCharacter isLetter ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeWordAnnotationScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil #whitespace)
]
