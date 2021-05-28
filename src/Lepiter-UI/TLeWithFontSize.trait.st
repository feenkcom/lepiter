Trait {
	#name : #TLeWithFontSize,
	#instVars : [
		'fontSize'
	],
	#category : #'Lepiter-UI-Basic - Support'
}

{ #category : #'private - event handling' }
TLeWithFontSize >> decreaseFontSize [
	fontSize := ((self fontSize value - 0.2) max: 0.2) fontEm.
	self properties fontSize: fontSize
]

{ #category : #'private - accessing' }
TLeWithFontSize >> fontSize [
	^ fontSize ifNil: [ fontSize := 1.0 fontEm ].
]

{ #category : #'private - event handling' }
TLeWithFontSize >> increaseFontSize [
	fontSize := (self fontSize value + 0.2) fontEm.
	self properties fontSize: fontSize
]

{ #category : #initialization }
TLeWithFontSize >> initializeFontSizeShortcuts [
	self addShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination builder primary equal build;
		action: [ self increaseFontSize ]).
		
	self addShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination builder primary minus build;
		action: [ self decreaseFontSize ]).
]
