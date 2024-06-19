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
TLeWithFontSize >> defaultFontSize [
	^ 1.0 fontEm
]

{ #category : #'private - accessing' }
TLeWithFontSize >> fontSize [
	^ fontSize ifNil: [ fontSize := self defaultFontSize ]
]

{ #category : #'private - event handling' }
TLeWithFontSize >> increaseFontSize [
	fontSize := (self fontSize value + 0.2) fontEm.
	self properties fontSize: fontSize
]

{ #category : #initialization }
TLeWithFontSize >> initializeFontSizeShortcuts [
	self addShortcut: (BlShortcutWithAction new
		name: 'Increase font size';
		combination: BlKeyCombination builder primary equal build;
		action: [ self increaseFontSize ]).
		
	self addShortcut: (BlShortcutWithAction new
		name: 'Decrease font size';
		combination: BlKeyCombination builder primary minus build;
		action: [ self decreaseFontSize ]).
		
	self addShortcut: (BlShortcutWithAction new
		name: 'Reset to default font size';
		combination: (BlKeyCombination builder primary key: BlKeyboardKey zero) build;
		action: [ self resetFontSize ]).
]

{ #category : #'private - event handling' }
TLeWithFontSize >> resetFontSize [
	fontSize := self defaultFontSize.
	self properties fontSize: fontSize
]
