Class {
	#name : #LeScanner,
	#superclass : #SmaCCScanner,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeScanner >> emptySymbolTokenId [
	^ 109
]

{ #category : #generated }
LeScanner >> errorTokenId [
	^ 110
]

{ #category : #generated }
LeScanner >> scan1 [
	self tableAtLineStart ifTrue: [ ^ self scan2 ].
	self tableAtLineStart not ifTrue: [ ^ self scan1X2 ].
	self tableSeparatorMatchesHeader ifTrue: [ ^ self scan1X1 ].
	self step.
	currentCharacter == Character cr ifTrue: [ ^ self scan9 ].
	currentCharacter == $! ifTrue: [ ^ self scan10 ].
	currentCharacter == $# ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $( ifTrue: [ ^ self scan12 ].
	currentCharacter == $) ifTrue: [ ^ self scan13 ].
	currentCharacter == $* ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	^ self scan1X3
]

{ #category : #generated }
LeScanner >> scan10 [
	self recordMatch: #(12).
	self step.
	currentCharacter == $[
		ifTrue: [ [ self step.
			currentCharacter == $]
				ifTrue: [ self step.
					currentCharacter == $( ifTrue: [ ^ self scan11 ].
					^ self reportLastMatch ].
			currentCharacter <= $Z or: [ currentCharacter >= $\ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan11 [
	[ self step.
	currentCharacter == $(
		ifTrue: [ [ self step.
			currentCharacter == $) ifTrue: [ ^ self scan11 ].
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
LeScanner >> scan12 [
	self recordMatch: #(26).
	self step.
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan13 [
	self recordMatch: #(27).
	self step.
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan14 [
	self recordMatch: #(15).
	self step.
	currentCharacter == $: ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan15 [
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
LeScanner >> scan16 [
	self recordMatch: #(28).
	self step.
	currentCharacter == $[ ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter == $] ifTrue: [ ^ self scan17 ].
	true
		ifTrue: [ [ self step.
			currentCharacter == $] ifTrue: [ ^ self scan17 ].
			currentCharacter <= $Z or: [ currentCharacter >= $\ ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan17 [
	self step.
	currentCharacter == $( ifTrue: [ ^ self scan18 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan18 [
	[ self step.
	currentCharacter == $(
		ifTrue: [ [ self step.
			currentCharacter == $) ifTrue: [ ^ self scan18 ].
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
LeScanner >> scan19 [
	self recordMatch: #(10).
	self step.
	currentCharacter == $] ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X1 [
	self step.
	currentCharacter == Character cr ifTrue: [ ^ self scan9 ].
	currentCharacter == $! ifTrue: [ ^ self scan10 ].
	currentCharacter == $# ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $( ifTrue: [ ^ self scan12 ].
	currentCharacter == $) ifTrue: [ ^ self scan13 ].
	currentCharacter == $* ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $- ifTrue: [ ^ self scan26 ].
	currentCharacter == $: ifTrue: [ ^ self scan28 ].
	currentCharacter == $< ifTrue: [ ^ self scan15 ].
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	^ self scan1X1X1
]

{ #category : #generated }
LeScanner >> scan1X1X1 [
	currentCharacter == $[ ifTrue: [ ^ self scan16 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	currentCharacter == $] ifTrue: [ ^ self scan19 ].
	currentCharacter == $` ifTrue: [ ^ self scan20 ].
	currentCharacter == ${ ifTrue: [ ^ self scan22 ].
	currentCharacter == $} ifTrue: [ ^ self scan24 ].
	(currentCharacter == Character tab or: [ currentCharacter == Character space ])
		ifTrue: [ ^ self scan25 ].
	(currentCharacter == Character lf
		or: [ currentCharacter = (Character value: 133) ]) ifTrue: [ ^ self scan7 ].
	(currentCharacter <= $z or: [ currentCharacter >= $~ ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan1X2 [
	self tableSeparatorMatchesHeader ifTrue: [ ^ self scan1X2X1 ].
	self step.
	currentCharacter == Character cr ifTrue: [ ^ self scan9 ].
	currentCharacter == $! ifTrue: [ ^ self scan10 ].
	currentCharacter == $# ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $( ifTrue: [ ^ self scan12 ].
	currentCharacter == $) ifTrue: [ ^ self scan13 ].
	currentCharacter == $* ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $: ifTrue: [ ^ self scan14 ].
	^ self scan1X2X2
]

{ #category : #generated }
LeScanner >> scan1X2X1 [
	self step.
	currentCharacter == Character cr ifTrue: [ ^ self scan9 ].
	currentCharacter == $! ifTrue: [ ^ self scan10 ].
	currentCharacter == $# ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $( ifTrue: [ ^ self scan12 ].
	currentCharacter == $) ifTrue: [ ^ self scan13 ].
	currentCharacter == $* ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $- ifTrue: [ ^ self scan26 ].
	currentCharacter == $: ifTrue: [ ^ self scan28 ].
	currentCharacter == $< ifTrue: [ ^ self scan15 ].
	^ self scan1X2X1X1
]

{ #category : #generated }
LeScanner >> scan1X2X1X1 [
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	currentCharacter == $[ ifTrue: [ ^ self scan16 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	currentCharacter == $] ifTrue: [ ^ self scan19 ].
	currentCharacter == $` ifTrue: [ ^ self scan20 ].
	currentCharacter == ${ ifTrue: [ ^ self scan22 ].
	currentCharacter == $| ifTrue: [ ^ self scan29 ].
	currentCharacter == $} ifTrue: [ ^ self scan24 ].
	(currentCharacter == Character tab or: [ currentCharacter == Character space ])
		ifTrue: [ ^ self scan25 ].
	(currentCharacter == Character lf
		or: [ currentCharacter = (Character value: 133) ]) ifTrue: [ ^ self scan7 ].
	^ self scan5
]

{ #category : #generated }
LeScanner >> scan1X2X2 [
	currentCharacter == $< ifTrue: [ ^ self scan15 ].
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	currentCharacter == $[ ifTrue: [ ^ self scan16 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	currentCharacter == $] ifTrue: [ ^ self scan19 ].
	currentCharacter == $` ifTrue: [ ^ self scan20 ].
	currentCharacter == ${ ifTrue: [ ^ self scan22 ].
	currentCharacter == $| ifTrue: [ ^ self scan29 ].
	currentCharacter == $} ifTrue: [ ^ self scan24 ].
	(currentCharacter == Character lf
		or: [ currentCharacter = (Character value: 133) ]) ifTrue: [ ^ self scan7 ].
	^ self scan5
]

{ #category : #generated }
LeScanner >> scan1X3 [
	currentCharacter == $: ifTrue: [ ^ self scan14 ].
	currentCharacter == $< ifTrue: [ ^ self scan15 ].
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	currentCharacter == $[ ifTrue: [ ^ self scan16 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	currentCharacter == $] ifTrue: [ ^ self scan19 ].
	currentCharacter == $` ifTrue: [ ^ self scan20 ].
	currentCharacter == ${ ifTrue: [ ^ self scan22 ].
	currentCharacter == $} ifTrue: [ ^ self scan24 ].
	(currentCharacter == Character lf
		or: [ currentCharacter = (Character value: 133) ]) ifTrue: [ ^ self scan7 ].
	^ self scan5
]

{ #category : #generated }
LeScanner >> scan2 [
	self tableAtLineStart not ifTrue: [ ^ self scan2X1 ].
	self tableSeparatorMatchesHeader ifTrue: [ ^ self scan2X2 ].
	self step.
	currentCharacter == Character cr ifTrue: [ ^ self scan9 ].
	currentCharacter == $! ifTrue: [ ^ self scan10 ].
	currentCharacter == $# ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $( ifTrue: [ ^ self scan12 ].
	currentCharacter == $) ifTrue: [ ^ self scan13 ].
	currentCharacter == $* ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $: ifTrue: [ ^ self scan14 ].
	^ self scan2X3
]

{ #category : #generated }
LeScanner >> scan20 [
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
										or: [ currentCharacter >= $a ] ] ]) ifTrue: [ ^ self scan21 ].
					^ self reportLastMatch ].
			(currentCharacter <= Character tab
				or: [ (currentCharacter between: Character pageUp and: Character newPage)
						or: [ currentCharacter >= (Character value: 14) ] ])
				ifTrue: [ ^ self scan21 ].
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
LeScanner >> scan21 [
	[ self step.
	currentCharacter == $`
		ifTrue: [ self step.
			currentCharacter == $` ifTrue: [ ^ self recordAndReportMatch: #(23) ].
			(currentCharacter <= Character tab
				or: [ (currentCharacter between: Character pageUp and: Character newPage)
						or: [ currentCharacter >= (Character value: 14) ] ])
				ifTrue: [ ^ self scan21 ].
			^ self reportLastMatch ].
	currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan22 [
	self recordMatch: #(18).
	self step.
	currentCharacter == ${ ifTrue: [ ^ self recordAndReportMatch: #(16) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan23 [
	self recordMatch: #(33 34).
	self tableAtLineEnd not ifTrue: [ ^ self recordAndReportMatch: #(31 33 34) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan24 [
	self recordMatch: #(19).
	self step.
	currentCharacter == $} ifTrue: [ ^ self recordAndReportMatch: #(17) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan25 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan26 ].
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	currentCharacter == Character tab or: [ currentCharacter == Character space ] ]
		whileTrue.
	^ self scan25X1
]

{ #category : #generated }
LeScanner >> scan25X1 [
	(currentCharacter <= Character backspace
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: Character arrowDown)
						or: [ currentCharacter == $"
								or: [ (currentCharacter between: $$ and: $')
										or: [ (currentCharacter between: $+ and: $;)
												or: [ currentCharacter == $=
														or: [ (currentCharacter between: $? and: $Z)
																or: [ (currentCharacter between: $^ and: $_)
																		or: [ (currentCharacter between: $a and: $z)
																				or: [ (currentCharacter between: $~ and: (Character value: 132))
																						or: [ currentCharacter >= (Character value: 134) ] ] ] ] ] ] ] ] ] ] ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan26 [
	self recordMatch: #(3).
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan27 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	(currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: Character space)
						or: [ currentCharacter == $"
								or: [ (currentCharacter between: $$ and: $')
										or: [ (currentCharacter between: $+ and: $9)
												or: [ (';=' includes: currentCharacter)
														or: [ (currentCharacter between: $? and: $Z)
																or: [ (currentCharacter between: $^ and: $_)
																		or: [ (currentCharacter between: $a and: $z)
																				or: [ (currentCharacter between: $~ and: (Character value: 132))
																						or: [ currentCharacter >= (Character value: 134) ] ] ] ] ] ] ] ] ] ] ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan27 [
	self recordMatch: #(3).
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan27X1 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	(currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: Character space)
						or: [ currentCharacter == $"
								or: [ (currentCharacter between: $$ and: $')
										or: [ (currentCharacter between: $+ and: $9)
												or: [ (';=' includes: currentCharacter)
														or: [ (currentCharacter between: $? and: $Z)
																or: [ (currentCharacter between: $^ and: $_)
																		or: [ (currentCharacter between: $a and: $z)
																				or: [ (currentCharacter between: $~ and: (Character value: 132))
																						or: [ currentCharacter >= (Character value: 134) ] ] ] ] ] ] ] ] ] ] ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan27X1 [
	[ self recordMatch: #(3 32).
	self step.
	currentCharacter == $- ] whileTrue.
	currentCharacter == $: ifTrue: [ ^ self scan27X1X2 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	(currentCharacter == Character tab or: [ currentCharacter == Character space ])
		ifTrue: [ ^ self scan27X1X1 ].
	^ self scan27X1X3
]

{ #category : #generated }
LeScanner >> scan27X1X1 [
	[ self recordMatch: #(3 32).
	self step.
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	currentCharacter == Character tab or: [ currentCharacter == Character space ] ]
		whileTrue.
	(currentCharacter <= Character backspace
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: Character arrowDown)
						or: [ currentCharacter == $"
								or: [ (currentCharacter between: $$ and: $')
										or: [ (currentCharacter between: $+ and: $9)
												or: [ (';=' includes: currentCharacter)
														or: [ (currentCharacter between: $? and: $Z)
																or: [ (currentCharacter between: $^ and: $_)
																		or: [ (currentCharacter between: $a and: $z)
																				or: [ (currentCharacter between: $~ and: (Character value: 132))
																						or: [ currentCharacter >= (Character value: 134) ] ] ] ] ] ] ] ] ] ] ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan27X1X2 [
	[ self recordMatch: #(32).
	self step.
	currentCharacter == Character tab or: [ currentCharacter == Character space ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan27X1X3 [
	(currentCharacter <= Character backspace
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: Character arrowDown)
						or: [ currentCharacter == $"
								or: [ (currentCharacter between: $$ and: $')
										or: [ (currentCharacter between: $+ and: $;)
												or: [ currentCharacter == $=
														or: [ (currentCharacter between: $? and: $Z)
																or: [ (currentCharacter between: $^ and: $_)
																		or: [ (currentCharacter between: $a and: $z)
																				or: [ (currentCharacter between: $~ and: (Character value: 132))
																						or: [ currentCharacter >= (Character value: 134) ] ] ] ] ] ] ] ] ] ] ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan28 [
	self recordMatch: #(15).
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan3 ].
	currentCharacter == $: ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan29 [
	self tableAtLineEnd ifTrue: [ ^ self scan23 ].
	self tableAtLineEnd not ifTrue: [ ^ self recordAndReportMatch: #(31 33) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan2X1 [
	self tableSeparatorMatchesHeader ifTrue: [ ^ self scan2X1X1 ].
	self step.
	currentCharacter == Character cr ifTrue: [ ^ self scan9 ].
	currentCharacter == $! ifTrue: [ ^ self scan10 ].
	currentCharacter == $# ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $( ifTrue: [ ^ self scan12 ].
	currentCharacter == $) ifTrue: [ ^ self scan13 ].
	currentCharacter == $* ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $: ifTrue: [ ^ self scan14 ].
	^ self scan2X1X3
]

{ #category : #generated }
LeScanner >> scan2X1X1 [
	[ self step.
	currentCharacter == $- ifTrue: [ ^ self scan3 ].
	currentCharacter == $: ifTrue: [ ^ self scan4 ].
	currentCharacter == Character tab or: [ currentCharacter == Character space ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan2X1X2 [
	self recordMatch: #(33).
	self tableAtLineEnd ifTrue: [ ^ self scan23 ].
	self tableAtLineEnd not ifTrue: [ ^ self recordAndReportMatch: #(31 33) ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan2X1X3 [
	currentCharacter == $< ifTrue: [ ^ self scan15 ].
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	currentCharacter == $[ ifTrue: [ ^ self scan16 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	currentCharacter == $] ifTrue: [ ^ self scan19 ].
	currentCharacter == $` ifTrue: [ ^ self scan20 ].
	currentCharacter == ${ ifTrue: [ ^ self scan22 ].
	currentCharacter == $| ifTrue: [ ^ self scan2X1X2 ].
	currentCharacter == $} ifTrue: [ ^ self scan24 ].
	(currentCharacter == Character lf
		or: [ currentCharacter = (Character value: 133) ]) ifTrue: [ ^ self scan7 ].
	^ self scan5
]

{ #category : #generated }
LeScanner >> scan2X2 [
	self step.
	currentCharacter == Character cr ifTrue: [ ^ self scan9 ].
	currentCharacter == $! ifTrue: [ ^ self scan10 ].
	currentCharacter == $# ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	currentCharacter == $( ifTrue: [ ^ self scan12 ].
	currentCharacter == $) ifTrue: [ ^ self scan13 ].
	currentCharacter == $* ifTrue: [ ^ self recordAndReportMatch: #(21) ].
	currentCharacter == $- ifTrue: [ ^ self scan26 ].
	currentCharacter == $: ifTrue: [ ^ self scan28 ].
	currentCharacter == $< ifTrue: [ ^ self scan15 ].
	^ self scan2X2X1
]

{ #category : #generated }
LeScanner >> scan2X2X1 [
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	currentCharacter == $[ ifTrue: [ ^ self scan16 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	currentCharacter == $] ifTrue: [ ^ self scan19 ].
	currentCharacter == $` ifTrue: [ ^ self scan20 ].
	currentCharacter == ${ ifTrue: [ ^ self scan22 ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(33) ].
	currentCharacter == $} ifTrue: [ ^ self scan24 ].
	(currentCharacter == Character tab or: [ currentCharacter == Character space ])
		ifTrue: [ ^ self scan25 ].
	(currentCharacter == Character lf
		or: [ currentCharacter = (Character value: 133) ]) ifTrue: [ ^ self scan7 ].
	^ self scan5
]

{ #category : #generated }
LeScanner >> scan2X3 [
	currentCharacter == $< ifTrue: [ ^ self scan15 ].
	currentCharacter == $> ifTrue: [ ^ self recordAndReportMatch: #(29) ].
	currentCharacter == $[ ifTrue: [ ^ self scan16 ].
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	currentCharacter == $] ifTrue: [ ^ self scan19 ].
	currentCharacter == $` ifTrue: [ ^ self scan20 ].
	currentCharacter == ${ ifTrue: [ ^ self scan22 ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(33) ].
	currentCharacter == $} ifTrue: [ ^ self scan24 ].
	(currentCharacter == Character lf
		or: [ currentCharacter = (Character value: 133) ]) ifTrue: [ ^ self scan7 ].
	^ self scan5
]

{ #category : #generated }
LeScanner >> scan3 [
	(self scanForString: '--')
		ifTrue: [ [ self recordMatch: #(32).
			self step.
			currentCharacter == $- ] whileTrue.
			(currentCharacter == Character tab
				or: [ currentCharacter == Character space or: [ currentCharacter == $: ] ])
				ifTrue: [ [ self recordMatch: #(32).
					self step.
					currentCharacter == Character tab
						or: [ currentCharacter == Character space ] ] whileTrue ] ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan30 [
	[ self recordMatch: #(22).
	self step.
	currentCharacter == $[ ifTrue: [ ^ self scan31 ].
	currentCharacter == $] ifTrue: [ ^ self scan32 ].
	true ] whileTrue
]

{ #category : #generated }
LeScanner >> scan31 [
	self step.
	(currentCharacter <= $Z
		or: [ currentCharacter == $\ or: [ currentCharacter >= $^ ] ])
		ifTrue: [ ^ self scan30 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan32 [
	self step.
	currentCharacter ~~ $] ifTrue: [ ^ self scan30 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan4 [
	self step.
	currentCharacter == $- ifTrue: [ ^ self scan3 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan5 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter == $\ ifTrue: [ ^ self scan6 ].
	currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ (currentCharacter between: (Character value: 14) and: Character space)
						or: [ currentCharacter == $"
								or: [ (currentCharacter between: $$ and: $')
										or: [ (currentCharacter between: $+ and: $9)
												or: [ (';=' includes: currentCharacter)
														or: [ (currentCharacter between: $? and: $Z)
																or: [ (currentCharacter between: $^ and: $_)
																		or: [ (currentCharacter between: $a and: $z)
																				or: [ (currentCharacter between: $~ and: (Character value: 132))
																						or: [ currentCharacter >= (Character value: 134) ] ] ] ] ] ] ] ] ] ] ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan6 [
	self step.
	(currentCharacter <= Character tab
		or: [ (currentCharacter between: Character pageUp and: Character newPage)
				or: [ currentCharacter >= (Character value: 14) ] ])
		ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan7 [
	self recordMatch: #(20).
	self tableRowFollows not ifTrue: [ ^ self scan8 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan8 [
	self recordMatch: #(20 35).
	self step.
	currentCharacter == Character lf ifTrue: [ ^ self scan7 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scan9 [
	self recordMatch: #(20).
	self tableRowFollows not ifTrue: [ ^ self scan8 ].
	self step.
	currentCharacter == Character lf ifTrue: [ ^ self scan7 ].
	^ self reportLastMatch
]

{ #category : #generated }
LeScanner >> scanForToken [
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
					currentCharacter isAlphaNumeric ] whileTrue ].
			^ self reportLastMatch ].
	scope == #default ifTrue: [ ^ self scan1 ].
	scope == #linkText
		ifTrue: [ self step.
			currentCharacter == $[ ifTrue: [ ^ self scan31 ].
			currentCharacter == $] ifTrue: [ ^ self scan32 ].
			^ self scan30 ].
	^ self reportLastMatch
]

{ #category : #tables }
LeScanner >> tableAtLineEnd [
	^ self stream atEnd or: [ #(10 13 133) includes: self stream peek asInteger ]
]

{ #category : #tables }
LeScanner >> tableAtLineStart [
	^ self position = 0 or: [ #(10 13 133) includes: (self stream contents at: self position) asInteger ]
]

{ #category : #tables }
LeScanner >> tableColumnCountIn: aString [
	| value count escaped ticks |
	value := aString trimBoth.
	count := 1.
	escaped := false.
	ticks := false.
	value do: [ :character | escaped ifTrue: [ escaped := false ] ifFalse: [ character = $\ ifTrue: [ escaped := true ] ifFalse: [ character = $` ifTrue: [ ticks := ticks not ] ifFalse: [ (character = $| and: [ ticks not ]) ifTrue: [ count := count + 1 ] ] ] ] ].
	(value beginsWith: '|') ifTrue: [ count := count - 1 ].
	(value endsWith: '|') ifTrue: [ count := count - 1 ].
	^ count
]

{ #category : #tables }
LeScanner >> tableRowFollows [
	"Lexical end-of-table guard. Inspect only the following line for an unescaped
	pipe outside backticks; the parser builds every row and cell directly."
	| position character escaped ticks pipe |
	position := stream position.
	escaped := false.
	ticks := false.
	pipe := false.
	[ [ stream atEnd ] whileFalse: [
		character := stream next.
		(#(10 13 133) includes: character asInteger) ifTrue: [ ^ pipe ].
		escaped ifTrue: [ escaped := false ] ifFalse: [
			character = $\ ifTrue: [ escaped := true ] ifFalse: [
				character = $` ifTrue: [ ticks := ticks not ] ifFalse: [
					(character = $| and: [ ticks not ]) ifTrue: [ pipe := true ] ] ] ] ].
		^ pipe ] ensure: [ stream position: position ]
]

{ #category : #tables }
LeScanner >> tableSeparatorMatchesHeader [
	"Check only the Markdown header/delimiter arity constraint. The grammar
	still creates every AST node, including all inline content."
	| source start end previousEnd previousStart |
	source := stream contents.
	start := stream position + 1.
	[ start > 1 and: [ (#(10 13 133) includes: (source at: start - 1) asInteger) not ] ] whileTrue: [ start := start - 1 ].
	start = 1 ifTrue: [ ^ false ].
	previousEnd := start - 2.
	(previousEnd > 0 and: [ (source at: start - 1) = Character lf and: [ (source at: previousEnd) = Character cr ] ]) ifTrue: [ previousEnd := previousEnd - 1 ].
	previousStart := previousEnd.
	[ previousStart > 1 and: [ (#(10 13 133) includes: (source at: previousStart - 1) asInteger) not ] ] whileTrue: [ previousStart := previousStart - 1 ].
	end := start.
	[ end <= source size and: [ (#(10 13 133) includes: (source at: end) asInteger) not ] ] whileTrue: [ end := end + 1 ].
	^ (self tableColumnCountIn: (source copyFrom: start to: end - 1)) = (self tableColumnCountIn: (source copyFrom: previousStart to: previousEnd))
]

{ #category : #generated }
LeScanner >> tokenActions [
	^ #(nil #whitespace)
]
