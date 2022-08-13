Class {
	#name : #GtPharoPatternCompletionStrategy,
	#superclass : #GtPharoCompletionStrategy,
	#instVars : [
		'patternVariables'
	],
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Completer'
}

{ #category : #testing }
GtPharoPatternCompletionStrategy >> hasCompletionsAt: anInteger in: aText [
	| char |
	anInteger < 1 ifTrue: [ ^ false ].
	char := aText at: anInteger.
	^ char isSeparator not
]

{ #category : #'initialize-release' }
GtPharoPatternCompletionStrategy >> initialize [
	super initialize.
	patternVariables := GtPrefixTree new
]

{ #category : #accessing }
GtPharoPatternCompletionStrategy >> parseSource: aString [
	^ [ isMethod
		ifTrue: [ GtPharoPatternParser parseWithErrors: aString ]
		ifFalse: [ GtPharoPatternParser
				parseWithErrors: aString
				startingAt: GtPharoParser startingStateForMethodSequence ] ]
		on: SmaCCParserError
		do: [ :ex | ex return: nil ]
]

{ #category : #accessing }
GtPharoPatternCompletionStrategy >> patternVariables [
	^ patternVariables
]

{ #category : #accessing }
GtPharoPatternCompletionStrategy >> patternVariables: aPrefixTree [
	patternVariables := aPrefixTree
]

{ #category : #accessing }
GtPharoPatternCompletionStrategy >> variables [
	^ patternVariables notEmpty
		ifTrue: [ GtCompositePrefixTree
				trees: {patternVariables.
						super variables} ]
		ifFalse: [ super variables ]
]
