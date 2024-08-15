Class {
	#name : #LeSearchSubstringSnippetFilter,
	#superclass : #LeSearchSnippetFilter,
	#instVars : [
		'substring'
	],
	#category : #'Lepiter-Core-Filters'
}

{ #category : #'instance creation' }
LeSearchSubstringSnippetFilter class >> substring: aString [
	^ self new substring: aString
]

{ #category : #comparing }
LeSearchSubstringSnippetFilter >> = anObject [
	^ self class = anObject class and: [ self substring = anObject substring ]
]

{ #category : #comparing }
LeSearchSubstringSnippetFilter >> hash [
	^ self class hash bitXor: self substring hash
]

{ #category : #accessing }
LeSearchSubstringSnippetFilter >> highlighter [
	^ GtPharoSubstringHighlighter substring: substring
]

{ #category : #accessing }
LeSearchSubstringSnippetFilter >> leHighlighters [
	^ Dictionary new
		at: nil
			put: ((GtSmaCCParserStyler forParser: LineParser)
					stylerRules: {(GtSmaCCNodeStylerRule
								nodeClassName: #SmaCCParseNode
								styleBlock: [ :styler :node :text | 
									| index string |
									string := text asString.
									index := 1.
									[ index <= string size ]
										whileTrue: [ index := string
													findString: substring
													startingAt: index
													caseSensitive: false.
											index = 0
												ifTrue: [ index := string size + 1 ]
												ifFalse: [ (text from: index to: index + substring size - 1)
														underlineColor: BrGlamorousColors textHighlightColor
														thickness: 3.
													index := index + substring size ] ] ])
								continueOnMatch: false;
								yourself});
		yourself
]

{ #category : #accessing }
LeSearchSubstringSnippetFilter >> matches: anObject [
	^ (super matches: anObject)
		and: [ anObject contentAsString includesSubstring: substring caseSensitive: false ]
]

{ #category : #accessing }
LeSearchSubstringSnippetFilter >> substring [
	^ substring
]

{ #category : #accessing }
LeSearchSubstringSnippetFilter >> substring: anObject [
	substring := anObject
]
