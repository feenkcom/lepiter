Class {
	#name : #LeSearchReferencesFilter,
	#superclass : #LeSearchSnippetFilter,
	#instVars : [
		'selector'
	],
	#category : #'Lepiter-Core-Filters'
}

{ #category : #'instance creation' }
LeSearchReferencesFilter class >> selector: aSymbol [
	^ self new selector: aSymbol
]

{ #category : #comparing }
LeSearchReferencesFilter >> = anObject [
	^ self class = anObject class and: [ self selector = anObject selector ]
]

{ #category : #accessing }
LeSearchReferencesFilter >> defaultFilterScope [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
		inject: #() asAsyncStream
		into: [ :sum :each | sum merge: (each asyncSnippetReferencesTo: self selector) ]
]

{ #category : #accessing }
LeSearchReferencesFilter >> gtDisplayOn: stream [
	self selector gtDisplayOn: stream.
	stream nextPutAll: ' lepiter references'
]

{ #category : #comparing }
LeSearchReferencesFilter >> hash [
	^ self class hash bitXor: self selector hash
]

{ #category : #accessing }
LeSearchReferencesFilter >> highlighter [
	^ GtPharoSelectorReferenceAndLiteralHighlighter forSelector: self selector
]

{ #category : #accessing }
LeSearchReferencesFilter >> leHighlighters [
	^ Dictionary new
		at: GtPharoParser
			put: (GtPharoSelectorReferenceAndLiteralHighlighter forSelector: self selector);
		at: LeParser
			put: ((GtSmaCCParserStyler forParser: LeAnnotationParser)
					stylerRules: {GtSmaCCNodeVariableStylerRule
								nodeClassName: #LeMethodNameArgumentNode
								variableNames: #(selector)
								styleBlock: [ :styler :token | 
									(token source = selector or: [ token source = ('#' , selector) ])
										ifTrue: [ styler underlineColor: BrGlamorousColors textHighlightColor thickness: 3 ] ]});
		yourself
]

{ #category : #accessing }
LeSearchReferencesFilter >> matches: anObject [
	^ (super matches: anObject)
		and: [ anObject
				optionAt: #selectors
				ifPresent: [ :selectors | selectors includes: selector ]
				ifAbsent: [ false ] ]
]

{ #category : #accessing }
LeSearchReferencesFilter >> selector [
	^ selector
]

{ #category : #accessing }
LeSearchReferencesFilter >> selector: anObject [
	selector := anObject asSymbol
]
