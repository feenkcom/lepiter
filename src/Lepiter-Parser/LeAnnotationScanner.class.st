Class {
	#name : #LeAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Parser'
}

{ #category : #'generated-initialization' }
LeAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(2 'alignment' #(17 #(#default))) #(2 'class' #(28 #(#default))) #(2 'classTrait' #(28 #(#default))) #(2 'codeExpanded' #(24 #(#default))) #(2 'completed' #(32 #(#default))) #(2 'documentWidth' #(25 #(#default))) #(2 'due' #(33 #(#default))) #(2 'full' #(10 #(#default))) #(2 'fullWidth' #(26 #(#default))) #(2 'name' #(7 #(#default))) #(2 'noCode' #(22 #(#default))) #(2 'paragraphWidth' #(27 #(#default))) #(2 'previewExpanded' #(20 #(#default))) #(2 'previewHeight' #(21 #(#default))) #(2 'previewSelect' #(19 #(#default))) #(2 'previewShow' #(18 #(#default))) #(2 'return' #(16 #(#default))) #(2 'tag' #(37 #(#default))) #(3 '>>' #(23 #(#default))) #(3 'alignment' #(17 #(#default))) #(3 'class' #(28 #(#default))) #(3 'classTrait' #(28 #(#default))) #(3 'codeExpanded' #(24 #(#default))) #(3 'completed' #(32 #(#default))) #(3 'documentWidth' #(25 #(#default))) #(3 'due' #(33 #(#default))) #(3 'full' #(10 #(#default))) #(3 'fullWidth' #(26 #(#default))) #(3 'name' #(7 #(#default))) #(3 'noCode' #(22 #(#default))) #(3 'paragraphWidth' #(27 #(#default))) #(3 'previewExpanded' #(20 #(#default))) #(3 'previewHeight' #(21 #(#default))) #(3 'previewSelect' #(19 #(#default))) #(3 'previewShow' #(18 #(#default))) #(3 'return' #(16 #(#default))) #(3 'tag' #(37 #(#default))))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
LeAnnotationScanner >> emptySymbolTokenId [
	^ 88
]

{ #category : #generated }
LeAnnotationScanner >> errorTokenId [
	^ 89
]

{ #category : #generated }
LeAnnotationScanner >> scan1 [
	self step.
	currentCharacter == $# ifTrue: [ ^ self scan1X1 ].
	currentCharacter == $- ifTrue: [ ^ self scan1X2 ].
	currentCharacter == $= ifTrue: [ ^ self scan9 ].
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	currentCharacter == $d ifTrue: [ ^ self scan1X10 ].
	currentCharacter == $e ifTrue: [ ^ self scan11 ].
	currentCharacter == $f ifTrue: [ ^ self scan1X7 ].
	currentCharacter == $h ifTrue: [ ^ self scan1X3 ].
	currentCharacter == $i ifTrue: [ ^ self scan1X9 ].
	currentCharacter == $l ifTrue: [ ^ self scan1X4 ].
	currentCharacter == $s ifTrue: [ ^ self scan1X6 ].
	currentCharacter == $t ifTrue: [ ^ self scan1X8 ].
	^ self scan1X13
]

{ #category : #generated }
LeAnnotationScanner >> scan10 [
	[ self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan11 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $x
		ifTrue: [ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $p
				ifTrue: [ self recordMatch: #(2 3).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan4 ].
					currentCharacter == $a
						ifTrue: [ self recordMatch: #(2 3).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan4 ].
							currentCharacter == $n
								ifTrue: [ self recordMatch: #(2 3).
									self step.
									currentCharacter == $: ifTrue: [ ^ self scan4 ].
									currentCharacter == $d
										ifTrue: [ self recordMatch: #(2 3).
											self step.
											currentCharacter == $: ifTrue: [ ^ self scan4 ].
											currentCharacter == $e
												ifTrue: [ self recordMatch: #(2 3).
													self step.
													currentCharacter == $: ifTrue: [ ^ self scan4 ].
													currentCharacter == $d
														ifTrue: [ self recordMatch: #(2 3 11).
															self step.
															currentCharacter == $: ifTrue: [ ^ self scan4 ] ] ] ] ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan12 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $e
		ifTrue: [ self recordMatch: #(2 3 12).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan13 [
	[ self recordMatch: #(5).
	self step.
	currentCharacter == $\
		ifTrue: [ self recordMatch: #(5).
			self step.
			^ self scan13 ].
	currentCharacter <= ${ or: [ currentCharacter >= $~ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14 [
	self step.
	currentCharacter == $# ifTrue: [ ^ self scan14X1 ].
	currentCharacter == $= ifTrue: [ ^ self scan9 ].
	currentCharacter == $\ ifTrue: [ ^ self scan16 ].
	currentCharacter == $d ifTrue: [ ^ self scan14X5 ].
	currentCharacter == $e ifTrue: [ ^ self scan19 ].
	currentCharacter == $f ifTrue: [ ^ self scan14X2 ].
	currentCharacter == $h ifTrue: [ ^ self scan25 ].
	currentCharacter == $i ifTrue: [ ^ self scan14X4 ].
	currentCharacter == $l ifTrue: [ ^ self scan28 ].
	currentCharacter == $s ifTrue: [ ^ self scan30 ].
	currentCharacter == $t ifTrue: [ ^ self scan14X3 ].
	^ self scan14X8
]

{ #category : #generated }
LeAnnotationScanner >> scan14X1 [
	self recordMatch: #(29).
	^ self scan14X1X2
]

{ #category : #generated }
LeAnnotationScanner >> scan14X1X1 [
	[ self recordMatch: #(29).
	self step.
	currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
		whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan14X1X2 [
	self step.
	currentCharacter == $= ifTrue: [ ^ self scan2 ].
	currentCharacter == $\ ifTrue: [ ^ self scan16 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan15 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= ${
		or: [ currentCharacter between: (Character value: 127) and: (Character value: 247) ])
		ifTrue: [ self scan14X1X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X2 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $a
		ifTrue: [ self recordMatch: #(3 29).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $l
				ifTrue: [ self recordMatch: #(3 29).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan18 ].
					currentCharacter == $s ifTrue: [ ^ self scan24 ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X3 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $r
		ifTrue: [ self recordMatch: #(3 29).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $u ifTrue: [ ^ self scan24 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X4 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $d
		ifTrue: [ self recordMatch: #(3 29 35).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X5 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $b
		ifTrue: [ self recordMatch: #(3 29 30).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X6 [
	[ self recordMatch: #(4 29).
	self step.
	currentCharacter isDigit ] whileTrue.
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X7 [
	[ self recordMatch: #(29).
	self step.
	currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
		whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan14X8 [
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	currentCharacter isDigit ifTrue: [ ^ self scan14X6 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan15 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= ${
		or: [ currentCharacter between: (Character value: 127) and: (Character value: 247) ])
		ifTrue: [ self scan14X7 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan15 [
	[ self recordMatch: #(3 29).
	self step.
	currentCharacter == $= ifTrue: [ ^ self scan2 ].
	currentCharacter == $\ ifTrue: [ ^ self scan16 ].
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ] ]
		whileTrue.
	(currentCharacter <= ${ or: [ currentCharacter >= (Character value: 127) ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan16 [
	self recordMatch: #(29).
	self step.
	('=|' includes: currentCharacter) ifTrue: [ ^ self scan2 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self scan15 ].
	(currentCharacter <= ${ or: [ currentCharacter >= (Character value: 127) ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan17 [
	[ self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan18 [
	self recordMatch: #(3 29).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan19 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $x ifTrue: [ ^ self scan20 ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X1 [
	self step.
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X10 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $b
		ifTrue: [ self recordMatch: #(2 3 30).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X11 [
	self recordMatch: #(4 34).
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan8 ].
	currentCharacter isDigit
		ifTrue: [ self recordMatch: #(4 34).
			self step.
			currentCharacter == $- ifTrue: [ ^ self scan8 ].
			currentCharacter isDigit
				ifTrue: [ self recordMatch: #(4 34).
					self step.
					currentCharacter == $- ifTrue: [ ^ self scan8 ].
					currentCharacter isDigit
						ifTrue: [ self recordMatch: #(4 34).
							self step.
							currentCharacter == $- ifTrue: [ ^ self scan8 ].
							currentCharacter isDigit
								ifTrue: [ [ self recordMatch: #(4).
									self step.
									currentCharacter isDigit ] whileTrue ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X12 [
	[ self recordMatch: #(6).
	self step.
	currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X13 [
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	currentCharacter isDigit ifTrue: [ ^ self scan1X11 ].
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
		ifTrue: [ ^ self scan1X12 ].
	currentCharacter isUppercase ifTrue: [ ^ self scan1X5 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X2 [
	self recordMatch: #(3 34).
	self step.
	currentCharacter == $-
		ifTrue: [ self recordMatch: #(3 34).
			self step.
			currentCharacter == $\ ifTrue: [ ^ self scan3 ].
			currentCharacter isDigit ifTrue: [ ^ self scan5 ].
			(currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
				ifTrue: [ ^ self scan2 ].
			^ self reportLastMatch ].
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	currentCharacter isDigit ifTrue: [ ^ self scan6 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X3 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $e
		ifTrue: [ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $i
				ifTrue: [ self recordMatch: #(2 3).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan4 ].
					currentCharacter == $g
						ifTrue: [ self recordMatch: #(2 3).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan4 ].
							currentCharacter == $h
								ifTrue: [ self recordMatch: #(2 3).
									self step.
									currentCharacter == $: ifTrue: [ ^ self scan4 ].
									currentCharacter == $t
										ifTrue: [ self recordMatch: #(2 3 14).
											self step.
											currentCharacter == $: ifTrue: [ ^ self scan4 ] ] ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X4 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $a
		ifTrue: [ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $b
				ifTrue: [ self recordMatch: #(2 3).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan4 ].
					currentCharacter == $e
						ifTrue: [ self recordMatch: #(2 3).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan4 ].
							currentCharacter == $l
								ifTrue: [ self recordMatch: #(2 3 9).
									self step.
									currentCharacter == $: ifTrue: [ ^ self scan4 ] ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X5 [
	[ self recordMatch: #(1 2 3 36).
	self step.
	currentCharacter == $-
		ifTrue: [ [ self recordMatch: #(36).
			self step.
			currentCharacter isAlphaNumeric or: [ '-_' includes: currentCharacter ] ]
				whileTrue.
			^ self reportLastMatch ].
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X6 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $h
		ifTrue: [ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $o
				ifTrue: [ self recordMatch: #(2 3).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan4 ].
					currentCharacter == $w
						ifTrue: [ self recordMatch: #(2 3 13).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan4 ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X7 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $a
		ifTrue: [ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $l
				ifTrue: [ self recordMatch: #(2 3).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan4 ].
					currentCharacter == $s ifTrue: [ ^ self scan12 ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X8 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $r
		ifTrue: [ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $u ifTrue: [ ^ self scan12 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X9 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $d
		ifTrue: [ self recordMatch: #(2 3 35).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan2 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan20 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $p ifTrue: [ ^ self scan21 ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan21 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $a ifTrue: [ ^ self scan22 ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan22 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $n ifTrue: [ ^ self scan23 ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan23 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $d
		ifTrue: [ self recordMatch: #(3 29).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $e
				ifTrue: [ self recordMatch: #(3 29).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan18 ].
					currentCharacter == $d
						ifTrue: [ self recordMatch: #(3 11 29).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan18 ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan24 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $e
		ifTrue: [ self recordMatch: #(3 12 29).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan25 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $e ifTrue: [ ^ self scan26 ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan26 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $i ifTrue: [ ^ self scan27 ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan27 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $g
		ifTrue: [ self recordMatch: #(3 29).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $h
				ifTrue: [ self recordMatch: #(3 29).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan18 ].
					currentCharacter == $t
						ifTrue: [ self recordMatch: #(3 14 29).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan18 ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan28 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $a ifTrue: [ ^ self scan29 ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan29 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $b
		ifTrue: [ self recordMatch: #(3 29).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $e
				ifTrue: [ self recordMatch: #(3 29).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan18 ].
					currentCharacter == $l
						ifTrue: [ self recordMatch: #(3 9 29).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan18 ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan3 [
	self step.
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan30 [
	self recordMatch: #(3 29).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $h
		ifTrue: [ self recordMatch: #(3 29).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $o
				ifTrue: [ self recordMatch: #(3 29).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan18 ].
					currentCharacter == $w
						ifTrue: [ self recordMatch: #(3 13 29).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan18 ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $<
		or: [ (currentCharacter between: $> and: ${)
				or: [ currentCharacter between: $~ and: (Character value: 247) ] ])
		ifTrue: [ [ self recordMatch: #(29).
			self step.
			currentCharacter <= $<
				or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan4 [
	self recordMatch: #(3).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan5 [
	self recordMatch: #(34).
	self step.
	currentCharacter isDigit ifTrue: [ ^ self recordAndReportMatch: #(34) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan6 [
	self recordMatch: #(34).
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan7 ].
	currentCharacter isDigit
		ifTrue: [ self recordMatch: #(34).
			self step.
			currentCharacter == $- ifTrue: [ ^ self scan7 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan7 [
	self recordMatch: #(34).
	self step.
	currentCharacter isDigit ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan8 [
	self recordMatch: #(34).
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan7 ].
	currentCharacter isDigit ifTrue: [ ^ self scan6 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan9 [
	self recordMatch: #(3 8).
	self step.
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scanForToken [
	scope == #path ifTrue: [ ^ self scan14 ].
	scope == #label ifTrue: [ ^ self scan13 ].
	scope == #default ifTrue: [ ^ self scan1 ].
	scope == #uuid
		ifTrue: [ self step.
			(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
				ifTrue: [ self recordMatch: #(31).
					self step.
					(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
						ifTrue: [ self recordMatch: #(31).
							self step.
							(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
								ifTrue: [ self recordMatch: #(31).
									self step.
									(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
										ifTrue: [ self recordMatch: #(31).
											self step.
											(currentCharacter isDigit
												or: [ currentCharacter between: $a and: $z ])
												ifTrue: [ self recordMatch: #(31).
													self step.
													(currentCharacter isDigit
														or: [ currentCharacter between: $a and: $z ])
														ifTrue: [ self recordMatch: #(31).
															self step.
															(currentCharacter isDigit
																or: [ currentCharacter between: $a and: $z ])
																ifTrue: [ self recordMatch: #(31).
																	self step.
																	(currentCharacter isDigit
																		or: [ currentCharacter between: $a and: $z ])
																		ifTrue: [ self recordMatch: #(31).
																			self step.
																			(currentCharacter isDigit
																				or: [ currentCharacter between: $a and: $z ])
																				ifTrue: [ self recordMatch: #(31).
																					self step.
																					(currentCharacter isDigit
																						or: [ currentCharacter between: $a and: $z ])
																						ifTrue: [ self recordMatch: #(31).
																							self step.
																							(currentCharacter isDigit
																								or: [ currentCharacter between: $a and: $z ])
																								ifTrue: [ self recordMatch: #(31).
																									self step.
																									(currentCharacter isDigit
																										or: [ currentCharacter between: $a and: $z ])
																										ifTrue: [ self recordMatch: #(31).
																											self step.
																											(currentCharacter isDigit
																												or: [ currentCharacter between: $a and: $z ])
																												ifTrue: [ self recordMatch: #(31).
																													self step.
																													(currentCharacter isDigit
																														or: [ currentCharacter between: $a and: $z ])
																														ifTrue: [ self recordMatch: #(31).
																															self step.
																															(currentCharacter isDigit
																																or: [ currentCharacter between: $a and: $z ])
																																ifTrue: [ self recordMatch: #(31).
																																	self step.
																																	(currentCharacter isDigit
																																		or: [ currentCharacter between: $a and: $z ])
																																		ifTrue: [ self recordMatch: #(31).
																																			self step.
																																			(currentCharacter isDigit
																																				or: [ currentCharacter between: $a and: $z ])
																																				ifTrue: [ self recordMatch: #(31).
																																					self step.
																																					(currentCharacter isDigit
																																						or: [ currentCharacter between: $a and: $z ])
																																						ifTrue: [ self recordMatch: #(31).
																																							self step.
																																							(currentCharacter isDigit
																																								or: [ currentCharacter between: $a and: $z ])
																																								ifTrue: [ self recordMatch: #(31).
																																									self step.
																																									(currentCharacter isDigit
																																										or: [ currentCharacter between: $a and: $z ])
																																										ifTrue: [ self recordMatch: #(31).
																																											self step.
																																											(currentCharacter isDigit
																																												or: [ currentCharacter between: $a and: $z ])
																																												ifTrue: [ self recordMatch: #(31).
																																													self step.
																																													(currentCharacter isDigit
																																														or: [ currentCharacter between: $a and: $z ])
																																														ifTrue: [ self recordMatch: #(31).
																																															self step.
																																															(currentCharacter isDigit
																																																or: [ currentCharacter between: $a and: $z ])
																																																ifTrue: [ self recordMatch: #(31).
																																																	self step.
																																																	(currentCharacter isDigit
																																																		or: [ currentCharacter between: $a and: $z ])
																																																		ifTrue: [ self recordMatch: #(31).
																																																			self step.
																																																			(currentCharacter isDigit
																																																				or: [ currentCharacter between: $a and: $z ])
																																																				ifTrue: [ ^ self recordAndReportMatch: #(31) ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> tokenActions [
	^ #(nil nil nil nil nil #whitespace)
]
