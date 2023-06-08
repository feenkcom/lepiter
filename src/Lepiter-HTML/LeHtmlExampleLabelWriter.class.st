Class {
	#name : #LeHtmlExampleLabelWriter,
	#superclass : #Object,
	#instVars : [
		'resource',
		'context'
	],
	#category : #'Lepiter-HTML-Writers'
}

{ #category : #accessing }
LeHtmlExampleLabelWriter >> context [
	^ context
]

{ #category : #accessing }
LeHtmlExampleLabelWriter >> context: anObject [
	context := anObject
]

{ #category : #accessing }
LeHtmlExampleLabelWriter >> resource [
	^ resource
]

{ #category : #accessing }
LeHtmlExampleLabelWriter >> resource: anObject [
	resource := anObject
]

{ #category : #'api - writing' }
LeHtmlExampleLabelWriter >> write [
	resource hasExampleResult ifFalse: [
		resource acceptVisitor: context assembler ].
		
	resource hasExampleResult 
		ifTrue: [ self writeLabel ]
]

{ #category : #'writing - private' }
LeHtmlExampleLabelWriter >> writeLabel [
	context html
		inlineTag: #code
		class: 'example_inlined'
		with: resource label
]
