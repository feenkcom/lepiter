Class {
	#name : #GtPharoPatternCompletionStrategy,
	#superclass : #GtPharoCompletionStrategy,
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Completer'
}

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
