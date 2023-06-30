Class {
	#name : #LeUidPageLink,
	#superclass : #LeTextualLink,
	#category : #'Lepiter-Core-Links'
}

{ #category : #visiting }
LeUidPageLink >> acceptVisitor: aVisitor [

	^ aVisitor visitModel: self
]

{ #category : #'api - testing' }
LeUidPageLink >> isExistingPage [
	^ self targetReference isExistingPage
]

{ #category : #'api - testing' }
LeUidPageLink >> isTextualPageLink [
	^ true
]

{ #category : #accessing }
LeUidPageLink >> linkNameInterval [
	(node isKindOf: LeShortHashLinkNode)
		ifTrue: [ ^ node startPosition + 1 to: node stopPosition ].
	(node isKindOf: LeDoubleBracketLinkNode)
		ifTrue: [ ^ node startPosition + 2 to: node stopPosition - 2 ].
	(node isKindOf: LeFullHashLinkNode)
		ifTrue: [ ^ node startPosition + 3 to: node stopPosition - 2 ].
	(node isKindOf: LeKeywordLinkNode)
		ifTrue: [ ^ node startPosition to: node stopPosition - 2 ].
	^ self error: 'Unknown link type'
]

{ #category : #printing }
LeUidPageLink >> printOn: aStream [
	self targetPageUidString ifNil: [ ^ super printOn: aStream ].
	aStream
		<< 'Page Link: ';
		<< self targetPageUidString.
	(origin isNotNil and: [ self isExistingPage ]) ifTrue:
		[ aStream
			<< ' (';
			<< self pageName;
			<< ')' ].
]

{ #category : #accessing }
LeUidPageLink >> targetPageUidString [
	<return: #String>

	^ self targetReference pageUid
]

{ #category : #accessing }
LeUidPageLink >> targetPageUidString: aString [

	self assert: [ aString notNil ].
	self assert: [ targetReference isNil ].
	
	targetReference := LeLinkPageUidReference 
		forPageUid: aString.
	targetReference explicitLink: self
]

{ #category : #'api - accepting' }
LeUidPageLink >> targetUID [
	<return: #String>

	^ self targetPageUidString
]
