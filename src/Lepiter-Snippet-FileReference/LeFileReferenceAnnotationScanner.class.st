Class {
	#name : #LeFileReferenceAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #'generated-initialization' }
LeFileReferenceAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(13 'expanded' 3) #(13 'false' 4) #(13 'height' 5) #(13 'label' 6) #(13 'path' 7) #(13 'range' 8) #(13 'true' 9))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> emptySymbolTokenId [
	^ 27
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> errorTokenId [
	^ 28
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> scan1 [
	[ self recordMatch: #(13).
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan1X1 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp
				or: [ (':=' includes: currentCharacter) or: [ currentCharacter between: $| and: $} ] ] ])
		ifTrue: [ ^ self scan2 ].
	true ] whileTrue
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> scan1X1 [
	self recordMatch: #(13 14).
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan1 ].
	(currentCharacter <= Character backspace
		or: [ (currentCharacter between: (Character value: 14) and: Character arrowDown)
				or: [ (currentCharacter between: $! and: $9)
						or: [ (currentCharacter between: $; and: $<)
								or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(13).
			self step.
			currentCharacter <= Character backspace
				or: [ (currentCharacter between: (Character value: 14) and: Character arrowDown)
						or: [ (currentCharacter between: $! and: $9)
								or: [ (currentCharacter between: $; and: $<)
										or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> scan2 [
	[ self step.
	currentCharacter == $"
		ifTrue: [ self recordMatch: #(14).
			self step.
			currentCharacter == $" ifTrue: [ ^ self scan2 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> scanForToken [
	self step.
	currentCharacter == $" ifTrue: [ ^ self scan1 ].
	currentCharacter == $: ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter isDigit ifTrue: [ ^ self scanForTokenX1 ].
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
		ifTrue: [ ^ self scanForTokenX4 ].
	((currentCharacter between: $A and: $Z)
		or: [ currentCharacter between: $a and: $z ])
		ifTrue: [ ^ self scanForTokenX2 ].
	(currentCharacter <= ${ or: [ currentCharacter >= $~ ])
		ifTrue: [ self scanForTokenX3 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> scanForTokenX1 [
	[ self recordMatch: #(12 13).
	self step.
	currentCharacter isDigit ] whileTrue.
	(currentCharacter <= Character backspace
		or: [ (currentCharacter between: (Character value: 14) and: Character arrowDown)
				or: [ (currentCharacter between: $! and: $/)
						or: [ (currentCharacter between: $; and: $<)
								or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(13).
			self step.
			currentCharacter <= Character backspace
				or: [ (currentCharacter between: (Character value: 14) and: Character arrowDown)
						or: [ (currentCharacter between: $! and: $9)
								or: [ (currentCharacter between: $; and: $<)
										or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> scanForTokenX2 [
	self recordMatch: #(13).
	self step.
	(currentCharacter <= Character backspace
		or: [ (currentCharacter between: (Character value: 14) and: Character arrowDown)
				or: [ (currentCharacter between: $! and: $<)
						or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] ])
		ifTrue: [ [ self recordMatch: #(13).
			self step.
			currentCharacter <= Character backspace
				or: [ (currentCharacter between: (Character value: 14) and: Character arrowDown)
						or: [ (currentCharacter between: $! and: $9)
								or: [ (currentCharacter between: $; and: $<)
										or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> scanForTokenX3 [
	[ self recordMatch: #(13).
	self step.
	currentCharacter <= Character backspace
		or: [ (currentCharacter between: (Character value: 14) and: Character arrowDown)
				or: [ (currentCharacter between: $! and: $9)
						or: [ (currentCharacter between: $; and: $<)
								or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] ] ] ]
		whileTrue
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> scanForTokenX4 [
	[ self recordMatch: #(11).
	self step.
	currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeFileReferenceAnnotationScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil #whitespace)
]
