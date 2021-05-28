Class {
	#name : #LeNullEmail,
	#superclass : #LeNullModel,
	#category : #'Lepiter-Core-Model'
}

{ #category : #'api - accessing' }
LeNullEmail >> email [
	^ ''
]

{ #category : #'api - accessing' }
LeNullEmail >> email: aString [
	"ignore"
]

{ #category : #printing }
LeNullEmail >> printOn: aStream [
	aStream nextPutAll: 'Non-existent email'
]
