Class {
	#name : #LeAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Parser'
}

{ #category : #'generated-initialization' }
LeAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(2 'alignment' #(17 #(#default))) #(2 'class' #(27 #(#default))) #(2 'codeExpanded' #(23 #(#default))) #(2 'completed' #(31 #(#default))) #(2 'documentWidth' #(24 #(#default))) #(2 'due' #(32 #(#default))) #(2 'full' #(10 #(#default))) #(2 'fullWidth' #(25 #(#default))) #(2 'name' #(7 #(#default))) #(2 'noCode' #(21 #(#default))) #(2 'paragraphWidth' #(26 #(#default))) #(2 'previewExpanded' #(19 #(#default))) #(2 'previewHeight' #(20 #(#default))) #(2 'previewShow' #(18 #(#default))) #(2 'return' #(16 #(#default))) #(3 '>>' #(22 #(#default))) #(3 'alignment' #(17 #(#default))) #(3 'class' #(27 #(#default))) #(3 'codeExpanded' #(23 #(#default))) #(3 'completed' #(31 #(#default))) #(3 'documentWidth' #(24 #(#default))) #(3 'due' #(32 #(#default))) #(3 'full' #(10 #(#default))) #(3 'fullWidth' #(25 #(#default))) #(3 'name' #(7 #(#default))) #(3 'noCode' #(21 #(#default))) #(3 'paragraphWidth' #(26 #(#default))) #(3 'previewExpanded' #(19 #(#default))) #(3 'previewHeight' #(20 #(#default))) #(3 'previewShow' #(18 #(#default))) #(3 'return' #(16 #(#default))))
		do: [ :each | (keywordMap at: each first ifAbsentPut: [ Dictionary new ]) at: (each at: 2) put: each last ].
	^ keywordMap
]

{ #category : #generated }
LeAnnotationScanner >> emptySymbolTokenId [
	^ 77
]

{ #category : #generated }
LeAnnotationScanner >> errorTokenId [
	^ 78
]

{ #category : #generated }
LeAnnotationScanner >> scan1 [
	self step.
	currentCharacter == $# ifTrue: [ ^ self scan1X1 ].
	currentCharacter == $- ifTrue: [ ^ self scan1X2 ].
	currentCharacter == $= ifTrue: [ ^ self scan9 ].
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	currentCharacter == $d ifTrue: [ ^ self scan1X8 ].
	currentCharacter == $e ifTrue: [ ^ self scan11 ].
	currentCharacter == $f ifTrue: [ ^ self scan1X6 ].
	currentCharacter == $h ifTrue: [ ^ self scan1X3 ].
	currentCharacter == $l ifTrue: [ ^ self scan1X4 ].
	currentCharacter == $s ifTrue: [ ^ self scan1X5 ].
	currentCharacter == $t ifTrue: [ ^ self scan1X7 ].
	^ self scan1X12
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
		ifTrue:
			[ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $p
				ifTrue:
					[ self recordMatch: #(2 3).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan4 ].
					currentCharacter == $a
						ifTrue:
							[ self recordMatch: #(2 3).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan4 ].
							currentCharacter == $n
								ifTrue:
									[ self recordMatch: #(2 3).
									self step.
									currentCharacter == $: ifTrue: [ ^ self scan4 ].
									currentCharacter == $d
										ifTrue:
											[ self recordMatch: #(2 3).
											self step.
											currentCharacter == $: ifTrue: [ ^ self scan4 ].
											currentCharacter == $e
												ifTrue:
													[ self recordMatch: #(2 3).
													self step.
													currentCharacter == $: ifTrue: [ ^ self scan4 ].
													currentCharacter == $d
														ifTrue:
															[ self recordMatch: #(2 3 11).
															self step.
															currentCharacter == $: ifTrue: [ ^ self scan4 ] ] ] ] ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan12 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $e
		ifTrue:
			[ self recordMatch: #(2 3 12).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan13 [
	[ self recordMatch: #(5).
	self step.
	currentCharacter == $\
		ifTrue:
			[ self recordMatch: #(5).
			self step.
			^ self scan13 ].
	currentCharacter <= $[ or: [ (currentCharacter between: $] and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14 [
	self step.
	currentCharacter == $# ifTrue: [ ^ self scan14X1 ].
	currentCharacter == $= ifTrue: [ ^ self scan9 ].
	currentCharacter == $\ ifTrue: [ ^ self scan16 ].
	currentCharacter == $d ifTrue: [ ^ self scan14X4 ].
	currentCharacter == $e ifTrue: [ ^ self scan19 ].
	currentCharacter == $f ifTrue: [ ^ self scan14X2 ].
	currentCharacter == $h ifTrue: [ ^ self scan25 ].
	currentCharacter == $l ifTrue: [ ^ self scan28 ].
	^ self scan14X8
]

{ #category : #generated }
LeAnnotationScanner >> scan14X1 [
	self recordMatch: #(28).
	self step.
	currentCharacter == $= ifTrue: [ ^ self scan2 ].
	currentCharacter == $\ ifTrue: [ ^ self scan16 ].
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ ('/<' includes: currentCharacter) or: [ (currentCharacter between: $> and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan15 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= Character space
		or:
			[ (currentCharacter between: $" and: $$)
				or:
					[ (currentCharacter between: $' and: $))
						or:
							[ currentCharacter == $.
								or:
									[ (currentCharacter between: $0 and: $;)
										or:
											[ currentCharacter == $[
												or:
													[ (currentCharacter between: $] and: $^)
														or:
															[ ('`{' includes: currentCharacter)
																or:
																	[ (currentCharacter between: (Character value: 127) and: (Character value: 169))
																		or:
																			[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
																				or:
																					[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																						or:
																							[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan14X1X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X1X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan14X2 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $a
		ifTrue:
			[ self recordMatch: #(3 28).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $l
				ifTrue:
					[ self recordMatch: #(3 28).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan18 ].
					currentCharacter == $s ifTrue: [ ^ self scan24 ] ] ].
	^ self scan14X2X2
]

{ #category : #generated }
LeAnnotationScanner >> scan14X2X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan14X2X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan14X2X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X3 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $r
		ifTrue:
			[ self recordMatch: #(3 28).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $u ifTrue: [ ^ self scan24 ] ].
	^ self scan14X3X2
]

{ #category : #generated }
LeAnnotationScanner >> scan14X3X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan14X3X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan14X3X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X4 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $b
		ifTrue:
			[ self recordMatch: #(3 28 29).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ] ].
	^ self scan14X4X2
]

{ #category : #generated }
LeAnnotationScanner >> scan14X4X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan14X4X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan14X4X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X5 [
	[ self recordMatch: #(4 28).
	self step.
	currentCharacter isDigit ] whileTrue.
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $: and: $<) or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ])
		ifTrue:
			[ [ self recordMatch: #(28).
			self step.
			currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X6 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan14X7 [
	(currentCharacter <= Character space
		or:
			[ ('"$' includes: currentCharacter)
				or:
					[ (currentCharacter between: $' and: $))
						or:
							[ currentCharacter == $.
								or:
									[ (currentCharacter between: $: and: $;)
										or:
											[ currentCharacter == $[
												or:
													[ (currentCharacter between: $] and: $^)
														or:
															[ ('`{' includes: currentCharacter)
																or:
																	[ (currentCharacter between: (Character value: 127) and: (Character value: 169))
																		or:
																			[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
																				or:
																					[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																						or:
																							[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan14X6 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan14X8 [
	currentCharacter == $s ifTrue: [ ^ self scan30 ].
	currentCharacter == $t ifTrue: [ ^ self scan14X3 ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	currentCharacter isDigit ifTrue: [ ^ self scan14X5 ].
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ ('/<' includes: currentCharacter) or: [ (currentCharacter between: $> and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan15 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	^ self scan14X7
]

{ #category : #generated }
LeAnnotationScanner >> scan15 [
	[ self recordMatch: #(3 28).
	self step.
	currentCharacter == $= ifTrue: [ ^ self scan2 ].
	currentCharacter == $\ ifTrue: [ ^ self scan16 ].
	currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ ('/<' includes: currentCharacter) or: [ (currentCharacter between: $> and: $@) or: [ currentCharacter == $~ ] ] ] ] ] ]
		whileTrue.
	^ self scan15X2
]

{ #category : #generated }
LeAnnotationScanner >> scan15X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan15X2 [
	(currentCharacter <= Character space
		or:
			[ (currentCharacter between: $" and: $$)
				or:
					[ (currentCharacter between: $' and: $))
						or:
							[ currentCharacter == $.
								or:
									[ (currentCharacter between: $0 and: $;)
										or:
											[ (currentCharacter between: $A and: $[)
												or: [ (currentCharacter between: $] and: ${) or: [ currentCharacter >= (Character value: 127) ] ] ] ] ] ] ])
		ifTrue: [ self scan15X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan16 [
	self recordMatch: #(28).
	self step.
	('=|' includes: currentCharacter) ifTrue: [ ^ self scan2 ].
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or:
							[ ('/<' includes: currentCharacter) or: [ (currentCharacter between: $> and: $@) or: [ '\~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ ^ self scan15 ].
	^ self scan16X2
]

{ #category : #generated }
LeAnnotationScanner >> scan16X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan16X2 [
	(currentCharacter <= Character space
		or:
			[ (currentCharacter between: $" and: $$)
				or:
					[ (currentCharacter between: $' and: $))
						or:
							[ currentCharacter == $.
								or:
									[ (currentCharacter between: $0 and: $;)
										or:
											[ (currentCharacter between: $A and: $[)
												or: [ (currentCharacter between: $] and: ${) or: [ currentCharacter >= (Character value: 127) ] ] ] ] ] ] ])
		ifTrue: [ self scan16X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan17 [
	[ self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self scan17X2
]

{ #category : #generated }
LeAnnotationScanner >> scan17X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan17X2 [
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan17X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan18 [
	self recordMatch: #(3 28).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan18X1 ].
	(currentCharacter <= $<
		or:
			[ (currentCharacter between: $> and: $@)
				or:
					[ (currentCharacter between: $[ and: $^)
						or:
							[ ('`{' includes: currentCharacter)
								or:
									[ (currentCharacter between: $~ and: (Character value: 169))
										or:
											[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
												or:
													[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
														or:
															[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ])
		ifTrue: [ self scan18X2 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan18X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self scan18X1X2
]

{ #category : #generated }
LeAnnotationScanner >> scan18X1X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan18X1X2 [
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan18X1X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan18X2 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan19 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $x ifTrue: [ ^ self scan20 ].
	^ self scan19X2
]

{ #category : #generated }
LeAnnotationScanner >> scan19X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan19X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan19X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X1 [
	self step.
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue:
			[ [ self recordMatch: #(3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X10 [
	self recordMatch: #(4 33).
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan8 ].
	currentCharacter isDigit
		ifTrue:
			[ self recordMatch: #(4 33).
			self step.
			currentCharacter == $- ifTrue: [ ^ self scan8 ].
			currentCharacter isDigit
				ifTrue:
					[ self recordMatch: #(4 33).
					self step.
					currentCharacter == $- ifTrue: [ ^ self scan8 ].
					currentCharacter isDigit
						ifTrue:
							[ self recordMatch: #(4 33).
							self step.
							currentCharacter == $- ifTrue: [ ^ self scan8 ].
							currentCharacter isDigit
								ifTrue:
									[ [ self recordMatch: #(4).
									self step.
									currentCharacter isDigit ] whileTrue ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X11 [
	[ self recordMatch: #(6).
	self step.
	currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X12 [
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	currentCharacter isDigit ifTrue: [ ^ self scan1X10 ].
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ]) ifTrue: [ ^ self scan1X11 ].
	currentCharacter isUppercase ifTrue: [ ^ self scan1X9 ].
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $,)
						or: [ ('/<' includes: currentCharacter) or: [ (currentCharacter between: $> and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X2 [
	self recordMatch: #(3 33).
	self step.
	currentCharacter == $-
		ifTrue:
			[ self recordMatch: #(3 33).
			self step.
			currentCharacter == $\ ifTrue: [ ^ self scan3 ].
			currentCharacter isDigit ifTrue: [ ^ self scan5 ].
			(currentCharacter == $!
				or:
					[ (currentCharacter between: $% and: $&)
						or:
							[ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
				ifTrue: [ ^ self scan2 ].
			^ self reportLastMatch ].
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	currentCharacter isDigit ifTrue: [ ^ self scan6 ].
	(currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $,)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X3 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $e
		ifTrue:
			[ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $i
				ifTrue:
					[ self recordMatch: #(2 3).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan4 ].
					currentCharacter == $g
						ifTrue:
							[ self recordMatch: #(2 3).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan4 ].
							currentCharacter == $h
								ifTrue:
									[ self recordMatch: #(2 3).
									self step.
									currentCharacter == $: ifTrue: [ ^ self scan4 ].
									currentCharacter == $t
										ifTrue:
											[ self recordMatch: #(2 3 14).
											self step.
											currentCharacter == $: ifTrue: [ ^ self scan4 ] ] ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X4 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $a
		ifTrue:
			[ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $b
				ifTrue:
					[ self recordMatch: #(2 3).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan4 ].
					currentCharacter == $e
						ifTrue:
							[ self recordMatch: #(2 3).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan4 ].
							currentCharacter == $l
								ifTrue:
									[ self recordMatch: #(2 3 9).
									self step.
									currentCharacter == $: ifTrue: [ ^ self scan4 ] ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X5 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $h
		ifTrue:
			[ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $o
				ifTrue:
					[ self recordMatch: #(2 3).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan4 ].
					currentCharacter == $w
						ifTrue:
							[ self recordMatch: #(2 3 13).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan4 ] ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X6 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $a
		ifTrue:
			[ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $l
				ifTrue:
					[ self recordMatch: #(2 3).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan4 ].
					currentCharacter == $s ifTrue: [ ^ self scan12 ] ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X7 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $r
		ifTrue:
			[ self recordMatch: #(2 3).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter == $u ifTrue: [ ^ self scan12 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X8 [
	self recordMatch: #(2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $b
		ifTrue:
			[ self recordMatch: #(2 3 29).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ] ].
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan10 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan1X9 [
	[ self recordMatch: #(1 2 3).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan2 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter == $\ ifTrue: [ ^ self scan3 ].
	currentCharacter == $!
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan20 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $p ifTrue: [ ^ self scan21 ].
	^ self scan20X2
]

{ #category : #generated }
LeAnnotationScanner >> scan20X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan20X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan20X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan21 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $a ifTrue: [ ^ self scan22 ].
	^ self scan21X2
]

{ #category : #generated }
LeAnnotationScanner >> scan21X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan21X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan21X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan22 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $n ifTrue: [ ^ self scan23 ].
	^ self scan22X2
]

{ #category : #generated }
LeAnnotationScanner >> scan22X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan22X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan22X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan23 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $d
		ifTrue:
			[ self recordMatch: #(3 28).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $e
				ifTrue:
					[ self recordMatch: #(3 28).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan18 ].
					currentCharacter == $d
						ifTrue:
							[ self recordMatch: #(3 11 28).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan18 ] ] ] ].
	^ self scan23X2
]

{ #category : #generated }
LeAnnotationScanner >> scan23X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan23X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan23X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan24 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $e
		ifTrue:
			[ self recordMatch: #(3 12 28).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ] ].
	^ self scan24X2
]

{ #category : #generated }
LeAnnotationScanner >> scan24X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan24X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan24X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan25 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $e ifTrue: [ ^ self scan26 ].
	^ self scan25X2
]

{ #category : #generated }
LeAnnotationScanner >> scan25X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan25X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan25X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan26 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $i ifTrue: [ ^ self scan27 ].
	^ self scan26X2
]

{ #category : #generated }
LeAnnotationScanner >> scan26X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan26X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan26X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan27 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $g
		ifTrue:
			[ self recordMatch: #(3 28).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $h
				ifTrue:
					[ self recordMatch: #(3 28).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan18 ].
					currentCharacter == $t
						ifTrue:
							[ self recordMatch: #(3 14 28).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan18 ] ] ] ].
	^ self scan27X2
]

{ #category : #generated }
LeAnnotationScanner >> scan27X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan27X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan27X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan28 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $a ifTrue: [ ^ self scan29 ].
	^ self scan28X2
]

{ #category : #generated }
LeAnnotationScanner >> scan28X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan28X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan28X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan29 [
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $b
		ifTrue:
			[ self recordMatch: #(3 28).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $e
				ifTrue:
					[ self recordMatch: #(3 28).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan18 ].
					currentCharacter == $l
						ifTrue:
							[ self recordMatch: #(3 9 28).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan18 ] ] ] ].
	^ self scan29X2
]

{ #category : #generated }
LeAnnotationScanner >> scan29X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan29X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan29X1 ].
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
	self recordMatch: #(3 28).
	self step.
	currentCharacter == $: ifTrue: [ ^ self scan18 ].
	currentCharacter == $h
		ifTrue:
			[ self recordMatch: #(3 28).
			self step.
			currentCharacter == $: ifTrue: [ ^ self scan18 ].
			currentCharacter == $o
				ifTrue:
					[ self recordMatch: #(3 28).
					self step.
					currentCharacter == $: ifTrue: [ ^ self scan18 ].
					currentCharacter == $w
						ifTrue:
							[ self recordMatch: #(3 13 28).
							self step.
							currentCharacter == $: ifTrue: [ ^ self scan18 ] ] ] ].
	^ self scan30X2
]

{ #category : #generated }
LeAnnotationScanner >> scan30X1 [
	[ self recordMatch: #(28).
	self step.
	currentCharacter <= $< or: [ (currentCharacter between: $> and: ${) or: [ currentCharacter >= $~ ] ] ] whileTrue
]

{ #category : #generated }
LeAnnotationScanner >> scan30X2 [
	(currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ]) ifTrue: [ ^ self scan17 ].
	(currentCharacter <= $/
		or:
			[ (currentCharacter between: $; and: $<)
				or:
					[ (currentCharacter between: $> and: $@)
						or:
							[ (currentCharacter between: $[ and: $^)
								or:
									[ ('`{' includes: currentCharacter)
										or:
											[ (currentCharacter between: $~ and: (Character value: 169))
												or:
													[ (currentCharacter between: (Character value: 171) and: (Character value: 180))
														or:
															[ (currentCharacter between: (Character value: 182) and: (Character value: 185))
																or:
																	[ (currentCharacter between: (Character value: 187) and: (Character value: 191)) or: [ '×÷' includes: currentCharacter ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan30X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan4 [
	self recordMatch: #(3).
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue:
			[ [ self step.
			currentCharacter == $: ifTrue: [ ^ self scan4 ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan5 [
	self recordMatch: #(33).
	self step.
	currentCharacter isDigit ifTrue: [ ^ self recordAndReportMatch: #(33) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan6 [
	self recordMatch: #(33).
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan7 ].
	currentCharacter isDigit
		ifTrue:
			[ self recordMatch: #(33).
			self step.
			currentCharacter == $- ifTrue: [ ^ self scan7 ] ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan7 [
	self recordMatch: #(33).
	self step.
	currentCharacter isDigit ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scan8 [
	self recordMatch: #(33).
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
		or:
			[ (currentCharacter between: $% and: $&)
				or:
					[ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/ or: [ (currentCharacter between: $< and: $@) or: [ currentCharacter == $~ ] ] ] ] ])
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> scanForToken [
	scope == #path ifTrue: [ ^ self scan14 ].
	scope == #label ifTrue: [ ^ self scan13 ].
	scope == #default ifTrue: [ ^ self scan1 ].
	scope == #uuid
		ifTrue:
			[ self step.
			(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
				ifTrue:
					[ self recordMatch: #(30).
					self step.
					(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
						ifTrue:
							[ self recordMatch: #(30).
							self step.
							(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
								ifTrue:
									[ self recordMatch: #(30).
									self step.
									(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
										ifTrue:
											[ self recordMatch: #(30).
											self step.
											(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
												ifTrue:
													[ self recordMatch: #(30).
													self step.
													(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
														ifTrue:
															[ self recordMatch: #(30).
															self step.
															(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																ifTrue:
																	[ self recordMatch: #(30).
																	self step.
																	(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																		ifTrue:
																			[ self recordMatch: #(30).
																			self step.
																			(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																				ifTrue:
																					[ self recordMatch: #(30).
																					self step.
																					(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																						ifTrue:
																							[ self recordMatch: #(30).
																							self step.
																							(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																								ifTrue:
																									[ self recordMatch: #(30).
																									self step.
																									(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																										ifTrue:
																											[ self recordMatch: #(30).
																											self step.
																											(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																												ifTrue:
																													[ self recordMatch: #(30).
																													self step.
																													(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																														ifTrue:
																															[ self recordMatch: #(30).
																															self step.
																															(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																ifTrue:
																																	[ self recordMatch: #(30).
																																	self step.
																																	(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																		ifTrue:
																																			[ self recordMatch: #(30).
																																			self step.
																																			(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																				ifTrue:
																																					[ self recordMatch: #(30).
																																					self step.
																																					(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																						ifTrue:
																																							[ self recordMatch: #(30).
																																							self step.
																																							(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																								ifTrue:
																																									[ self recordMatch: #(30).
																																									self step.
																																									(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																										ifTrue:
																																											[ self recordMatch: #(30).
																																											self step.
																																											(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																												ifTrue:
																																													[ self recordMatch: #(30).
																																													self step.
																																													(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																														ifTrue:
																																															[ self recordMatch: #(30).
																																															self step.
																																															(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																																ifTrue:
																																																	[ self recordMatch: #(30).
																																																	self step.
																																																	(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																																		ifTrue:
																																																			[ self recordMatch: #(30).
																																																			self step.
																																																			(currentCharacter isDigit or: [ currentCharacter between: $a and: $z ])
																																																				ifTrue: [ ^ self recordAndReportMatch: #(30) ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] ].
	^ self reportLastMatch
]

{ #category : #generated }
LeAnnotationScanner >> tokenActions [
	^ #(nil nil nil nil nil #whitespace)
]
