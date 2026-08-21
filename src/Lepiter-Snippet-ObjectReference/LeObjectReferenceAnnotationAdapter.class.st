Class {
	#name : #LeObjectReferenceAnnotationAdapter,
	#superclass : #Object,
	#instVars : [
		'annotation',
		'object'
	],
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #'instance creation' }
LeObjectReferenceAnnotationAdapter class >> annotation: anAnnotation object: anObject [
	^self new setAnnotation: anAnnotation object: anObject
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> expanded [
	^annotation expandedValue ifNil: [false]
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> fallbackLabel [
	^annotation fallbackLabelString ifNil: [annotation uuid]
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> height [
	^annotation heightValue
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> imageObject [
	^object
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> isDefined [
	^object notNil
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> labelFor: anObject [
	| selector |
	selector := annotation labelSelector ifNil: ['gtDisplayString'].
	^[anObject perform: selector asSymbol] on: Error do: [:e | e printString]
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> labelNode [
	^annotation hasLabelSpecified ifTrue: [self] ifFalse: [nil]
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> nameNode [
	^(LeObjectReferenceAnnotationAdapterNameNode new)
		isDefined: object notNil;
		source: (annotation fallbackLabelString
					ifNil: [annotation uuid ifNil: ['?']])
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> parent [
	^annotation parent
]

{ #category : #initialization }
LeObjectReferenceAnnotationAdapter >> setAnnotation: anAnnotation object: anObject [
	annotation := anAnnotation.
	object := anObject
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> showSelector [
	^annotation showSelector
]

{ #category : #accessing }
LeObjectReferenceAnnotationAdapter >> source [
	^annotation source
]
