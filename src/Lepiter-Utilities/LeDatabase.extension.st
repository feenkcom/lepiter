Extension { #name : #LeDatabase }

{ #category : #'*Lepiter-Utilities' }
LeDatabase >> dailyNotesGroup [
	| dailyNotesGroupedByDate |
	dailyNotesGroupedByDate := Dictionary new.
	self pagesDo: [ :aPage |
		aPage shouldAppearInIndexOrDailyNotes ifTrue: [
			| creationDay dailyNote |
			creationDay := aPage createTime asDate.
			dailyNote := dailyNotesGroupedByDate
				at: creationDay 
				ifAbsentPut: [ LeDailyNote forDate: creationDay ].
			dailyNote addChild: aPage ] ].
	^ dailyNotesGroupedByDate values sorted: [ :a :b | a date > b date ]
]

{ #category : #'*Lepiter-Utilities' }
LeDatabase >> tableOfContentsNodes [
	<return: #Collection of: #LeTableOfContentsNode>
	| page |
	page := self tableOfContents.
	page ifNil: [ ^ #() ].
	^ (LeTableOfContentsVisitor tocForPage: page) asOrderedCollection.
]
