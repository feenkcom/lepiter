Class {
	#name : #LeSearchClassReferencesFilter,
	#superclass : #LeSearchSnippetFilter,
	#instVars : [
		'name'
	],
	#category : #'Lepiter-Core-Filters'
}

{ #category : #'instance creation' }
LeSearchClassReferencesFilter class >> forClass: aClass [
	^ self new
		name: aClass name;
		yourself
]

{ #category : #comparing }
LeSearchClassReferencesFilter >> = anObject [
	^ self class = anObject class and: [ self name = anObject name ]
]

{ #category : #accessing }
LeSearchClassReferencesFilter >> defaultFilterScope [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
		inject: #() asAsyncStream
		into: [ :sum :each | sum merge: (each asyncSnippetClassReferencesTo: self name) ]
]

{ #category : #accessing }
LeSearchClassReferencesFilter >> gtDisplayOn: stream [
	self name gtDisplayOn: stream.
	stream nextPutAll: ' lepiter class references'
]

{ #category : #comparing }
LeSearchClassReferencesFilter >> hash [
	^ self class hash bitXor: self name hash
]

{ #category : #accessing }
LeSearchClassReferencesFilter >> highlighter [
	^ GtPharoVariableReferenceHighlighter forVariableName: self name
]

{ #category : #accessing }
LeSearchClassReferencesFilter >> leHighlighters [
	^ Dictionary new
		at: GtPharoParser
			put: (GtPharoVariableReferenceHighlighter forVariableName: self name);
		at: LeParser
			put: ((GtSmaCCParserStyler forParser: LeAnnotationParser)
					stylerRules: {GtSmaCCNodeVariableStylerRule
								nodeClassName: #LeClassNameArgumentNode
								variableNames: #(value)
								styleBlock: [ :styler :token | 
									token source = self name
										ifTrue: [ styler underlineColor: BrGlamorousColors textHighlightColor thickness: 3 ] ]});
		yourself
]

{ #category : #accessing }
LeSearchClassReferencesFilter >> matches: anObject [
	^ (super matches: anObject)
		and: [ (anObject
				optionAt: #variables
				ifPresent: [ :variables | variables includes: name ]
				ifAbsent: [ false ])
				or: [ anObject
						optionAt: #selectors
						ifPresent: [ :selectors | selectors includes: name ]
						ifAbsent: [ false ] ] ]
]

{ #category : #accessing }
LeSearchClassReferencesFilter >> name [
	^ name
]

{ #category : #accessing }
LeSearchClassReferencesFilter >> name: anObject [
	name := anObject
]
