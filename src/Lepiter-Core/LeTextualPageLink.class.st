Class {
	#name : #LeTextualPageLink,
	#superclass : #LeTextualLink,
	#category : #'Lepiter-Core-Links'
}

{ #category : #'api - testing' }
LeTextualPageLink >> isExistingPage [
	^ self targetReference isExistingPage
]

{ #category : #'api - testing' }
LeTextualPageLink >> isTextualPageLink [
	^ true
]

{ #category : #accessing }
LeTextualPageLink >> linkNameInterval [
	(node isKindOf: LeShortHashLinkNode)
		ifTrue: [ ^ node startPosition + 1 to: node stopPosition ].
	(node isKindOf: LeDoubleBracketLinkNode)
		ifTrue: [ ^ node startPosition + 2 to: node stopPosition - 2 ].
	(node isKindOf: LeFullHashLinkNode)
		ifTrue: [ ^ node startPosition + 3 to: node stopPosition - 2 ].
	(node isKindOf: LeKeywordLinkNode)
		ifTrue: [ ^ node startPosition to: node stopPosition - 2 ].
	((node isKindOf: LePageAnnotationNode) and: [node hasPageName])
		ifTrue: [ ^ node nameNode startPosition to: node nameNode stopPosition ].
	^ self error: 'Unknown link type'
]

{ #category : #printing }
LeTextualPageLink >> printOn: aStream [
	self targetPageTitle ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: 'Page Link: ';
		nextPutAll: self targetUID
]

{ #category : #accessing }
LeTextualPageLink >> renameTargetTo: aString [
	| source needsBrackets newName interval |

	source := self origin string.
	needsBrackets := (node isKindOf: LeShortHashLinkNode)
		and: [ aString anySatisfy: [ :c | c isSeparator ] ].
	newName := needsBrackets
		ifTrue: [ '[[' , aString , ']]' ]
		ifFalse: [ aString ].
	interval := self linkNameInterval.
	self origin
		updateString:
			(source first: interval first - 1) , newName
				, (source copyFrom: interval last + 1 to: source size)
]

{ #category : #accessing }
LeTextualPageLink >> targetPageTitle [
	<return: #String>
	^ self targetReference pageTitle
]

{ #category : #accessing }
LeTextualPageLink >> targetPageTitle: aString [
	self assert: [ aString notNil ].
	self assert: [ targetReference isNil ].
	
	targetReference := LeLinkPageTextualTitleReference 
		forPageTitle: aString.
	targetReference explicitLink: self
]

{ #category : #'api - accepting' }
LeTextualPageLink >> targetUID [
	<return: #String>
	^ self targetPageTitle
]
