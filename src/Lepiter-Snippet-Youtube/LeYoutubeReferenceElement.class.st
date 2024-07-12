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
		'title',
		'snippetContainer'
	],
	#category : #'Lepiter-Snippet-Youtube-View-Element'
}

{ #category : #accessing }
LeYoutubeReferenceElement >> computeImageUrl: aStringUrl [
	| videoId |
	videoId := self videoIdFrom: aStringUrl.
	^ 'http://img.youtube.com/vi/' , videoId , '/0.jpg'
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
	snippetContainer := BrVerticalPane new
		hMatchParent;
		vFitContent.
	pictureContainer := BrFrame new
		hMatchParent;
		vExact: 500;
		constraintsDo: [ :c | c minHeight: 200 ];
		when: BlElementExtentChangedEvent 
			do: [ :anEvent | self onPictureContainerExtentChanged: anEvent ];
		yourself.
	
	snippetContainer addChild: self videoTitleContainer as: #title.
	snippetContainer addChild: pictureContainer as: #pictureContainer.
]

{ #category : #accessing }
LeYoutubeReferenceElement >> initializeSceneResizer [
	pictureContainer
		addAptitude: (BrGlamorousWithVerticalResizerAptitude new beBottom
				resizerDo: [ :theResizer | 
					theResizer
						when: BlResizerResizedEvent
						do: [ :anEvent | self onResizerResizedEvent: anEvent ] ])
]

{ #category : #'event handling' }
LeYoutubeReferenceElement >> onPictureContainerExtentChanged: anEvent [
	"Since the HTML embed code defines style as:
		aspect-ratio: 16 / 9;
		height: 100%;
	and we do not want to clip the video horizontally, 
	it is necessary to limit maximimum snippet height."

	| aWidth aHeight aMaxHeight |
	aWidth := anEvent currentTarget width.
	aHeight := anEvent currentTarget height.
	aMaxHeight := aWidth * 9 / 16.
	anEvent currentTarget constraintsDo: [ :c | c maxHeight: aMaxHeight ].
	self updatePictureWidth
]

{ #category : #'event handling' }
LeYoutubeReferenceElement >> onResizerResizedEvent: anEvent [
	self updatePictureWidth
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

	^ snippetContainer
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
	| imageElement utility imageUrl |
	imageElement := gtUrlUtility isValid
			ifFalse: [ BlElement new size: 0 @ 0 ]
			ifTrue: [ imageUrl := self computeImageUrl: gtUrlUtility urlString.
				utility := GtUrlStringUtility new.
				utility urlString: imageUrl.
				utility isValid
					ifFalse: [ BlElement new size: 0 @ 0 ]
					ifTrue: [ title label: self snippet title.
						authorName label: self snippet authorName ].
				GtWebViewElement new
					constraintsDo: [ :c | c frame horizontal alignCenter ];
					when: BlElementExtentChangedEvent
						doOnce: [ :anEvent | self updatePictureWidth: anEvent currentTarget ];
					margin: (BlInsets bottom: 5);
					html: '<iframe style="aspect-ratio: 16 / 9;
  height: 100%;" src="https://www.youtube.com/embed/'
							, (self videoIdFrom: gtUrlUtility urlString)
							, '" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>' ].
	pictureContainer removeChildNamed: #imageElement.
	pictureContainer addChild: imageElement as: #imageElement
]

{ #category : #'private - updating' }
LeYoutubeReferenceElement >> updatePictureWidth [
	pictureContainer
		childWithId: #imageElement
		ifFound: [ :anImageElement | self updatePictureWidth: anImageElement ]
		ifNone: [  ]
]

{ #category : #'private - updating' }
LeYoutubeReferenceElement >> updatePictureWidth: anImageElement [
	"Since the HTML embed code defines style as:
		aspect-ratio: 16 / 9;
		height: 100%;
	and we want to keep the video horizontally in the center of the snippet,
	it is necessary to keep the image element extent ratio to be also 16 / 9."

	| aHeight aNewWidth |
	aHeight := anImageElement height.
	aNewWidth := 16 / 9 * aHeight.
	aNewWidth < pictureContainer width
		ifTrue: [ (BrResizerElementLength exact: aNewWidth) adjustWidthFor: anImageElement ]
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
LeYoutubeReferenceElement >> videoIdFrom: aStringUrl [
	^ LeYoutubeUrl new
		string: aStringUrl;
		embedVideoIdAndStart
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
			label: 'Author'.
	title := BrButton new.
	title aptitude: BrGlamorousButtonRectangularAptitude
			+ BrGlamorousButtonLabelAptitude;
			action:  [ WebBrowser openOn: self snippet youtubeUrl ];
			icon: BrGlamorousIcons go asElement;
			label: 'Watch on YouTube'.
	container addChild: title; addChild: authorName.
	^ container
]
