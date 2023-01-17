Class {
	#name : #LeScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeScanner >> emptySymbolTokenId [
	^ 77
]

{ #category : #generated }
LeScanner >> errorTokenId [
	^ 78
]

{ #category : #generated }
LeScanner >> scan1 [
	self step.
	currentCharacter == Character lf ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	currentCharacter == Character cr ifTrue: [ ^ self scan1X13 ].
	currentCharacter == $! ifTrue: [ ^ self scan1X6 ].
	currentCharacter == $# ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $( ifTrue: [ ^ self scan1X12 ].
	currentCharacter == $) ifTrue: [ ^ self scan1X11 ].
	^ self scan1X14
]

{ #category : #generated }
LeScanner >> scan1X1 [
	self recordMatch: #(3 20).
	self step.
	(currentCharacter <= Character tab
		or:
			[ (currentCharacter between: Character pageUp and: Character newPage)
				or:
					[ (currentCharacter between: (Character value: 14) and: Character space)
						or:
							[ currentCharacter == $"
								or:
									[ (currentCharacter between: $$ and: $')
										or:
											[ (currentCharacter between: $+ and: $9)
												or:
													[ (';=' includes: currentCharacter)
														or:
															[ (currentCharacter between: $? and: $Z)
																or:
																	[ currentCharacter == $\
																		or:
																			[ (currentCharacter between: $^ and: $_)
																				or:
																					[ (currentCharacter between: $a and: $z) or: [ currentCharacter == $| or: [ currentCharacter >= $~ ] ] ] ] ] ] ] ] ] ] ] ])
		ifTrue: [ self scan1X1X1 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X10 [
	self recordMatch: #(15).
	self step.
	currentCharacter == $: ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X11 [
	self recordMatch: #(27).
	self step.
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X12 [
	self recordMatch: #(26).
	self step.
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X13 [
	self recordMatch: #(20).
	self step.
	currentCharacter == Character lf ifTrue: [ ^ self recordAndReportMatch: #(20) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X14 [
	currentCharacter == $* ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $: ifTrue: [ ^ self scan1X10 ].
	currentCharacter == $< ifTrue: [ ^ self scan1X3 ].
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	currentCharacter == $[ ifTrue: [ ^ self scan1X5 ].
	currentCharacter == $] ifTrue: [ ^ self scan1X9 ].
	currentCharacter == $` ifTrue: [ ^ self scan1X4 ].
	currentCharacter == ${ ifTrue: [ ^ self scan1X8 ].
	currentCharacter == $} ifTrue: [ ^ self scan1X7 ].
	currentCharacter = (Character value: 133) ifTrue: [ ^ self scan1X1 ].
	true ifTrue: [ self scan1X2 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X1X1 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter <= Character tab
		or:
			[ (currentCharacter between: Character pageUp and: Character newPage)
				or:
					[ (currentCharacter between: (Character value: 14) and: Character space)
						or:
							[ currentCharacter == $"
								or:
									[ (currentCharacter between: $$ and: $')
										or:
											[ (currentCharacter between: $+ and: $9)
												or:
													[ (';=' includes: currentCharacter)
														or:
															[ (currentCharacter between: $? and: $Z)
																or:
																	[ currentCharacter == $\
																		or:
																			[ (currentCharacter between: $^ and: $_)
																				or:
																					[ (currentCharacter between: $a and: $z) or: [ currentCharacter == $| or: [ currentCharacter >= $~ ] ] ] ] ] ] ] ] ] ] ] ] ]
		whileTrue
]

{ #category : #generated }
LeScanner >> scan1X2 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: Character space)
						or: [ currentCharacter == $"
								or: [ (currentCharacter between: $$ and: $')
										or: [ (currentCharacter between: $+ and: $9)
												or: [ (';=' includes: currentCharacter)
														or: [ (currentCharacter between: $? and: $Z)
																or: [ currentCharacter == $\
																		or: [ (currentCharacter between: $^ and: $_)
																				or: [ (currentCharacter between: $a and: $z)
																						or: [ currentCharacter == $| or: [ currentCharacter >= $~ ] ] ] ] ] ] ] ] ] ] ] ] ]
		whileTrue
]

{ #category : #generated }
LeScanner >> scan1X3 [
	self recordMatch: #(30).
	self step.
	(currentCharacter isAlphaNumeric
		or: [ (currentCharacter between: Character space and: $!)
				or: [ (currentCharacter between: $# and: $/)
						or: [ (currentCharacter between: $: and: $;)
								or: [ currentCharacter == $=
										or: [ (currentCharacter between: $? and: $@)
												or: [ '[]_~' includes: currentCharacter ] ] ] ] ] ])
		ifTrue: [ [ self step.
			currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(11) ].
			currentCharacter isAlphaNumeric
				or: [ (currentCharacter between: Character space and: $!)
						or: [ (currentCharacter between: $# and: $/)
								or: [ (currentCharacter between: $: and: $;)
										or: [ (currentCharacter between: $= and: $@)
												or: [ '[]_~' includes: currentCharacter ] ] ] ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X4 [
	self recordMatch: #(25).
	self step.
	currentCharacter == $`
		ifTrue: [ self step.
			currentCharacter == $`
				ifTrue: [ self recordMatch: #(24).
					self step.
					(currentCharacter <= Character tab
						or: [ (currentCharacter between: Character pageUp and: Character newPage)
								or: [ (currentCharacter between: (Character value: 14) and: $_)
										or: [ currentCharacter >= $a ] ] ]) ifTrue: [ ^ self scan5 ].
					^ self reportLastMatch ].
			(currentCharacter <= Character tab
				or: [ (currentCharacter between: Character pageUp and: Character newPage)
						or: [ currentCharacter >= (Character value: 14) ] ])
				ifTrue: [ ^ self scan5 ].
			^ self reportLastMatch ].
	(currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ currentCharacter >= (Character value: 14) ] ])
		ifTrue: [ [ self step.
			currentCharacter == $` ifTrue: [ ^ self recordAndReportMatch: #(23) ].
			currentCharacter <= Character tab
				or: [ (currentCharacter between: Character pageUp and: Character newPage)
						or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X5 [
	self recordMatch: #(28).
	self step.
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter == $] ifTrue: [ ^ self scan3 ].
	true
		ifTrue: [ [ self step.
			currentCharacter == $] ifTrue: [ ^ self scan3 ].
			currentCharacter <= $Z or: [ currentCharacter >= $\ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X6 [
	self recordMatch: #(12).
	self step.
	currentCharacter == $[
		ifTrue: [ [ self step.
			currentCharacter == $]
				ifTrue: [ self step.
					currentCharacter == $( ifTrue: [ ^ self scan2 ].
					^ self reportLastMatch ].
			currentCharacter <= $Z or: [ currentCharacter >= $\ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X7 [
	self recordMatch: #(19).
	self step.
	currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X8 [
	self recordMatch: #(18).
	self step.
	currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X9 [
	self recordMatch: #(10).
	self step.
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan2 [
	[ self step.
	currentCharacter == $(
		ifTrue: [ [ self step.
			currentCharacter == $) ifTrue: [ ^ self scan2 ].
			currentCharacter isAlphaNumeric
				or: [ (currentCharacter between: Character space and: $!)
						or: [ (currentCharacter between: $# and: $')
								or: [ (currentCharacter between: $* and: $/)
										or: [ (currentCharacter between: $: and: $;)
												or: [ currentCharacter == $=
														or: [ (currentCharacter between: $? and: $@)
																or: [ '[]_~' includes: currentCharacter ] ] ] ] ] ] ] ]
				whileTrue.
			^ self reportLastMatch ].
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(14) ].
	currentCharacter isAlphaNumeric
		or: [ (currentCharacter between: Character space and: $!)
				or: [ (currentCharacter between: $# and: $/)
						or: [ (currentCharacter between: $: and: $;)
								or: [ currentCharacter == $=
										or: [ (currentCharacter between: $? and: $@)
												or: [ '[]_~' includes: currentCharacter ] ] ] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan3 [
	self step.
	currentCharacter == $( ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan4 [
	[ self step.
	currentCharacter == $(
		ifTrue: [ [ self step.
			currentCharacter == $) ifTrue: [ ^ self scan4 ].
			currentCharacter isAlphaNumeric
				or: [ (currentCharacter between: Character space and: $!)
						or: [ (currentCharacter between: $# and: $')
								or: [ (currentCharacter between: $* and: $/)
										or: [ (currentCharacter between: $: and: $;)
												or: [ currentCharacter == $=
														or: [ (currentCharacter between: $? and: $@)
																or: [ '[]_~' includes: currentCharacter ] ] ] ] ] ] ] ]
				whileTrue.
			^ self reportLastMatch ].
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	currentCharacter isAlphaNumeric
		or: [ (currentCharacter between: Character space and: $!)
				or: [ (currentCharacter between: $# and: $/)
						or: [ (currentCharacter between: $: and: $;)
								or: [ currentCharacter == $=
										or: [ (currentCharacter between: $? and: $@)
												or: [ '[]_~' includes: currentCharacter ] ] ] ] ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan5 [
	[ self step.
	currentCharacter == $`
		ifTrue: [ self step.
			currentCharacter == $` ifTrue: [ ^ self recordAndReportMatch: #(23) ].
			(currentCharacter <= Character tab
				or: [ (currentCharacter between: Character pageUp and: Character newPage)
						or: [ currentCharacter >= (Character value: 14) ] ])
				ifTrue: [ ^ self scan5 ].
			^ self reportLastMatch ].
	currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan6 [
	[ self recordMatch: #(22).
	self step.
	currentCharacter == $[ ifTrue: [ ^ self scan7 ].
	currentCharacter == $] ifTrue: [ ^ self scan8 ].
	true ] whileTrue
]

{ #category : #generated }
LeScanner >> scan7 [
	self step.
	(currentCharacter <= $Z
		or: [ currentCharacter == $\ or: [ currentCharacter >= $^ ] ])
		ifTrue: [ ^ self scan6 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan8 [
	self step.
	currentCharacter ~~ $] ifTrue: [ ^ self scan6 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scanForToken [
	scope == #default ifTrue: [ ^ self scan1 ].
	scope == #linkText
		ifTrue: [ self step.
			currentCharacter == $[ ifTrue: [ ^ self scan7 ].
			currentCharacter == $] ifTrue: [ ^ self scan8 ].
			^ self scan6 ].
	scope == #annotation
		ifTrue: [ self step.
			currentCharacter == $: ifTrue: [ ^ self recordAndReportMatch: #(15) ].
			(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ])
				ifTrue: [ [ self recordMatch: #(2).
					self step.
					currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ]
						whileTrue.
					^ self reportLastMatch ].
			currentCharacter isLetter
				ifTrue: [ [ self recordMatch: #(1).
					self step.
					currentCharacter isAlphaNumeric ] whileTrue ] ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> tokenActions [
	^ #(nil #whitespace)
]
