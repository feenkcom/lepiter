"
PythonBridge currently only includes functionality to build up statements programatically, while snippets allow users to enter Python code as strings.

LeUninterpretedPythonStatement represents a single Python statement on a single line and can be added to a PBCommandFactory.

"
Class {
	#name : #LeUninterpretedPythonStatement,
	#superclass : #P3GGenerable,
	#instVars : [
		'string'
	],
	#category : #'Lepiter-Python-Bridge'
}

{ #category : #convenience }
LeUninterpretedPythonStatement class >> addStatements: aCollection to: aCommandFactory [

	aCollection do: [ :statement |
		aCommandFactory << statement ].
	^ aCommandFactory
]

{ #category : #convenience }
LeUninterpretedPythonStatement class >> addStatementsFrom: aString to: aCommandFactory [
	"Separate the supplied python statements in to individual statements and add to the supplied command factory"

	(self statementsFrom: aString) do: [ :statement |
		aCommandFactory << statement ].
	^ aCommandFactory
]

{ #category : #convenience }
LeUninterpretedPythonStatement class >> statementsFrom: aString [
	"Answer a collection of uninterpreted statements from the supplied string.
	Until we have a proper python parser: separate statements, join continued lines and hope for the best"
	| statements continued |

	statements := OrderedCollection new.
	continued := false.
	aString lines do: [ :line |
		(line notEmpty and: [ line last = $\]) 	ifTrue: 
			[ continued ifTrue: 
				[ statements at: statements size put: statements last, line allButLast ]
			ifFalse:
				[ statements add: line allButLast ].
			continued := true ]
		ifFalse: 
			[ continued ifTrue:
				[ statements at: statements size put: statements last, line ]
			ifFalse:
				[ statements add: line ].
			continued := false ] ].
	^ statements collect: [ :string | self new string: string ].

]

{ #category : #testing }
LeUninterpretedPythonStatement >> isLanguageLinkValue [
	"A python value doesn't have assignment or begin with 'import'.
	This doesn't parse the expression and doesn't handle strings containing an $= character."

	^ ((string includes: $=) or: [ string beginsWith: 'import' ]) not
]

{ #category : #printing }
LeUninterpretedPythonStatement >> printOn: aStream [

	string
		ifNil: [ super printOn: aStream ]
		ifNotNil: [ aStream << string ]
]

{ #category : #accessing }
LeUninterpretedPythonStatement >> string [
	^ string
]

{ #category : #accessing }
LeUninterpretedPythonStatement >> string: anObject [
	string := anObject
]

{ #category : #translating }
LeUninterpretedPythonStatement >> writePython3On: aStream [
	"Write the Python 3 code generated on aStream."

	aStream << string
]
