Extension { #name : #LePage }

{ #category : #'*Lepiter-Topics' }
LePage >> topicMap [
	^ (self hasOptionAt: 'topicMap')
		ifTrue: [ options at: 'topicMap' ]
		ifFalse: [ nil ]
]

{ #category : #'*Lepiter-Topics' }
LePage >> topicMap: aDictionary [
	self optionAt: 'topicMap' put: aDictionary
]
