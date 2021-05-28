Class {
	#name : #LePictureSnippetElement,
	#superclass : #LeSnippetElement,
	#traits : 'TBlElementError',
	#classTraits : 'TBlElementError classTrait',
	#instVars : [
		'sceneHeightStrategy',
		'sceneResizer',
		'pictureContainer',
		'editorElement',
		'gtUrlUtility',
		'snippetToolbar'
	],
	#category : #'Lepiter-Snippet-Picture-Snippet'
}

{ #category : #initialization }
LePictureSnippetElement >> initialize [ 
	super initialize.

	self initializeEditor.
	self initializePictureContainer.

	self initializeSceneResizer
]

{ #category : #initialization }
LePictureSnippetElement >> initializeEditor [
	| okButton fileStencil fileSelector |

	snippetToolbar := BrHorizontalPane new
		hMatchParent;
		padding: (BlInsets top: 4 bottom: 4);
		alignCenterLeft;
		cellSpacing: 5;
		vFitContent.

	editorElement := BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude new glamorousRegularSmallSize + BrGlamorousInputFieldSpacingAptitude new;
		vFitContent;
		hFitContentLimited;
		constraintsDo: [ :c | c minWidth: 100 ].

	editorElement editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self onURLModifiedEvent: anEvent ].

	fileStencil := LePictureImportStencil new pictureElement: self.
	fileSelector := fileStencil asElement.
	fileSelector beSmallSize.

	okButton := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		beSmallSize;
		action: [ :aButton | self updatePicture ].

	snippetToolbar
		addChild: (BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			beSmallSize;
			text: 'URL:');
		addChild: editorElement;
		addChild: fileSelector;
		addChild: okButton
]

{ #category : #initialization }
LePictureSnippetElement >> initializePictureContainer [
	pictureContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets top: 5 left: 7 bottom: 5 right: 5);
		yourself
]

{ #category : #initialization }
LePictureSnippetElement >> initializeSceneResizer [
	pictureContainer addAptitude: (BrGlamorousWithVerticalResizerAptitude new beBottom
		resizerDo: [ :theResizer |
			theResizer
				when: BlResizerResizedEvent
				do: [:anEvent |
					pictureContainer
						childWithId: #imageElement
						ifFound: [ :anImageElement | (BrResizerElementLength exact: anEvent extent y) adjustHeightFor: anImageElement ]
						ifNone: [ ] ] ])
]

{ #category : #'api - snippet view model' }
LePictureSnippetElement >> onSnippetViewModelChanged [
	| db rootDir urlString |
	super onSnippetViewModelChanged.

	db := self snippet database.

	rootDir := (db isDatabase not or: [ db monitor isNil ])
		ifTrue: [ FileLocator workingDirectory resolve ]
		ifFalse: [ db monitor localRoot ].

	urlString := self snippet urlString.
	gtUrlUtility := GtUrlStringUtility new 
		rootDirectory: rootDir;
		urlString: urlString.
	editorElement text: urlString asRopedText.
	self updatePicture
]

{ #category : #'private - event handling' }
LePictureSnippetElement >> onSnippetViewModelFocused: aBoolean [
	aBoolean
		ifTrue: [ editorElement requestFocus ]
		ifFalse: [ editorElement loseFocus ]
]

{ #category : #'private - event handling' }
LePictureSnippetElement >> onURLModifiedEvent: anEvent [
	| urlString colour |

	urlString := editorElement text asString.
	gtUrlUtility urlString: urlString.
	colour := gtUrlUtility isValid 
		ifTrue: [ Color black ]
		ifFalse: [ Color red ].
	editorElement text foreground: colour.
	self snippet urlString: urlString source: self
]

{ #category : #accessing }
LePictureSnippetElement >> pictureUrlString: urlString [
	self urlString: urlString.
]

{ #category : #'api - view' }
LePictureSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ pictureContainer
]

{ #category : #'api - view' }
LePictureSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ snippetToolbar
]

{ #category : #private }
LePictureSnippetElement >> updatePicture [
	| imageElement |

	imageElement := gtUrlUtility urlString 
		ifEmpty: [ BlElement new size: 0@0 ]
		ifNotEmpty: 
			[ (BlUrlImageElement new url: gtUrlUtility urlString)
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 300. ] ].

	pictureContainer removeChildNamed: #imageElement.
	pictureContainer addChild: imageElement as: #imageElement
]

{ #category : #accessing }
LePictureSnippetElement >> urlString [
	^ gtUrlUtility urlString
]

{ #category : #accessing }
LePictureSnippetElement >> urlString: urlString [
	"Set the editor and receiver's snippet URL.
	This is only used by the file selector"

	editorElement text: urlString asRopedText.
	gtUrlUtility urlString: urlString.
	self snippet urlString: urlString source: self.
	self updatePicture
]
