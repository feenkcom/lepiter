Class {
	#name : #LeModel,
	#superclass : #Object,
	#traits : 'TGtAssert + TGtOptions',
	#classTraits : 'TGtAssert classTrait + TGtOptions classTrait',
	#category : #'Lepiter-Core-Model'
}

{ #category : #visiting }
LeModel >> acceptVisitor: aVisitor [

	^ aVisitor visitModel: self
]

{ #category : #printing }
LeModel >> storeOn: aStream [ 
	"The default storeStream: method does not terminate for snippets and other LeModel classes."

	self subclassResponsibility

]
