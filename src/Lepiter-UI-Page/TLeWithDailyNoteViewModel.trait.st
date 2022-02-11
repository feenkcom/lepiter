Trait {
	#name : #TLeWithDailyNoteViewModel,
	#instVars : [
		'dailyNoteViewModel'
	],
	#category : 'Lepiter-UI-Page-! Views'
}

{ #category : #'api - daily note view model' }
TLeWithDailyNoteViewModel >> dailyNoteViewModel [
	"Return a not-null daily note view model assigned to the receiver element"
	self
		assert: [ dailyNoteViewModel notNil ]
		description: [ 'daily note view model should be initialized' ].

	^ dailyNoteViewModel
]

{ #category : #'api - daily note view model' }
TLeWithDailyNoteViewModel >> dailyNoteViewModel: aDailyNoteViewModel [
	"Set a not-null daily note view model assigned to the receiver element"
	self
		assert: [ aDailyNoteViewModel notNil ]
		description: [ 'daily note view model must not be nil' ].

	dailyNoteViewModel == aDailyNoteViewModel 
		ifTrue: [ ^ self ].

	dailyNoteViewModel ifNotNil: [ self unsubscribeFromDailyNoteViewModel ].
	dailyNoteViewModel := aDailyNoteViewModel.

	self onDailyNoteViewModelChanged.
	self subscribeToDailyNoteViewModel
]

{ #category : #'api - daily note view model' }
TLeWithDailyNoteViewModel >> onDailyNoteViewModelChanged [
	"Is sent when a new daily note view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - daily note view model' }
TLeWithDailyNoteViewModel >> subscribeToDailyNoteViewModel [
]

{ #category : #'api - daily note view model' }
TLeWithDailyNoteViewModel >> unsubscribeFromDailyNoteViewModel [
]
