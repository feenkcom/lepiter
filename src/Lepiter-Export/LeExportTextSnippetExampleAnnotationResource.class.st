Class {
	#name : #LeExportTextSnippetExampleAnnotationResource,
	#superclass : #LeExportSnippetResource,
	#traits : 'TLeExportResource',
	#classTraits : 'TLeExportResource classTrait',
	#instVars : [
		'height',
		'annotation',
		'example'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
LeExportTextSnippetExampleAnnotationResource >> acceptVisitor: aVisitor [
	^ aVisitor visitExportTextSnippetExampleAnnotationResource: self
]

{ #category : #accessing }
LeExportTextSnippetExampleAnnotationResource >> annotation [
	^ annotation
]

{ #category : #accessing }
LeExportTextSnippetExampleAnnotationResource >> annotation: anObject [
	annotation := anObject
]

{ #category : #testing }
LeExportTextSnippetExampleAnnotationResource >> canExampleBeExecuted [
	^ self hasExample and: [ self example canBeExecuted ]
]

{ #category : #initialization }
LeExportTextSnippetExampleAnnotationResource >> defaultState [
	^ (self reference isNotNil and: [ self reference exists ])
		ifTrue: [ LeExportResourceState ready ]
		ifFalse: [ LeExportResourceState uninitialized ]
]

{ #category : #accessing }
LeExportTextSnippetExampleAnnotationResource >> example [
	^ example
]

{ #category : #accessing }
LeExportTextSnippetExampleAnnotationResource >> example: aGtExample [
	example := aGtExample asExampleWithResult
]

{ #category : #testing }
LeExportTextSnippetExampleAnnotationResource >> hasExample [
	^ self example isNotNil
]

{ #category : #testing }
LeExportTextSnippetExampleAnnotationResource >> hasExampleResult [
	^ self canExampleBeExecuted and: [ example hasResult ]
]

{ #category : #accessing }
LeExportTextSnippetExampleAnnotationResource >> height [
	^ height ifNil: [ LepiterConstants defaultPreviewHeight ]
]

{ #category : #accessing }
LeExportTextSnippetExampleAnnotationResource >> height: anObject [
	height := anObject
]

{ #category : #accessing }
LeExportTextSnippetExampleAnnotationResource >> label [
	self wantsLabelOutput ifFalse: [ ^ nil ].
	self hasExampleResult ifFalse: [ ^ nil ].

	^ example isSuccess
		ifTrue: [ annotation labelNode labelFor: example returnValue ]
		ifFalse: [ example returnValue printString ]
]

{ #category : #accessing }
LeExportTextSnippetExampleAnnotationResource >> previewShowSelector [
	^ annotation previewShowSelector ifNil: [ LepiterConstants defaultShowSelector ]
]

{ #category : #accessing }
LeExportTextSnippetExampleAnnotationResource >> sourceCode [
	^ String streamContents: [ :aStream | 
		aStream nextPutAll: self example method methodClass name.
		aStream nextPutAll: '>>#'.
		aStream nextPutAll: self example method sourceCode ]
]

{ #category : #testing }
LeExportTextSnippetExampleAnnotationResource >> wantsCodeOutput [
	^ self hasExample and: [ annotation noCode not and: [ self wantsLabelOutput not ] ]
]

{ #category : #testing }
LeExportTextSnippetExampleAnnotationResource >> wantsLabelOutput [
	^ self canExampleBeExecuted and: [ annotation hasLabel ]
]

{ #category : #testing }
LeExportTextSnippetExampleAnnotationResource >> wantsPreviewOutput [
	^ self canExampleBeExecuted
		and: [ self wantsLabelOutput  not
		and: [ annotation previewExpanded or: [ annotation noCode ] ] ]
]
