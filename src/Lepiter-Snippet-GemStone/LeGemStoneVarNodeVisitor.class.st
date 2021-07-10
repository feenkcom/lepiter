Class {
	#name : 'LeGemStoneVarNodeVisitor',
	#superclass : 'Object',
	#traits : 'TGtPharoProgramNodeVisitor',
	#classTraits : 'TGtPharoProgramNodeVisitor classTrait',
	#instVars : [
		'accessedFirstVariables',
		'assignedVariables',
		'temporaryVariables'
	],
	#category : 'Lepiter-Snippet-GemStone-Coder'
}

{ #category : 'accessing' }
LeGemStoneVarNodeVisitor >> accessedFirstVariableNames [
	"Answer the set of variable names where the variable is accessed before being assigned a value (if at all)"

	^ accessedFirstVariables 
]

{ #category : 'accessing' }
LeGemStoneVarNodeVisitor >> assignedVariableNames [

	^ assignedVariables
]

{ #category : 'as yet unclassified' }
LeGemStoneVarNodeVisitor >> globalVariableNames [

	^ (accessedFirstVariables, assignedVariables) difference: temporaryVariables
]

{ #category : 'initialization' }
LeGemStoneVarNodeVisitor >> initialize [

	super initialize.
	assignedVariables := Set new.
	temporaryVariables := Set new.
	accessedFirstVariables := Set new.

]

{ #category : 'accessing' }
LeGemStoneVarNodeVisitor >> temporaryVariableNames [

	^ temporaryVariables
]

{ #category : 'accessing' }
LeGemStoneVarNodeVisitor >> undeclaredVariableNames [
	"Answer the set of variable names where the variable is assigned a value, but is not a temporary variable"

	^ self assignedVariableNames asSet difference: self temporaryVariableNames asSet
]

{ #category : 'generated' }
LeGemStoneVarNodeVisitor >> visitAssignment: anAssignment [

	"Get the assigned node and save"
	assignedVariables add: (anAssignment variable variableName).
	^ self visitValue: anAssignment
]

{ #category : 'generated' }
LeGemStoneVarNodeVisitor >> visitNamedVariable: aNamedVariable [
	| name |

	name := aNamedVariable variableName.
	((assignedVariables includes: name) or: [ temporaryVariables includes: name ]) ifFalse: 
		[ accessedFirstVariables add: name ].
	^ self visitVariable: aNamedVariable
]

{ #category : 'generated' }
LeGemStoneVarNodeVisitor >> visitSequence: aSequence [

	temporaryVariables addAll: (aSequence variables collect: #variableName).
	^ self visitProgram: aSequence
]
