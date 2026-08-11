Class {
	#name : #LeObjectReferenceAnnotationAdapterNameNode,
	#superclass : #Object,
	#instVars : [
		'isDefined',
		'source'
	],
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #accessing }
LeObjectReferenceAnnotationAdapterNameNode >> isDefined [
	^isDefined
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapterNameNode >> isDefined: aBoolean [
	isDefined := aBoolean
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapterNameNode >> source [
	^source
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapterNameNode >> source: aString [
	source := aString
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapterNameNode >> value [
	^nil
]
