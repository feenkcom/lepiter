Trait {
	#name : #TLeAnnotationParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitAlignmentArgument: anAlignmentArgument [
	^ self visitArgument: anAlignmentArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitAnnotation: anAnnotation [
	^ self visitAnnotationParse: anAnnotation
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitAnnotationParse: anAnnotationParse [
	^ self visitSmaCCParseNode: anAnnotationParse
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitArgument: anArgument [
	^ self visitAnnotationParse: anArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitChangesAnnotation: aChangesAnnotation [
	^ self visitAnnotation: aChangesAnnotation
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitClassAnnotation: aClassAnnotation [
	^ self visitAnnotation: aClassAnnotation
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitClassNameArgument: aClassNameArgument [
	^ self visitNameArgument: aClassNameArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitCodeExpandedArgument: aCodeExpandedArgument [
	^ self visitArgument: aCodeExpandedArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitDateArgument: aDateArgument [
	^ self visitArgument: aDateArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitDbArgument: aDbArgument [
	^ self visitArgument: aDbArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitExampleAnnotation: anExampleAnnotation [
	^ self visitAnnotation: anExampleAnnotation
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitExpandedArgument: anExpandedArgument [
	^ self visitArgument: anExpandedArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitFileNameArgument: aFileNameArgument [
	^ self visitNameArgument: aFileNameArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitFullArgument: aFullArgument [
	^ self visitArgument: aFullArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitHeightArgument: aHeightArgument [
	^ self visitArgument: aHeightArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitIdArgument: anIdArgument [
	^ self visitArgument: anIdArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitLabelArgument: aLabelArgument [
	^ self visitArgument: aLabelArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitMethodAnnotation: aMethodAnnotation [
	^ self visitAnnotation: aMethodAnnotation
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitMethodNameArgument: aMethodNameArgument [
	^ self visitClassNameArgument: aMethodNameArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitNameArgument: aNameArgument [
	^ self visitArgument: aNameArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitNoCodeArgument: aNoCodeArgument [
	^ self visitArgument: aNoCodeArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitPackageAnnotation: aPackageAnnotation [
	^ self visitAnnotation: aPackageAnnotation
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitPackageNameArgument: aPackageNameArgument [
	^ self visitNameArgument: aPackageNameArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitPackageTagArgument: aPackageTagArgument [
	^ self visitArgument: aPackageTagArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitPageAnnotation: aPageAnnotation [
	^ self visitAnnotation: aPageAnnotation
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitPageNameArgument: aPageNameArgument [
	^ self visitNameArgument: aPageNameArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitPreviewExpandedArgument: aPreviewExpandedArgument [
	^ self visitArgument: aPreviewExpandedArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitPreviewHeightArgument: aPreviewHeightArgument [
	^ self visitArgument: aPreviewHeightArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitPreviewSelectArgument: aPreviewSelectArgument [
	^ self visitArgument: aPreviewSelectArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitPreviewShowArgument: aPreviewShowArgument [
	^ self visitArgument: aPreviewShowArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitReturnArgument: aReturnArgument [
	^ self visitArgument: aReturnArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitShowArgument: aShowArgument [
	^ self visitArgument: aShowArgument
]

{ #category : #generated }
TLeAnnotationParseNodeVisitor >> visitTodoAnnotation: aTodoAnnotation [
	^ self visitAnnotation: aTodoAnnotation
]
