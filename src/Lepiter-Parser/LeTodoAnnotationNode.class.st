Class {
	#name : #LeTodoAnnotationNode,
	#superclass : #LeAnnotationNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeTodoAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitTodoAnnotation: self
]

{ #category : #accessing }
LeTodoAnnotationNode >> completed [
	^ items detect: [ :each | each isDate and: [ each name source = 'completed' ] ] ifNone: [  ]
]

{ #category : #testing }
LeTodoAnnotationNode >> isCompleted [
	^ items anySatisfy: [ :each | each isDate and: [ each name source = 'completed' and: [ each date notNil ] ] ]
]

{ #category : #testing }
LeTodoAnnotationNode >> isDefined [
	^ true
]
