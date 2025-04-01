Class {
	#name : #LePictureSnippetElement,
	#superclass : #LeSnippetElement,
	#traits : 'TBlElementError',
	#classTraits : 'TBlElementError classTrait',
	#instVars : [
		'pictureContainer',
		'gtUrlUtility',
		'snippetToolbar',
		'urlEditorElement',
		'captionEditorElement',
		'captionLabel',
		'referenceEditorElement'
	],
	#category : #'Lepiter-Snippet-Picture-Snippet'
}

{ #category : #private }
LePictureSnippetElement >> createPictureWidgetForValidExternalUrl [
	^ gtUrlUtility isValid
		ifFalse: [ nil ]
		ifTrue: [ 
			BrAsyncFileWidget new 
				url: gtUrlUtility urlString ]
]

{ #category : #private }
LePictureSnippetElement >> createPictureWidgetFromAttachment [
	| attachmentWithData |
	attachmentWithData := self findAttachmentWithData.
	attachmentWithData ifNil: [ ^ nil ].
	
	"This part exists mostly for backward compatibility. Most likely
	not really needed, but right now if we are dealing with a valid 
	attachment stored on disk, we use the old way of rendering it"
	^ attachmentWithData hasWithDiskStorage
		ifTrue: [ self createPictureWidgetForValidExternalUrl ]
		ifFalse: [ attachmentWithData createPictureWidget ]
]

{ #category : #private }
LePictureSnippetElement >> findAttachmentWithData [
	| parts uuid |
	self snippet urlString ifNil: [ ^ nil ].
	parts := self snippet urlString splitOn: '/'.
	parts size < 2 ifTrue: [ ^ nil ].
	
	[uuid := UUID fromString36: parts second] 
		on: Error do: [ :ex | ^ nil ] .
	self database  hasMonitor ifFalse: [ ^ nil ].
	^ self database 
		attachmentWithDataForId: uuid
]

{ #category : #initialization }
LePictureSnippetElement >> initialize [ 
	super initialize.

	self initializeToolbar.
	self initializePictureContainer.

	self initializeSceneResizer
]

{ #category : #initialization }
LePictureSnippetElement >> initializeCaptionEditor [
	captionEditorElement := BrEditor new
			id: LePictureSnippetCaptionEditorElementId;
			aptitude: BrGlamorousRegularEditorAptitude new glamorousRegularSmallSize
					+ BrGlamorousInputFieldSpacingAptitude new;
			vFitContent;
			hMatchParent;
			constraintsDo: [ :c | 
				c minWidth: 100.
				c grid vertical alignCenter ].

	captionEditorElement editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self onCaptionModifiedEvent: anEvent ].
		
	LeSnippetEditorElementShortcuter new
		editor: captionEditorElement;
		indent;
		moveUpAndDown;
		loseFocus.

	snippetToolbar
		addChild: (BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors disabledButtonTextColor);
				beSmallSize;
				text: 'Caption:';
				constraintsDo: [ :c | 
					c grid vertical alignCenter ]);
		addChild: captionEditorElement
]

{ #category : #initialization }
LePictureSnippetElement >> initializePictureContainer [
	pictureContainer := BlElement new
		id: LePictureSnippetImageContainerElementId;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets top: 5 left: 7 bottom: 5 right: 5);
		yourself.
		
	captionLabel := BrLabel new 
		id: LePictureSnippetCaptionLabelElementId;
		hFitContentLimited;
		vFitContent;
		aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors disabledButtonTextColor);
		text: '';
		constraintsDo: [ :c | 
			c linear horizontal alignCenter ].
			
	pictureContainer addChild: captionLabel
]

{ #category : #initialization }
LePictureSnippetElement >> initializeReferenceEditor [
	referenceEditorElement := BrEditor new
			id: LePictureSnippetReferenceEditorElementId;
			aptitude: BrGlamorousRegularEditorAptitude new glamorousRegularSmallSize
					+ BrGlamorousInputFieldSpacingAptitude new;
			vFitContent;
			hMatchParent;
			constraintsDo: [ :c | 
				c minWidth: 100.
				c grid vertical alignCenter ].

	referenceEditorElement editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self onReferenceModifiedEvent: anEvent ].
		
	LeSnippetEditorElementShortcuter new
		editor: referenceEditorElement;
		indent;
		moveUpAndDown;
		loseFocus.

	snippetToolbar
		addChild: (BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors disabledButtonTextColor);
				beSmallSize;
				text: 'Reference:';
				constraintsDo: [ :c | 
					c grid vertical alignCenter ]);
		addChild: referenceEditorElement
]

{ #category : #initialization }
LePictureSnippetElement >> initializeSceneResizer [
	pictureContainer
		addAptitude: (BrGlamorousWithVerticalResizerAptitude new beBottom
				resizerDo: [ :theResizer | 
					theResizer
						when: BlResizerResizedEvent
						do: [ :anEvent | self onResizerResized: anEvent ] ])
]

{ #category : #initialization }
LePictureSnippetElement >> initializeToolbar [
	snippetToolbar := BrHorizontalGrid new
		padding: (BlInsets top: 4 bottom: 4);
		columnCount: 2;
		cellSpacing: 5;
		hMatchParent;
		vFitContent.

	self initializeUrlEditor.
	self initializeCaptionEditor.
	self initializeReferenceEditor.
]

{ #category : #initialization }
LePictureSnippetElement >> initializeUrlEditor [
	| okButton fileStencil fileSelector urlContainer |

	urlContainer := BrHorizontalPane new
		hMatchParent;
		alignCenterLeft;
		vFitContent;
		constraintsDo: [ :c | 
			c grid vertical alignCenter ].

	urlEditorElement := BrEditor new
		id: LePictureSnippetUrlEditorElementId;
		aptitude: BrGlamorousRegularEditorAptitude new glamorousRegularSmallSize + BrGlamorousInputFieldSpacingAptitude new;
		vFitContent;
		hMatchParent;
		margin: (BlInsets right: 3);
		constraintsDo: [ :c | c minWidth: 100 ].

	urlEditorElement editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self onURLModifiedEvent: anEvent ].
		
	LeSnippetEditorElementShortcuter new
		editor: urlEditorElement;
		indent;
		moveUpAndDown;
		loseFocus.

	fileStencil := LePictureImportStencil new pictureElement: self.
	fileSelector := fileStencil asElement.
	fileSelector beSmallSize.
	fileSelector margin: (BlInsets right: 3).

	okButton := BrButton new
		id: LePictureSnippetAcceptUrlElementId;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		beSmallSize;
		action: [ :aButton | self updatePicture ].

	urlContainer
		addChild: urlEditorElement;
		addChild: fileSelector;
		addChild: okButton.
		
	snippetToolbar 
		addChild: (BrLabel new
			aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors disabledButtonTextColor);
			beSmallSize;
			text: 'URL:';
			constraintsDo: [ :c | 
				c grid vertical alignCenter ]);
		addChild: urlContainer
]

{ #category : #testing }
LePictureSnippetElement >> isWithPictureAttachment [
	^ self snippet urlString notNil and: [
		self snippet urlString beginsWith: 'attachments/']
]

{ #category : #'private - event handling' }
LePictureSnippetElement >> onCaptionModifiedEvent: anEvent [
	| titleString |

	titleString := captionEditorElement text asString.
	captionLabel text: titleString.
	self snippet caption: titleString source: self
]

{ #category : #'private - event handling' }
LePictureSnippetElement >> onReferenceModifiedEvent: anEvent [
	| titleString |

	titleString := referenceEditorElement text asString.
	self snippet reference: titleString source: self
]

{ #category : #'private - event handling' }
LePictureSnippetElement >> onResizerResized: anEvent [
	"Since pictureContainer is (must be) with #vFitContent,
	we set the #imageElement exact height. The pictureContainer also have
	as a child captionLabel. For that reason we have to subtract some vertical values
	as expressed in the code."

	pictureContainer
		childWithId: #imageElement
		ifFound: [ :anImageElement | 
			| aLabelVerticalSpace anImageHeight |
			aLabelVerticalSpace := captionLabel height + captionLabel padding height
					+ captionLabel margin height + pictureContainer padding height.
			anImageHeight := (anEvent extent y - aLabelVerticalSpace) max: 0.
			self snippet previewHeight: anImageHeight.
			(BrResizerElementLength exact: anImageHeight) adjustHeightFor: anImageElement ]
		ifNone: [  ]
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
	urlEditorElement text: urlString asRopedText.
	captionEditorElement text: self snippet caption.
	captionLabel text: self snippet caption.
	referenceEditorElement text: self snippet reference.
	self updatePicture
]

{ #category : #'private - event handling' }
LePictureSnippetElement >> onSnippetViewModelFocused: aBoolean [
	aBoolean
		ifTrue: [ urlEditorElement requestFocus ]
		ifFalse: [ urlEditorElement loseFocus ]
]

{ #category : #'private - event handling' }
LePictureSnippetElement >> onURLModifiedEvent: anEvent [
	| urlString colour |

	urlString := urlEditorElement text asString.
	gtUrlUtility urlString: urlString.
	colour := gtUrlUtility isValid 
		ifTrue: [ Color black ]
		ifFalse: [ Color red ].
	urlEditorElement text foreground: colour.
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
	
	imageElement := self isWithPictureAttachment
		ifTrue: [ self createPictureWidgetFromAttachment ] 
		ifFalse: [ self createPictureWidgetForValidExternalUrl ].
	
	imageElement 
		ifNil: [ 
			imageElement := BlElement new 
				size: 0 @ 0 ]
		ifNotNil: [
			| currentPreviewHeight |
			currentPreviewHeight := self snippet previewHeight.
			currentPreviewHeight isZero ifTrue: [ 
				currentPreviewHeight := 300.
				self snippet 
					previewHeight: currentPreviewHeight ].
				imageElement
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical exact: currentPreviewHeight ] ].

	pictureContainer removeChildNamed: #imageElement.
	pictureContainer addChildFirst: imageElement as: #imageElement
]

{ #category : #accessing }
LePictureSnippetElement >> urlString [
	^ gtUrlUtility urlString
]

{ #category : #accessing }
LePictureSnippetElement >> urlString: urlString [
	"Set the editor and receiver's snippet URL.
	This is only used by the file selector"

	urlEditorElement text: urlString asRopedText.
	gtUrlUtility urlString: urlString.
	self snippet urlString: urlString source: self.
	self updatePicture
]
