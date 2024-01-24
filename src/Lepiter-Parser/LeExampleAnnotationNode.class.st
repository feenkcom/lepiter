Class {
	#name : #LeExampleAnnotationNode,
	#superclass : #LeAnnotationNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeExampleAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitExampleAnnotation: self
]

{ #category : #testing }
LeExampleAnnotationNode >> alignment [
	^ self alignmentNode ifNotNil: [ :aNode |
		aNode stringValue ]
]

{ #category : #testing }
LeExampleAnnotationNode >> alignmentNode [
	^ items 
		detect: [ :node | node isAlignment ] 
		ifNone: [ nil ]
]

{ #category : #testing }
LeExampleAnnotationNode >> codeExpanded [
	items
		do: [ :each | 
			each isCodeExpanded
				ifTrue: [ ^ each booleanValue ] ].
	^ true
]

{ #category : #testing }
LeExampleAnnotationNode >> noCode [
	items
		do: [ :each | 
			each isNoCode
				ifTrue: [ ^ each booleanValueWithDefault: true ] ].
	^ false
]

{ #category : #testing }
LeExampleAnnotationNode >> previewExpanded [
	items
		do: [ :each | 
			each isPreviewExpanded
				ifTrue: [ ^ each booleanValueWithDefault: false ] ].
	^ false
]

{ #category : #testing }
LeExampleAnnotationNode >> previewHeight [
	items
		do: [ :each | 
			each isPreviewHeight
				ifTrue: [ ^ each integerValue ] ].
	^ nil
]

{ #category : #accessing }
LeExampleAnnotationNode >> previewSelectSelector [
	items
		do: [ :each | 
			each isPreviewSelect
				ifTrue: [ ^ each selectorValue ] ].
	^ nil
]

{ #category : #accessing }
LeExampleAnnotationNode >> previewShowSelector [
	items
		do: [ :each | 
			each isPreviewShow
				ifTrue: [ ^ each selectorValue ] ].
	^ nil
]
