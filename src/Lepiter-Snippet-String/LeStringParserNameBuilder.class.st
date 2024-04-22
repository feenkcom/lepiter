Class {
	#name : #LeStringParserNameBuilder,
	#superclass : #Object,
	#instVars : [
		'parserClass'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #building }
LeStringParserNameBuilder >> build [
	"Return a parser human readable name, e.g., SQL instead of SQLParser."

	| aName |
	self parserClass ifNil: [ ^ nil ].
	aName := self parserClass name.
	(aName endsWith: 'Parser') ifTrue: [ aName := aName allButLast: 'Parser' size ].
	(aName beginsWith: 'Gt') ifTrue: [ aName := aName allButFirst: 'Gt' size ].
	^ aName
]

{ #category : #building }
LeStringParserNameBuilder >> buildWithExtensions [
	"Return a parser human readable name, e.g., `SQL` instead of `SQLParser`.
It includes common file extensions, e.g., `.sql`."

	| aName |
	self parserClass ifNil: [ ^ nil ].
	aName := self build.
	(self parserClass fileExtensions allSatisfy: #isEmpty)
		ifFalse: [ aName := aName , ' (' , (', ' join: self parserClass fileExtensions) , ')' ].
	^ aName
]

{ #category : #accessing }
LeStringParserNameBuilder >> parserClass [
	^ parserClass
]

{ #category : #accessing }
LeStringParserNameBuilder >> parserClass: anObject [
	^ parserClass := anObject
]
