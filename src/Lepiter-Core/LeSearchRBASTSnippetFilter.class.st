Class {
	#name : #LeSearchRBASTSnippetFilter,
	#superclass : #LeSearchSnippetFilter,
	#instVars : [
		'ast'
	],
	#category : #'Lepiter-Core-Filters'
}

{ #category : #'instance creation' }
LeSearchRBASTSnippetFilter class >> sourceExpression: aString [
	^ self new sourceExpression: aString
]

{ #category : #comparing }
LeSearchRBASTSnippetFilter >> = anObject [
	^ self class = anObject class and: [ self ast = anObject ast ]
]

{ #category : #accessing }
LeSearchRBASTSnippetFilter >> ast [
	^ ast
]

{ #category : #accessing }
LeSearchRBASTSnippetFilter >> ast: anObject [
	ast := anObject
]

{ #category : #comparing }
LeSearchRBASTSnippetFilter >> hash [
	^ self class hash bitXor: self ast hash
]

{ #category : #accessing }
LeSearchRBASTSnippetFilter >> highlighter [
	^ GtRBPatternHighlighter new
		  ast: self ast;
		  yourself
]

{ #category : #accessing }
LeSearchRBASTSnippetFilter >> leHighlighters [
	^ Dictionary new
		at: nil
			put: ((GtSmaCCParserStyler forParser: LineParser)
					stylerRules: {(GtSmaCCNodeStylerRule
								nodeClassName: #SmaCCParseNode
								styleBlock: [ :styler :node :text | 
									(RBParser parseFaultyExpression: text asString)
										nodesDo: [ :each | 
											(ast match: each inContext: Dictionary new)
												ifTrue: [ (text from: each start to: each stop)
														underlineColor: BrGlamorousColors textHighlightColor
														thickness: 3 ] ] ])
								continueOnMatch: false;
								yourself});
		yourself
]

{ #category : #testing }
LeSearchRBASTSnippetFilter >> matches: anObject [
	((anObject isKindOf: LeCodeSnippet) and: [ anObject isForLocalImage ])
		ifFalse: [ ^ false ].
	(RBParser parseFaultyExpression: anObject contentAsString)
		nodesDo: [ :each | (ast match: each inContext: Dictionary new) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
LeSearchRBASTSnippetFilter >> sourceExpression: aString [
	self ast: (RBParser parseRewriteExpression: aString)
]
