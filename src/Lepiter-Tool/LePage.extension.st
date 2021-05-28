Extension { #name : #LePage }

{ #category : #'*Lepiter-Tool' }
LePage >> spotterItemName [
	^ self isUnnamedPage
		ifTrue: [ String 
			streamContents: [ :aStream |
				self allChildrenDepthFirstDo: [ :eachSnippet | 
					aStream nextPutAll: eachSnippet contentAsString asString; space ] ]
			limitedTo: 50 ]
		ifFalse: [ self contentAsString ]
]
