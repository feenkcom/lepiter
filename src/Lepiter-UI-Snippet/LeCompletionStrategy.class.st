Class {
	#name : #LeCompletionStrategy,
	#superclass : #GtCompletionStrategy,
	#instVars : [
		'database',
		'pageTitles',
		'allClasses',
		'gtViewSelectors'
	],
	#category : #'Lepiter-UI-Snippet-Text completion'
}

{ #category : #accessing }
LeCompletionStrategy >> allClasses [
	^ allClasses
		ifNil: [ allClasses := GtPrefixTree
				withAll: (ProtoObject withAllSubclasses collect: [ :each | each name ]) ]
]

{ #category : #accessing }
LeCompletionStrategy >> astCompletionActionStreamFor: aText at: positionInteger requested: aBoolean [
	| ast visitor stream |
	stream := #() asAsyncStream.
	ast := LeParser parseWithErrors: aText asString.
	visitor := LeContentCompletionVisitor new.
	visitor strategy: self.
	visitor text: aText.
	visitor position: positionInteger.
	visitor addStreamBlock: [ :s | stream := stream merge: s ].
	visitor accept: ast.
	^ stream
]

{ #category : #accessing }
LeCompletionStrategy >> bracketCompletionActionStreamFor: aText at: positionInteger withPrefix: prefix needsAdditionalBracket: aBoolean [
	| rightBracketCount index char rightBracketIndex leftBracket |
	index := positionInteger + 1.
	rightBracketCount := 0.
	[ rightBracketCount = 0 and: [ index <= aText size and: [ (char := aText at: index) isLineBreak not ] ] ]
		whileTrue:
			[ char = $]
				ifTrue:
					[ rightBracketIndex := index.
					rightBracketCount := (index + 1 < aText size and: [ (aText at: index + 1) = $] ]) ifTrue: [ 2 ] ifFalse: [ 1 ] ].
			index := index + 1 ].
	leftBracket := (aBoolean and: [ prefix isEmpty ]) ifTrue: [ '[' ] ifFalse: [ '' ].
	^ (self pageTitles asyncStreamStartingWith: prefix)
		collect:
			[ :each | 
			| action rightBrackets completionString |
			action := rightBracketCount > 0
				ifTrue:
					[ rightBrackets := rightBracketCount = 1 ifTrue: [ ']' ] ifFalse: [ '' ].
					completionString := leftBracket , (each allButFirst: prefix size) , rightBrackets.
					(GtCompositeCompletionAction labeled: (self labelFor: each withSearch: prefix))
						addAction:
								(GtDeleteTextCompletionAction
										labeled: ''
										from: positionInteger + 1
										to: rightBracketIndex - 1);
						addAction:
								(GtInsertTextAndPositionCursorCompletionAction
										labeled: each
										completion: completionString
										position: positionInteger
										from: positionInteger - prefix size
										newPosition: positionInteger + completionString size + rightBracketCount) ]
				ifFalse:
					[ GtInsertTextCompletionAction
						labeled: (self labelFor: each withSearch: prefix)
						completion: leftBracket , (each allButFirst: prefix size) , ']]'
						position: positionInteger
						from: positionInteger - prefix size ].
			(aBoolean and: [ prefix notEmpty ])
				ifTrue:
					[ (action isKindOf: GtCompositeCompletionAction)
						ifFalse:
							[ action := (GtCompositeCompletionAction labeled: (self labelFor: each withSearch: prefix)) addAction: action ].
					action
						addAction:
								(GtInsertTextCompletionAction
										labeled: '['
										completion: '['
										position: positionInteger - prefix size
										from: positionInteger - prefix size);
						yourself ].
			action ]
]

{ #category : #accessing }
LeCompletionStrategy >> completionActionStreamFor: aText at: positionInteger requested: aBoolean [
	| seenWhitespace char index stream |
	stream := self
		astCompletionActionStreamFor: aText
		at: positionInteger
		requested: aBoolean.
	seenWhitespace := false.
	index := positionInteger.
	[ index > 0 ]
		whileTrue:
			[ char := aText at: index.
			(char isLineBreak or: [ char = $] ]) ifTrue: [ ^ #() asAsyncStream ].
			char isSeparator ifTrue: [ seenWhitespace := true ].
			char = $[
				ifTrue:
					[ ^ stream
						merge:
							(self
								bracketCompletionActionStreamFor: aText
								at: positionInteger
								withPrefix: (aText copyFrom: index + 1 to: positionInteger) asString
								needsAdditionalBracket: (index = 1 or: [ (aText at: index - 1) ~= $[ ])) ].
			index := index - 1 ].
	^ stream
]

{ #category : #accessing }
LeCompletionStrategy >> database [
	^ database
]

{ #category : #accessing }
LeCompletionStrategy >> database: aLeDatabase [
	database := aLeDatabase.
	pageTitles := nil
]

{ #category : #accessing }
LeCompletionStrategy >> gtViewSelectors [
	^ gtViewSelectors
		ifNil: [ gtViewSelectors := GtPrefixTree new.
			ProtoObject withAllSubclasses
				do: [ :each | 
					each selectors
						do: [ :sel | 
							(each >> sel hasPragmaNamed: #gtView)
								ifTrue: [ gtViewSelectors add: sel ] ] ].
			gtViewSelectors ]
]

{ #category : #accessing }
LeCompletionStrategy >> hasCompletionsAt: anInteger in: aText [
	^ true
]

{ #category : #accessing }
LeCompletionStrategy >> pageTitles [
	^ pageTitles
		ifNil: [ pageTitles := GtPrefixTree new.
			database pages do: [ :each | pageTitles add: each title ].
			pageTitles ]
]
