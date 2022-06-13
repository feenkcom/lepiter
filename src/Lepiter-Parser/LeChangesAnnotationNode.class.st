Class {
	#name : #LeChangesAnnotationNode,
	#superclass : #LeAnnotationNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeChangesAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitChangesAnnotation: self
]

{ #category : #accessing }
LeChangesAnnotationNode >> changes [
	^ self nameNode ifNotNil: [ :node | node changes ]
]

{ #category : #accessing }
LeChangesAnnotationNode >> changes: aGtEpicea [
	^ self nameNode ifNotNil: [ :node | node changes: aGtEpicea ]
]

{ #category : #testing }
LeChangesAnnotationNode >> expandedDefault [
	^ true
]

{ #category : #accessing }
LeChangesAnnotationNode >> filename [
	^ self nameNode ifNotNil: [ :node | node value value ]
]
