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

{ #category : #generated }
GtPythonVarNodeVisitor >> accessedFirstVariableNames: anObject [ 
	accessedFirstVariables := anObject
]

{ #category : #accessing }
GtPythonVarNodeVisitor >> assignedVariableNames [
	"Answer the set of variable names that are assigned to"

	^ assignedVariables
]

{ #category : #generated }
GtPythonVarNodeVisitor >> assignedVariables: anObject [ 
	assignedVariables := anObject
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

{ #category : #generated }
GtPythonVarNodeVisitor >> temporaryVariableNames: anObject [ 
	temporaryVariables := anObject
]

{ #category : #accessing }
GtPythonVarNodeVisitor >> undeclaredVariableNames [
	"Answer the set of variable names where the variable is assigned a value, but is not a temporary variable"

	^ self assignedVariableNames difference: self temporaryVariableNames
]

{ #category : #generated }
GtPythonVarNodeVisitor >> visitAssignmentStatement: anAssignmentStatement [
	| result assignmentOperator |
	result := self visitStatement: anAssignmentStatement.
	assignmentOperator := anAssignmentStatement assigns first value.
	assignmentOperator = '='
		ifTrue: [ anAssignmentStatement lhs
				withAllNodesOfType: PyVariableExpressionNode
				do: [ :aNode | assignedVariables add: aNode nameToken value ] ].
	^ result
]

{ #category : #generated }
GtPythonVarNodeVisitor >> visitFunctionDefinition: aFunctionDefinition [
	| visitor |
	visitor := GtPythonVarNodeVisitor new
			accessedFirstVariableNames: self accessedFirstVariableNames copy;
			assignedVariables: self assignedVariableNames copy;
			temporaryVariableNames: self temporaryVariableNames copy.
	visitor visitStatement: aFunctionDefinition.
	self accessedFirstVariableNames: visitor accessedFirstVariableNames.
	temporaryVariables add: aFunctionDefinition fname value.
	^ self
]

{ #category : #generated }
GtPythonVarNodeVisitor >> visitParameter: aParameter [
	aParameter name
		ifNotNil: [ :name | 
			name
				withAllNodesOfType: PyVariableExpressionNode
				do: [ :node | temporaryVariables add: node nameToken value ] ].
	^ self visitRoot: aParameter
]

{ #category : #generated }
GtPythonVarNodeVisitor >> visitVariableExpression: aVariableExpression [
	| name |
	name := aVariableExpression nameToken value.
	((assignedVariables includes: name) or: [ temporaryVariables includes: name ])
		ifFalse: [ accessedFirstVariables add: name ].
	^ self visitExpression: aVariableExpression
]
