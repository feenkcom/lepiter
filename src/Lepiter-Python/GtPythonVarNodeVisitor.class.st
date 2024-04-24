Class {
	#name : #GtPythonVarNodeVisitor,
	#superclass : #Object,
	#traits : 'TPyRootNodeVisitor',
	#classTraits : 'TPyRootNodeVisitor classTrait',
	#instVars : [
		'accessedFirstVariables',
		'assignedVariables',
		'temporaryVariables'
	],
	#category : #'Lepiter-Python-Coder'
}

{ #category : #accessing }
GtPythonVarNodeVisitor >> accessedFirstVariableNames [
	"Answer the set of variable names where the variable is accessed before being assigned a value (if at all)"

	^ accessedFirstVariables
]

{ #category : #accessing }
GtPythonVarNodeVisitor >> assignedVariableNames [
	"Answer the set of variable names that are assigned to"

	^ assignedVariables
]

{ #category : #accessing }
GtPythonVarNodeVisitor >> globalVariableNames [
	"Answer the set of variable names that are global, used but not declared tempary"

	^ (accessedFirstVariables , assignedVariables) difference: temporaryVariables
]

{ #category : #initialization }
GtPythonVarNodeVisitor >> initialize [
	super initialize.
	assignedVariables := Set new.
	temporaryVariables := Set new.
	accessedFirstVariables := Set new.
]

{ #category : #accessing }
GtPythonVarNodeVisitor >> temporaryVariableNames [
	"Answer the set of variable names that are declared as temporary"

	^ temporaryVariables
]

{ #category : #accessing }
GtPythonVarNodeVisitor >> undeclaredVariableNames [
	"Answer the set of variable names where the variable is assigned a value, but is not a temporary variable"

	^ self assignedVariableNames difference: self temporaryVariableNames
]

{ #category : #generated }
GtPythonVarNodeVisitor >> visitAssignmentExpression: anAssignmentExpression [
	^ self visitRoot: anAssignmentExpression
]

{ #category : #generated }
GtPythonVarNodeVisitor >> visitExprStmt: anExprStmt [
	| result assignmentOperator |
	result := self visitRoot: anExprStmt.
	anExprStmt assigns ifNotEmpty: [
		assignmentOperator := anExprStmt assigns first value.
		assignmentOperator = '='
			ifTrue: [ 
				anExprStmt testlist nodesDo: [ :aNode |
					assignedVariables add: aNode nameToken value ] ] ].
	^ result
]

{ #category : #generated }
GtPythonVarNodeVisitor >> visitSymbol: aSymbol [
	| name |
	name := aSymbol nameToken value.
	((assignedVariables includes: name) or: [ temporaryVariables includes: name ])
		ifFalse: [ accessedFirstVariables add: name ].
	^ self visitRoot: aSymbol
]

{ #category : #generated }
GtPythonVarNodeVisitor >> visitVarArgList: aVarArgList [
	aVarArgList args do: [ :each | 
		temporaryVariables add: (each nameToken value) ].
	^ self visitRoot: aVarArgList
]
