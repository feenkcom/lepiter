Class {
	#name : #LeObjectReferenceAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #generated }
LeObjectReferenceAnnotationScanner class >> createParserOnStream: aStream startingAt: anInteger [
	^LeObjectReferenceAnnotationParser createParserOnStream: aStream
		startingAt: anInteger
]

{ #category : #initialization }
LeObjectReferenceAnnotationScanner class >> initialize [
	LeParser annotationParsers at: 'gtObject'
		put: 
			[:parser |
			parser spawnParser: self startingAt: self startingStateForObjectAnnotation]
]

{ #category : #'generated-initialization' }
LeObjectReferenceAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(13 'expanded' 3) #(13 'fallbackLabel' 4) #(13 'false' 5) #(13 'height' 6) #(13 'id' 7) #(13 'label' 8) #(13 'show' 9) #(13 'true' 10))
		do: 
			[:each |
			(keywordMap at: each first ifAbsentPut: [Dictionary new]) at: (each at: 2)
				put: each last].
	^keywordMap
]

{ #category : #initialization }
LeObjectReferenceAnnotationScanner class >> obsolete [
	LeParser annotationParsers removeKey: 'gtObject' ifAbsent: [].
	^super obsolete
]

{ #category : #parsing }
LeObjectReferenceAnnotationScanner class >> parseEmbeddedStream: aStream startingAt: anInteger [
	| parser |
	parser := self createParserOnStream: aStream startingAt: anInteger.
	parser enableEmbeddedParsing.
	^parser parse
]

{ #category : #generated }
LeObjectReferenceAnnotationScanner class >> startingStateForObjectAnnotation [
	^LeObjectReferenceAnnotationParser
		startingStateForObjectReferenceAnnotation
]

{ #category : #generated }
LeObjectReferenceAnnotationScanner >> emptySymbolTokenId [
	^26
]

{ #category : #generated }
LeObjectReferenceAnnotationScanner >> errorTokenId [
	^27
]

{ #category : #generated }
LeObjectReferenceAnnotationScanner >> scan1 [
	
	[self step.
	currentCharacter isDigit
		ifTrue: 
			[
			[self recordMatch: #(12).
			self step.
			currentCharacter isDigit
				or: [currentCharacter == $- or: [currentCharacter between: $a and: $z]]]
					whileTrue.
			^self reportLastMatch].
	currentCharacter == $- or: [currentCharacter between: $a and: $z]]
			whileTrue.
	^self reportLastMatch
]

{ #category : #generated }
LeObjectReferenceAnnotationScanner >> scanForToken [
	self step.
	currentCharacter == $# ifTrue: [^self recordAndReportMatch: #(1)].
	currentCharacter == $- ifTrue: [^self scan1].
	currentCharacter == $= ifTrue: [^self recordAndReportMatch: #(2)].
	currentCharacter == $| ifTrue: [^self recordAndReportMatch: #(11)].
	currentCharacter isDigit
		ifTrue: 
			[
			[self recordMatch: #(12).
			self step.
			currentCharacter isDigit
				or: [currentCharacter == $- or: [currentCharacter between: $a and: $z]]]
					whileTrue.
			^self reportLastMatch].
	(currentCharacter between: $A and: $Z)
		ifTrue: 
			[
			[self recordMatch: #(13).
			self step.
			(currentCharacter between: $0 and: $:) or: 
					[(currentCharacter between: $A and: $Z)
						or: [currentCharacter between: $a and: $z]]]
					whileTrue.
			^self reportLastMatch].
	(currentCharacter between: $a and: $z) ifTrue: [^self scanForTokenX1].
	(currentCharacter isSeparator or: [currentCharacter == Character pageUp])
		ifTrue: 
			[
			[self recordMatch: #(14).
			self step.
			currentCharacter isSeparator or: [currentCharacter == Character pageUp]]
					whileTrue].
	^self reportLastMatch
]

{ #category : #generated }
LeObjectReferenceAnnotationScanner >> scanForTokenX1 [
	
	[self recordMatch: #(13).
	self step.
	currentCharacter == $- ifTrue: [^self scan1].
	currentCharacter isDigit
		ifTrue: 
			[
			[self recordMatch: #(12 13).
			self step.
			currentCharacter == $-
				ifTrue: 
					[
					[self recordMatch: #(12).
					self step.
					currentCharacter isDigit
						or: [currentCharacter == $- or: [currentCharacter between: $a and: $z]]]
							whileTrue.
					^self reportLastMatch].
			(currentCharacter == $: or: [currentCharacter between: $A and: $Z])
				ifTrue: 
					[
					[self recordMatch: #(13).
					self step.
					(currentCharacter between: $0 and: $:) or: 
							[(currentCharacter between: $A and: $Z)
								or: [currentCharacter between: $a and: $z]]]
							whileTrue.
					^self reportLastMatch].
			(currentCharacter between: $0 and: $9)
				or: [currentCharacter between: $a and: $z]]
					whileTrue.
			^self reportLastMatch].
	currentCharacter between: $a and: $z]
			whileTrue.
	(currentCharacter == $: or: [currentCharacter between: $A and: $Z])
		ifTrue: 
			[
			[self recordMatch: #(13).
			self step.
			(currentCharacter between: $0 and: $:) or: 
					[(currentCharacter between: $A and: $Z)
						or: [currentCharacter between: $a and: $z]]]
					whileTrue].
	^self reportLastMatch
]

{ #category : #generated }
LeObjectReferenceAnnotationScanner >> tokenActions [
	^#(nil nil nil nil nil nil nil nil nil nil nil nil nil #whitespace)
]
