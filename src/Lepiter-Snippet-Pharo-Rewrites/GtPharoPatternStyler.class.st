Class {
	#name : #GtPharoPatternStyler,
	#superclass : #GtPharoStyler,
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Styler'
}

{ #category : #accessing }
GtPharoPatternStyler >> visitMessage: aMessage [
	(aMessage selectorParts anySatisfy: [ :each | each source first = $` ])
		ifTrue: [ aMessage selectorParts
				do: [ :each | 
					self
						attributes: {BlTextForegroundAttribute color: Color blue darker}
						from: each startPosition
						to: each stopPosition ] ].
	^ super visitMessage: aMessage
]

{ #category : #visiting }
GtPharoPatternStyler >> visitNamedVariable: aNamedVariable [
	| isDeclaredVariable |
	self visitVariable: aNamedVariable.
	isDeclaredVariable := aNamedVariable isUndeclared not.
	isDeclaredVariable ifTrue: [ ^ self visitDeclaredVariable: aNamedVariable ].

	isDeclaredVariable := (SmaCCRewriteMatchContext
			classThatDefinesInstVarNamed: aNamedVariable variableName) notNil.
	isDeclaredVariable ifTrue: [ ^ self visitDeclaredVariable: aNamedVariable ].

	isDeclaredVariable := SmaCCRewriteMatchContext environment
			includesKey: aNamedVariable variableName.
	isDeclaredVariable
		ifTrue: [ ^ self visitDeclaredGlobalVariable: aNamedVariable ].

	(aNamedVariable variableName beginsWith: '`')
		ifTrue: [ self visitPatternVariable: aNamedVariable ]
		ifFalse: [ self visitDeclaredVariable: aNamedVariable ]
]

{ #category : #visiting }
GtPharoPatternStyler >> visitPatternVariable: aNamedVariable [
	self
		attributes: {BlTextForegroundAttribute color: Color blue darker}
		from: aNamedVariable startPosition
		to: aNamedVariable stopPosition
]
