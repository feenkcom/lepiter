Class {
	#name : #LePackageAnnotationNode,
	#superclass : #LeAnnotationNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LePackageAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPackageAnnotation: self
]

{ #category : #accessing }
LePackageAnnotationNode >> imageObject [
	^ self nameNode
		ifNotNil: [ :nameNode | 
			| imageObject |
			imageObject := nameNode imageObject.
			self tagNode
				ifNil: [ imageObject ]
				ifNotNil: [ :tagNode | tagNode imageObjectOn: imageObject ] ]
]

{ #category : #accessing }
LePackageAnnotationNode >> isDefined [
	^ super isDefined
		and: [ self tagNode ifNil: [true] ifNotNil: [ self tagNode isDefinedIn: self nameNode imageObject ] ]
]

{ #category : #accessing }
LePackageAnnotationNode >> packageAndTagName [
	| name |
	name := self nameNode value source.
	self tagNode
		ifNotNil: [ name := name , '(' , self tagNode value source asString , ')' ].
	^ name
]

{ #category : #accessing }
LePackageAnnotationNode >> packageName [
	^ self nameNode value source
]

{ #category : #accessing }
LePackageAnnotationNode >> tag [
	^ self tagNode ifNotNil: [ :node | node stringValue ]
]

{ #category : #accessing }
LePackageAnnotationNode >> tagNode [
	^ self items detect: [ :each | each isTag ] ifNone: [  ]
]
