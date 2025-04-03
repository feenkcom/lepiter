Class {
	#name : #LePictureAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #'generated-initialization' }
LePictureAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(5 'reference' 2))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
LePictureAnnotationScanner >> emptySymbolTokenId [
	^ 12
]

{ #category : #generated }
LePictureAnnotationScanner >> errorTokenId [
	^ 13
]

{ #category : #generated }
LePictureAnnotationScanner >> scanForToken [
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(4).
			self step.
			currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ]
				whileTrue.
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric
		ifTrue: [ [ self recordMatch: #(5).
			self step.
			currentCharacter isAlphaNumeric ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LePictureAnnotationScanner >> tokenActions [
	^ #(nil nil nil #whitespace)
]
