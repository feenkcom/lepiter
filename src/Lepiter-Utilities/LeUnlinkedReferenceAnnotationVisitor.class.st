Class {
	#name : #LeUnlinkedReferenceAnnotationVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TLeAnnotationParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeAnnotationParseNodeVisitor classTrait',
	#instVars : [
		'stream'
	],
	#category : #'Lepiter-Utilities-Utilities'
}

{ #category : #accessing }
LeUnlinkedReferenceAnnotationVisitor >> stream [
	^ stream
]

{ #category : #accessing }
LeUnlinkedReferenceAnnotationVisitor >> stream: anObject [
	stream := anObject
]

{ #category : #generated }
LeUnlinkedReferenceAnnotationVisitor >> visitArgument: anArgument [

	anArgument value ifNotNil: [ :value |
		stream << value source ]
]

{ #category : #generated }
LeUnlinkedReferenceAnnotationVisitor >> visitMethodNameArgument: aMethodNameArgument [

	self visitClassNameArgument: aMethodNameArgument.
	stream
		nextPut: Character space;
		<< aMethodNameArgument methodName.
]
