Class {
	#name : #LePharoLinkVarNodeVisitor,
	#superclass : #Object,
	#traits : 'TGtPharoProgramNodeVisitor',
	#classTraits : 'TGtPharoProgramNodeVisitor classTrait',
	#instVars : [
		'accessedFirstVariables',
		'assignedVariables',
		'temporaryVariables'
	],
	#category : 'Lepiter-Snippet-PharoLink-Coder'
}

{ #category : #accessing }
LePharoLinkVarNodeVisitor >> accessedFirstVariableNames [
	"Answer the set of variable names where the variable is accessed before being assigned a value (if at all)"

	^ accessedFirstVariables 
]

{ #category : #accessing }
LePharoLinkVarNodeVisitor >> assignedVariableNames [

	^ assignedVariables
]

{ #category : #initialization }
LePharoLinkVarNodeVisitor >> initialize [

	super initialize.
	assignedVariables := Set new.
	temporaryVariables := Set new.
	accessedFirstVariables := Set new.

]

{ #category : #accessing }
LePharoLinkVarNodeVisitor >> temporaryVariableNames [

	^ temporaryVariables
]

{ #category : #accessing }
LePharoLinkVarNodeVisitor >> undeclaredVariableNames [
	"Answer the set of variable names where the variable is assigned a value, but is not a temporary variable"

	^ self assignedVariableNames asSet difference: self temporaryVariableNames asSet
]

{ #category : #generated }
LePharoLinkVarNodeVisitor >> visitAssignment: anAssignment [

	"Get the assigned node and save"
	assignedVariables add: (anAssignment variable variableName).
	^ self visitValue: anAssignment
]

{ #category : #generated }
LePharoLinkVarNodeVisitor >> visitNamedVariable: aNamedVariable [
	| name |

	name := aNamedVariable variableName.
	((assignedVariables includes: name) or: [ temporaryVariables includes: name ]) ifFalse: 
		[ accessedFirstVariables add: name ].
	^ self visitVariable: aNamedVariable
]

{ #category : #generated }
LePharoLinkVarNodeVisitor >> visitSequence: aSequence [

	temporaryVariables addAll: (aSequence variables collect: #variableName).
	^ self visitProgram: aSequence
]
