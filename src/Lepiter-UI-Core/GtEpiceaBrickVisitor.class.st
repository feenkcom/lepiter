Class {
	#name : #GtEpiceaBrickVisitor,
	#superclass : #EpEntryContentVisitor,
	#category : #'Lepiter-UI-Core-Epicea'
}

{ #category : #private }
GtEpiceaBrickVisitor >> brickFactory [

	^ GtEpiceaBrickFactory default
]

{ #category : #private }
GtEpiceaBrickVisitor >> displayBehavior: aString [ 

	^ { self brickFactory emphasizedStringFor: aString }
]

{ #category : #private }
GtEpiceaBrickVisitor >> displayBehavior: aClassName method: aSelector [

	^ (self displayBehavior: aClassName), (self displayOperation: '»'), (self displayString: aSelector)
]

{ #category : #private }
GtEpiceaBrickVisitor >> displayBehaviorComment: aClassName [

	^ (self displayBehavior: aClassName), (self displayOperation: 'comment')
]

{ #category : #private }
GtEpiceaBrickVisitor >> displayBrowserOperation: aBrowserOperationEvent [

	^ self displayOperation: (
		String streamContents: [ :stream |
			stream nextPutAll: aBrowserOperationEvent title ])
]

{ #category : #private }
GtEpiceaBrickVisitor >> displayCategory: aCategoryName [

	^ (self displayOperation: 'Package tag'), (self displayString: aCategoryName asString)
]

{ #category : #private }
GtEpiceaBrickVisitor >> displayClass: aClassName protocol: aProtocolName [

	^ (self displayBehavior: aClassName), (self displayOperation: 'protocol'), (self displayString: aProtocolName)

]

{ #category : #private }
GtEpiceaBrickVisitor >> displayOperation: aString [ 

	^ self 
		displayString: aString 
		color: self brickFactory softerTextColor
]

{ #category : #private }
GtEpiceaBrickVisitor >> displayString: aString [

	^ { self brickFactory stringFor: aString }
]

{ #category : #private }
GtEpiceaBrickVisitor >> displayString: aString color: aColor [

	^ { self brickFactory stringFor: aString color: aColor }
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitBehaviorCategoryChange: aClassRecategorizationChange [

	^	(self displayOperation: 'Move'),
		(self displayBehavior: aClassRecategorizationChange behaviorAffectedName), 
		(self displayOperation: 'from tag'),
		(self displayString: aClassRecategorizationChange oldCategory), 
		(self displayOperation: 'to'), 
		(self displayString: aClassRecategorizationChange newCategory)
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitBehaviorCommentChange: aChange [

	^ self displayBehaviorComment: aChange behaviorAffectedName
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitBehaviorCopy: aClassCopy [

	^ (self displayBehavior: aClassCopy definition name), (self displayOperation: 'copyNamed:'), (self displayBehavior: '#', aClassCopy newName)
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitBehaviorNameChange: aClassRenamedChange [

	^	(self displayOperation: 'Rename'), 
		(self displayBehavior: aClassRenamedChange oldName), 
		(self displayOperation: 'as'), 
		(self displayString: aClassRenamedChange newName)
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitCategoryAddition: aCategoryChange [

	^ self displayCategory: aCategoryChange categoryName
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitCategoryRemoval: aCategoryChange [

	^ self displayCategory: aCategoryChange categoryName
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitCategoryRename: aCategoryChange [

	^	(self displayOperation: 'Rename tag'),
		(self displayString: aCategoryChange oldCategoryName),
		(self displayOperation: 'as'),
		(self displayString: aCategoryChange newCategoryName )
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitClassChange: aChange [

	^ self displayBehavior: aChange behaviorAffectedName
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitEvent: anEvent [

	^ self displayString: ''
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitExpressionEvaluation: anExpressionEvaluation [

	^ (self displayOperation: 'DoIt:'), (self displayString:
		(anExpressionEvaluation expression printStringLimitedTo: 50) 
			withSeparatorsCompacted)
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitLogCommentModification: aLogCommentModification [ 

	^ self displayString: aLogCommentModification comment printString
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitMethodAddition: aMethodCreatedChange [

	^ self 
		displayBehavior: aMethodCreatedChange behaviorAffectedName
		method: aMethodCreatedChange methodAdded selector
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitMethodModification: aMethodModified [

	^ self 
		displayBehavior: aMethodModified behaviorAffectedName
		method: aMethodModified oldMethod selector
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitMethodRemoval: aMethodRemoved [

	^ self 
		displayBehavior: aMethodRemoved behaviorAffectedName
		method: aMethodRemoved methodRemoved selector
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitMonticelloVersionSave: aChange [

	^	(self displayOperation: 'MC save'), 
		(self displayString: aChange versionName asString), 
		(self displayOperation: 'on'), 
		(self displayString: aChange repositoryDescription asString)
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitMonticelloVersionsLoad: aMonticelloVersionLoaded [ 

	^	(self displayOperation: 'MC load'), 
		(self displayString: aMonticelloVersionLoaded versionNames asCommaStringAnd)
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitProtocolAddition: aProtocolChange [

	^ self 
		displayClass: aProtocolChange behaviorAffectedName
		protocol: aProtocolChange protocol asString
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitProtocolRemoval: aProtocolChange [

	^ self 
		displayClass: aProtocolChange behaviorAffectedName
		protocol: aProtocolChange protocol asString
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitRedo: aRedoEvent [

	^ self displayBrowserOperation: aRedoEvent
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitRefactoring: aRefactoring [ 

	^  (self displayOperation: 'Refactoring: '), 
		(self displayString: (String streamContents: [ :aStream | 
			aRefactoring summaryOn: aStream ]))
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitSessionEnd: anEvent [

	^ (self displayOperation: 'End:'), 
		(self displayString: anEvent imageName)
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitSessionSnapshot: anEvent [

	^ (self displayOperation: 'Snapshot:'), 
		(self displayString: anEvent imageName)
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitSessionStart: anEvent [

	^ (self displayOperation: 'Start:'), 
		(self displayString: anEvent imageName)
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitTraitChange: aChange [

	^ self displayBehavior: aChange behaviorAffectedName
]

{ #category : #visitor }
GtEpiceaBrickVisitor >> visitUndo: anUndoEvent [

	^ self displayBrowserOperation: anUndoEvent
]
