Class {
	#name : #LeYoutubeReferenceElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'snippetToolbar',
		'editorElement',
		'pictureContainer',
		'gtUrlUtility',
		'exception',
		'errorStencil',
		'errorText',
		'authorName',
		'title'
	],
	#category : #'Lepiter-Snippet-Youtube-View-Element'
}

{ #category : #accessing }
LeYoutubeReferenceElement >> computeImageUrl: aStringUrl [
	| videoId |
	videoId:=aStringUrl asZnUrl query at:'v' ifAbsent:[''].
	^ 'http://img.youtube.com/vi/',videoId,'/0.jpg'
	
]

{ #category : #accessing }
LeYoutubeReferenceElement >> defaultErrorStencil [

	^ BrValuableStencil new valuable: [ :anException | | container message |
		container := BlElement new.
		container layout: BlLinearLayout horizontal.
		message := errorText ifNil: [ anException messageText ].
		container addChild: (BlTextElement new
			text: 'Debug' translated asRopedText;
			border: (BlBorder paint: Color gray width: 1);
			labelMeasurement;
			background: Color white;
			padding: (BlInsets top: 5 left: 8 bottom: 5 right: 8);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			when: BlClickEvent do: [ [ anException defaultAction ] fork ]).
		container addChild: (BlTextElement new 
			margin: (BlInsets left: 10 right: 10);
			constraintsDo: [ :c |
				c horizontal exact: 1200.
				c vertical exact: 14 ];
			text: message asRopedText).
		container ].
]

{ #category : #accessing }
LeYoutubeReferenceElement >> errorStencil [

	^ errorStencil ifNil: [ self defaultErrorStencil ]
]

{ #category : #accessing }
LeYoutubeReferenceElement >> errorStencil: anObject [
	errorStencil := anObject
]

{ #category : #accessing }
LeYoutubeReferenceElement >> errorText [
	^ errorText
]

{ #category : #accessing }
LeYoutubeReferenceElement >> errorText: anObject [
	errorText := anObject
]

{ #category : #accessing }
LeYoutubeReferenceElement >> exceptionAction [

	^ [ self removeChildren.
		exception ifNotNil: [ | exceptionElement |
				exceptionElement := (self errorStencil arguments: { exception }) create.
				exceptionElement constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent.
					c frame vertical alignCenter.
					c frame horizontal alignCenter ].
				self addChild: exceptionElement ] ]
]

{ #category : #accessing }
LeYoutubeReferenceElement >> initialize [ 
	super initialize.

	self initializeEditor.
	self initializePictureContainer.

	self initializeSceneResizer
]

{ #category : #accessing }
LeYoutubeReferenceElement >> initializeEditor [
	| okButton |

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
		addChild: okButton
]

{ #category : #accessing }
LeYoutubeReferenceElement >> initializePictureContainer [
	pictureContainer := BrButton new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets top: 5 left: 7 bottom: 5 right: 5);
		yourself.
	
	pictureContainer addChild: self videoTitleContainer.
]

{ #category : #accessing }
LeYoutubeReferenceElement >> initializeSceneResizer [
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

{ #category : #accessing }
LeYoutubeReferenceElement >> onSnippetViewModelChanged [
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

{ #category : #accessing }
LeYoutubeReferenceElement >> onSnippetViewModelFocused: aBoolean [
	aBoolean
		ifTrue: [ editorElement requestFocus ]
		ifFalse: [ editorElement loseFocus ]
]

{ #category : #accessing }
LeYoutubeReferenceElement >> onURLModifiedEvent: anEvent [
	| urlString colour |

	urlString := editorElement text asString.
	gtUrlUtility urlString: urlString.
	colour := gtUrlUtility isValid 
		ifTrue: [ Color black ]
		ifFalse: [ Color red ].
	editorElement text foreground: colour.
	gtUrlUtility isValid 
		ifTrue: [self snippet urlString: urlString source: self].
]

{ #category : #accessing }
LeYoutubeReferenceElement >> pictureUrlString: urlString [
	self urlString: urlString.
]

{ #category : #accessing }
LeYoutubeReferenceElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ pictureContainer
]

{ #category : #accessing }
LeYoutubeReferenceElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ snippetToolbar
]

{ #category : #accessing }
LeYoutubeReferenceElement >> updatePicture [
	| imageElement imageUrl utility |
	imageElement := gtUrlUtility isValid
		ifFalse: [ imageElement := BlElement new size: 0 @ 0 ]
		ifTrue: [ imageUrl := self computeImageUrl: gtUrlUtility urlString.
			utility := GtUrlStringUtility new.
			utility urlString: imageUrl.
			utility isValid
				ifFalse: [ BlElement new size: 0 @ 0 ]
				ifTrue: [ 
				title label: self snippet title.
				authorName label: self snippet authorName.
				(BlUrlImageElement new url: utility urlString)
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical exact: 300 ] ] ].
	pictureContainer removeChildNamed: #imageElement.
	pictureContainer addChild: imageElement as: #imageElement.
	
]

{ #category : #accessing }
LeYoutubeReferenceElement >> urlString [
	^ gtUrlUtility urlString
]

{ #category : #accessing }
LeYoutubeReferenceElement >> urlString: urlString [
	"Set the editor and receiver's snippet URL.
	This is only used by the file selector"

	editorElement text: urlString asRopedText.
	gtUrlUtility urlString: urlString.
	self snippet urlString: urlString source: self.
	self updatePicture
]

{ #category : #accessing }
LeYoutubeReferenceElement >> videoTitleContainer [
	| container |
	container := BrHorizontalPane new
		hMatchParent;
		padding: (BlInsets top: 4 bottom: 4);
		alignCenter;
		cellSpacing: 5;
		vFitContent.
		
	authorName := BrButton new.
	authorName
			aptitude: BrGlamorousButtonRectangularAptitude
			+ BrGlamorousButtonLabelAptitude;
			action:  [ WebBrowser openOn: self snippet authorUrl ];
			icon: BrGlamorousIcons go asElement;
			label: ''.
	title := BrButton new.
	title aptitude: BrGlamorousButtonRectangularAptitude
			+ BrGlamorousButtonLabelAptitude;
			action:  [ WebBrowser openOn: self snippet youtubeUrl ];
			icon: BrGlamorousIcons go asElement;
			label: ''.
	container addChild: title; addChild: authorName.
	^ container
]
