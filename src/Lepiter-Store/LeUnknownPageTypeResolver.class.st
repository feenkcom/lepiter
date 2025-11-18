Class {
	#name : #LeUnknownPageTypeResolver,
	#superclass : #LeUnknownObjectResolver,
	#category : #'Lepiter-Store-JsonV4'
}

{ #category : #accessing }
LeUnknownPageTypeResolver class >> attributeKey [
	^ #pageType
]

{ #category : #action }
LeUnknownPageTypeResolver >> resolveUnknownObject: anUnknownObject [
	^ LeUnknownPageType forMap: anUnknownObject map
]
