Class {
	#name : #GtPythonIsStatementVisitor,
	#superclass : #Object,
	#traits : 'TPyRootNodeVisitor',
	#classTraits : 'TPyRootNodeVisitor classTrait',
	#instVars : [
		'isStatement'
	],
	#category : #'Lepiter-Python-Coder'
}

{ #category : #initialization }
GtPythonIsStatementVisitor >> initialize [

	super initialize.
	isStatement := false.
]

{ #category : #accessing }
GtPythonIsStatementVisitor >> isStatement: aSmaCCParseNode [

	self acceptNode: aSmaCCParseNode.
	^ isStatement
]

{ #category : #generated }
GtPythonIsStatementVisitor >> visitStatement: aStatement [
	isStatement := true.
	^ self visitRoot: aStatement
]
