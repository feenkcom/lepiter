Extension { #name : #LeDatabase }

{ #category : #'*Lepiter-Utilities' }
LeDatabase >> tableOfContentsNodes [
	<return: #Collection of: #LeTableOfContentsNode>
	| page |
	page := self tableOfContents.
	page ifNil: [ ^ #() ].
	^ (LeTableOfContentsVisitor tocForPage: page) asCollection.
]
