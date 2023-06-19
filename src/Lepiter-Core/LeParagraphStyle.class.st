Class {
	#name : #LeParagraphStyle,
	#superclass : #LeModel,
	#category : 'Lepiter-Core-Model'
}

{ #category : #'api - instance creation' }
LeParagraphStyle class >> heading: aNumber [
	^ LeHeadingStyle new level: aNumber
]

{ #category : #'api - instance creation' }
LeParagraphStyle class >> text [
	^ LeTextStyle default
]

{ #category : #'api - accessing' }
LeParagraphStyle >> level [
	<return: #Integer or: nil>
	^ self subclassResponsibility
]
