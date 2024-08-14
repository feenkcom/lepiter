Extension { #name : #String }

{ #category : #'*Lepiter-Core' }
String >> leASTMatches [
	^ LeSearchRBASTSnippetFilter sourceExpression: self
]

{ #category : #'*Lepiter-Core' }
String >> leDBMatches [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
		inject: GtSearchNullFilter new
		into: [ :sum :each | 
			(each databaseName includesSubstring: self caseSensitive: false)
				ifTrue: [ sum | each leSnippetsInDB ]
				ifFalse: [ sum ] ]
]

{ #category : #'*Lepiter-Core' }
String >> lePageMatches [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
		inject: GtSearchNullFilter new
		into: [ :sum :each | 
			each
				pageNamed: self
				ifPresent: [ :page | sum | page leSnippetsInPage ]
				ifAbsent: [ sum ] ]
]

{ #category : #'*Lepiter-Core' }
String >> leSubstringMatch [
	^ LeSearchSubstringSnippetFilter substring: self
]
