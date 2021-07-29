Class {
	#name : #LeTextStyle,
	#superclass : #LeParagraphStyle,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'Lepiter-Core-Model'
}

{ #category : #comparing }
LeTextStyle >> = anObject [

	^ self class = anObject class
]

{ #category : #comparing }
LeTextStyle >> hash [ 

	^ self class hash
]

{ #category : #'api - accessing' }
LeTextStyle >> level [
	^ nil
]

{ #category : #printing }
LeTextStyle >> printOn: aStream [
	aStream nextPutAll: 'Paragraph Style'
]
