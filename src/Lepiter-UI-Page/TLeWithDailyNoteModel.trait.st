Trait {
	#name : #TLeWithDailyNoteModel,
	#instVars : [
		'dailyNoteModel'
	],
	#category : 'Lepiter-UI-Page-! View Models'
}

{ #category : #accessing }
TLeWithDailyNoteModel >> dailyNoteModel [
	"Return a not-null daily note model model assigned to the receiver view model"
	self
		assert: [ dailyNoteModel notNil ]
		description: [ 'daily note model should be initialized' ].

	^ dailyNoteModel
]

{ #category : #accessing }
TLeWithDailyNoteModel >> dailyNoteModel: aDailyNoteModel [
	"Set a not-null daily note domain model assigned to the receiver view model"
	self
		assert: [ aDailyNoteModel notNil ]
		description: [ 'daily note model must not be nil' ].

	dailyNoteModel == aDailyNoteModel 
		ifTrue: [ ^ self ].

	dailyNoteModel ifNotNil: [ self unsubscribeFromDailyNoteModel ].
	dailyNoteModel := aDailyNoteModel.

	self onDailyNoteModelChanged.
	self subscribeToDailyNoteModel
]

{ #category : #'api - daily note' }
TLeWithDailyNoteModel >> onDailyNoteModelChanged [
	"Is sent when a new daily note model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #'api - daily note' }
TLeWithDailyNoteModel >> subscribeToDailyNoteModel [
]

{ #category : #'api - daily note' }
TLeWithDailyNoteModel >> unsubscribeFromDailyNoteModel [
]
