Trait {
	#name : #TLePictureParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #generated }
TLePictureParseNodeVisitor >> visitPictureAnnotation: aPictureAnnotation [
	^ self visitPictureParse: aPictureAnnotation
]

{ #category : #generated }
TLePictureParseNodeVisitor >> visitPictureArgument: aPictureArgument [
	^ self visitPictureParse: aPictureArgument
]

{ #category : #generated }
TLePictureParseNodeVisitor >> visitPictureParse: aPictureParse [
	^ self visitSmaCCParseNode: aPictureParse
]

{ #category : #generated }
TLePictureParseNodeVisitor >> visitPictureReference: aPictureReference [
	^ self visitPictureArgument: aPictureReference
]
