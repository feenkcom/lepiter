Class {
	#name : #GtPythonVarNodeVisitorExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Python-Examples'
}

{ #category : #'as yet unclassified' }
GtPythonVarNodeVisitorExamples >> visitShadowingCode [
	<gtExample>
	<return: #GtPythonVarNodeVisitor>
	| visitor |
	visitor := self visitor.

	visitor
		accept: (PythonParser
				parse: '
def fun(accessed_and_shadowed, shadowed):
	inner_accessed = 1
	shadowed = 1
	return 1

assigned_and_accessed = 1	
accessed_and_shadowed').

	self assert: visitor accessedFirstVariableNames size equals: 3.
	self assert: visitor assignedVariableNames size equals: 1.
	self assert: visitor temporaryVariableNames size equals: 1.

	^ visitor
]

{ #category : #'as yet unclassified' }
GtPythonVarNodeVisitorExamples >> visitSimpleCode [
	<gtExample>
	<return: #GtPythonVarNodeVisitor>
	| visitor |
	visitor := self visitor.

	visitor
		accept: (PythonParser
				parse: '
def temporary():
	return 1

assigned_and_accessed = 1	
accessed').

	self assert: visitor accessedFirstVariableNames size equals: 2.
	self assert: visitor assignedVariableNames size equals: 1.
	self assert: visitor temporaryVariableNames size equals: 1.

	^ visitor
]

{ #category : #'as yet unclassified' }
GtPythonVarNodeVisitorExamples >> visitor [
	<gtExample>
	<return: #GtPythonVarNodeVisitor>
	| visitor |
	visitor := GtPythonVarNodeVisitor new.

	self assert: visitor accessedFirstVariableNames size equals: 0.

	^ visitor
]
