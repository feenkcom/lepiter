Class {
	#name : #LeSnippetStylerVisitor,
	#superclass : #LeContentNodeVisitor,
	#traits : 'TLeExtensibleContentNodeVisitor + TSmaCCCompositeVisitor + TLeContentNodeVisitor',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait + TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'styler',
		'text',
		'referencedPage',
		'results'
	],
	#category : #'Lepiter-UI-Snippet-Text styler'
}

{ #category : #accessing }
LeSnippetStylerVisitor class >> addStyler: aVisitorClass [
	self addComponentVisitorClass: aVisitorClass
]

{ #category : #accessing }
LeSnippetStylerVisitor class >> additionalStylers [
	^ self componentVisitorClasses
]

{ #category : #accessing }
LeSnippetStylerVisitor class >> defaultComponentVisitorClasses [
	^ OrderedCollection with: LeAnnotationStylerVisitor
]

{ #category : #accessing }
LeSnippetStylerVisitor class >> removeStyler: aVisitorClass [
	self removeComponentVisitorClass: aVisitorClass
]

{ #category : #widgets }
LeSnippetStylerVisitor class >> textLinkButtonPadding: additionalPadding margin: additionalMargin [
	"Answer a button used for in-text links in Lepiter.
	This sets a common font, size, color and style for the button"

	^ self textLinkButtonPadding: additionalPadding margin: additionalMargin valid: true
]

{ #category : #widgets }
LeSnippetStylerVisitor class >> textLinkButtonPadding: additionalPadding margin: additionalMargin valid: isValid [
	"Answer a button used for in-text links in Lepiter.
	This sets a common font, size, color and style for the button"
	| color button |

	button := BrButton new.
	button connector beVisualSource.

	color := isValid 
		ifTrue: [ BrGlamorousColors linkColor ]
		ifFalse: [ BrGlamorousColors linkWithErrorColor ].

	button 
		addAptitude: (BrGlamorousButtonLabelAptitude new 
			defaultColor: color;
			hoveredColor: color muchDarker);
		placeholderAlignment: #alignBottom;
		padding: (BlInsets top: 0 left: 0 bottom: -1 right: 0) + additionalPadding;
		margin: (BlInsets top: 0 left: 0 bottom: 0 right: 0) + additionalMargin;
		icon: BrGlamorousVectorIcons inspect;
		beNoneSize;
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent. ].
	^ button

]

{ #category : #visiting }
LeSnippetStylerVisitor >> acceptNode: aSmaCCParseNode [
	aSmaCCParseNode isNil
		ifTrue: [ ^ nil ].	
	
	^ BlTextStylerTelemetry
		time: [ 'Visit ', aSmaCCParseNode class name ]
		during: [	
			(self lookupVisitorFor: aSmaCCParseNode)
				ifNil: [ self visitSmaCCParseNode: aSmaCCParseNode ]
				ifNotNil: [ :visitor | aSmaCCParseNode acceptVisitor: visitor ] ]
]

{ #category : #evaluating }
LeSnippetStylerVisitor >> beginStyling [
	visitors do: [ :each | each beginStyling ]
]

{ #category : #evaluating }
LeSnippetStylerVisitor >> changes [
	^ self styler changes
]

{ #category : #'api - accessing' }
LeSnippetStylerVisitor >> editor [
	^ styler editor
]

{ #category : #evaluating }
LeSnippetStylerVisitor >> elements [
	 self snippetViewModel
	 	ifNil: [ ^ Dictionary new ].

	^ self snippetViewModel optionAt: #elements ifAbsentPut: [ Dictionary new ]
]

{ #category : #evaluating }
LeSnippetStylerVisitor >> evaluateCodeBlock: aCodeBlock expanded: aBoolean from: aButton [
	| aSnippetCoder aSnippetCoderViewModel aResult position source |
	
	source := aCodeBlock code source.
	
	aSnippetCoder := GtPharoSnippetCoder forSource: source.
	aSnippetCoderViewModel := aSnippetCoder asCoderViewModel.
	aSnippetCoderViewModel selfObject: self evaluationReceiver.
	aSnippetCoderViewModel sharedBindings: self variableBindings.
	aResult := aSnippetCoderViewModel doItAll.

	position := source size.
	[ position > 1 and: [ (source at: position) isLineBreak ] ]
		whileTrue: [ position := position - 1 ].
	self executionResults
		at: aCodeBlock code
		put:
			(LeEvaluationResult new
				value: aResult;
				expanded: aBoolean;
				position: position).
	self styler snippetViewModel coderViewModel  coderModel  requestStyleSourceText.
	aBoolean ifTrue: [ aButton phlow spawnObject: aResult value ].
]

{ #category : #evaluating }
LeSnippetStylerVisitor >> evaluationReceiver [
	^ nil
]

{ #category : #evaluating }
LeSnippetStylerVisitor >> examples [
	^ self snippetViewModel optionAt: #examples ifAbsentPut: [ Dictionary new ]
]

{ #category : #evaluating }
LeSnippetStylerVisitor >> executionResults [
	self snippetViewModel
		ifNil: [ ^ Dictionary new ].

	^ self snippetViewModel optionAt: #evaluationResults ifAbsentPut: [ Dictionary new ]
]

{ #category : #evaluating }
LeSnippetStylerVisitor >> executionResults: aDictionary [
	self snippetViewModel ifNotNil: [ :aSnippetViewModel | aSnippetViewModel optionAt: #evaluationResults put: aDictionary ]
]

{ #category : #evaluating }
LeSnippetStylerVisitor >> expanded [
	^ self snippetViewModel optionAt: #expanded ifAbsentPut: [ Dictionary new ]
]

{ #category : #private }
LeSnippetStylerVisitor >> findFileUrlPath: pathString in: rootDir [
	"Try to find the supplied path resolved against the supplied root directory or as an absolute path.
	Answer nil if path not found"
	| absPath |

	pathString ifEmpty: [ ^ nil ].
	absPath := rootDir resolve: pathString.
	^ absPath exists ifTrue: 
		[ absPath pathString ]
	ifFalse: 
		[ absPath := ('/', pathString) asFileReference.
		absPath exists ifTrue: 
			[ absPath pathString ]
		ifFalse:
			[ nil ] ]

]

{ #category : #evaluating }
LeSnippetStylerVisitor >> finished [
	visitors do: [ :each | each finishStyling ].
	self
		executionResults:
			(self executionResults
				reject: [ :each | (results includes: each) not ])
]

{ #category : #private }
LeSnippetStylerVisitor >> fontSizeForHeadingLevel: aHeadingLevel [
	"Compute the relative (em) font size for a text with a given heading level (1-6)"
	<return: #BlFontSize>
	"
	# Heading 1 => font size * 1.5
	# Heading 2 => font size * 1.4
	# Heading 3 => font size * 1.3
	# Heading 4 => font size * 1.2
	# Heading 5 => font size * 1.1
	# Heading 6 => font size * 1.0
	"
	| aFontSizeIncrement aMaxAmountOfHeadingLevels anExtraFontSize |
	
	aFontSizeIncrement := 0.1.
	aMaxAmountOfHeadingLevels := 6.

	anExtraFontSize := (aMaxAmountOfHeadingLevels - aHeadingLevel max: 0) * aFontSizeIncrement.

	^ (1.0 + anExtraFontSize) fontEm
]

{ #category : #initialization }
LeSnippetStylerVisitor >> initialize [
	super initialize.
	results := IdentitySet new
]

{ #category : #'private - testing' }
LeSnippetStylerVisitor >> isCursorInside: anInterval [
	self editor ifNil: [ ^ false ].
	^ self editor cursors
		detect:
			[ :eachCursor | eachCursor position 
				between: anInterval first
				and: anInterval last ]
		ifFound: [ :aCursor | true ]
		ifNone: [ false ]
]

{ #category : #'private - testing' }
LeSnippetStylerVisitor >> isValidLink: urlString [
	"Answer a boolean indicating whether the supplied string is valid.
	There's no restriction on what schemes are supported as we don't know what schemes the OS supports, so any scheme other than file:// will answer true.
	If the scheme is file:// or no scheme is provided, answer a boolean based on the files existence."
	<return: #Boolean>

	^ (self resolveUrl: urlString) isValid
]

{ #category : #'private - instance creation' }
LeSnippetStylerVisitor >> newExpandedElement: aLink [
	| aTarget anElement aContainer |
	aContainer := BrFrame new
		addAptitude: BrShadowAptitude;
		addAptitude: BrGlamorousWithVerticalResizerAptitude;
		background: Color white;
		padding: (BlInsets all: 5);
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c textFlow pushLine ];
		hMatchParent;
		vExact: 300.
	aTarget := self snippetViewModel snippetModel linkTarget: aLink.
	anElement := aTarget
		ifNil: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'empty';
				alignCenter ]
		ifNotNil: [ aTarget asPreviewElement
				matchParent ].
	aContainer addChild: anElement.
	^ aContainer
]

{ #category : #'api - accessing' }
LeSnippetStylerVisitor >> referencedPage [
	^ referencedPage
]

{ #category : #'api - accessing' }
LeSnippetStylerVisitor >> referencedPage: aLePage [
	referencedPage := aLePage
]

{ #category : #private }
LeSnippetStylerVisitor >> resolveUrl: aUrlString [
	"For file urls, resolve against the database directory or root directory, and allow file urls of the form 'file://path/to/image.png' (the host is missing), with the same resolution"
	<return: #GtUrlStringUtility>
	| rootDir |
	
	rootDir :=  (self snippetViewModel notNil and: [ self snippetViewModel snippetModel database monitor notNil ])
		ifTrue: [ self snippetViewModel snippetModel database monitor localRoot ]
		ifFalse: [ FileLocator workingDirectory resolve ].
	^ GtUrlStringUtility new
		rootDirectory: rootDir;
		urlString: aUrlString.
]

{ #category : #'private - testing' }
LeSnippetStylerVisitor >> showMarkup [
	^ self styler showMarkup
]

{ #category : #'api - accessing' }
LeSnippetStylerVisitor >> snippetViewModel [
	^ styler snippetViewModel
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleAutoHiding: leftRange and: rightRange whenOutside: nodeInterval [
	| anAttribute marker1 marker2 cursorAttribute |
	self showMarkup ifTrue: [ ^ self ].
	marker1 := BrTextInvisibleMarkerAttribute new.
	marker2 := BrTextInvisibleMarkerAttribute new.
	self text
		attribute: marker1
		from: leftRange first
		to: leftRange last.
	self text
		attribute: marker2
		from: rightRange first
		to: rightRange last.
	anAttribute := BrTextAdornmentDynamicAttribute new
			beReplace;
			stencil: [ :aTBrTextEditorTextualPiece :anEditorElement | #() ].
	(self isCursorInside: nodeInterval)
		ifFalse: [ self text
				attribute: anAttribute
				from: leftRange first
				to: leftRange last.
			self text
				attribute: anAttribute
				from: rightRange first
				to: rightRange last ].
	cursorAttribute := BrTextCursorAttribute new
			enterAction: [ :aTextEditor | 
				| left right |
				aTextEditor text
					findAttribute: marker1
					indicesDo: [ :start :end | left := start ].
				aTextEditor text
					findAttribute: marker2
					indicesDo: [ :start :end | right := end ].
				(left notNil and: [ right notNil ])
					ifTrue: [ | cursorIndex |
						cursorIndex := aTextEditor cursors first position.
						(cursorIndex between: left - 2 and: right)
							ifTrue: [ aTextEditor text
									clearAttributes: left
									to: right
									if: [ :eachAttribute | eachAttribute == anAttribute ] ] ] ];
			leaveAction: [ :aTextEditor | 
				| left right |
				aTextEditor text
					findAttribute: marker1
					indicesDo: [ :start :end | left := start to: end ].
				aTextEditor text
					findAttribute: marker2
					indicesDo: [ :start :end | right := start to: end ].
				(left notNil and: [ right notNil ])
					ifTrue: [ aTextEditor text
							attributes: {anAttribute}
							from: left first
							to: left last.
						aTextEditor text
							attributes: {anAttribute}
							from: right first
							to: right last ] ].
	self text
		attribute: cursorAttribute
		from: nodeInterval first - 1
		to: nodeInterval last
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleAutoHiding: anInterval text: aSubText [
	| anAttribute aMarkerAttribute cursorAttribute |
	self showMarkup
		ifTrue: [ ^ self ].
		
	"when https://github.com/feenkcom/gtoolkit/issues/1430 is solved this should be refactored!"
	self flag: #TODO.

	aMarkerAttribute := BrTextInvisibleMarkerAttribute new.

	"so that we will be able to find where to add adornment attribute dynamically"
	aSubText attribute: aMarkerAttribute.

	anAttribute := BrTextAdornmentDynamicAttribute new
		beReplace;
		stencil: [ :aTBrTextEditorTextualPiece :anEditorElement | #() ].

	(self isCursorInside: anInterval)
		ifFalse: [ aSubText attribute: anAttribute ].

	cursorAttribute := BrTextCursorAttribute new
			enterAction: [ :aTextEditor | 
			"we have a reference to the attribute instance. find its interval dynamically"
			aTextEditor text
				findAttribute: aMarkerAttribute
				indicesDo: [ :aStart :anEnd | | cursorIndex |
					cursorIndex := aTextEditor cursors first position.
					"and now that we know valid attribute indices we can work with them"
					(cursorIndex between: aStart-2 and: anEnd) ifTrue:
						[ aTextEditor text
							clearAttributes: aStart
							to: anEnd 
							if: [ :eachAttribute | eachAttribute == anAttribute ] ] ] ];

		leaveAction: [ :aTextEditor |
			aTextEditor text
				findAttribute: aMarkerAttribute
				indicesDo: [ :aStart :anEnd |
					aTextEditor text
						attribute: anAttribute  
						from: aStart
						to: anEnd ] ].
	self text
		attribute: cursorAttribute
		from: anInterval first - 1
		to: anInterval last
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleBold: aBoldNode [
	(self text from: aBoldNode startPosition to: aBoldNode stopPosition)
		attributes: {BlFontWeightAttribute bold}.
	self
		styleAutoHiding:
			(aBoldNode leftStars first startPosition to: aBoldNode leftStars last stopPosition)
		and:
			(aBoldNode rightStars first startPosition to: aBoldNode rightStars last stopPosition)
		whenOutside: aBoldNode sourceInterval
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleCode: aCodeNode size: anInteger [
	(self text from: aCodeNode startPosition to: aCodeNode stopPosition)
		glamorousCodeFont.
	self
		styleAutoHiding: (aCodeNode startPosition to: aCodeNode startPosition + anInteger - 1)
		and: (aCodeNode stopPosition - anInteger + 1 to: aCodeNode stopPosition)
		whenOutside: aCodeNode sourceInterval
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleCodeBlock: aCodeNode [
	aCodeNode isForSmalltalk
		ifTrue: [ self styleSmalltalkCodeBlock: aCodeNode ].
	(self text from: aCodeNode startPosition to: aCodeNode stopPosition)
		glamorousCodeFont.
	"self
		styleAutoHiding: (aCodeNode startPosition to: aCodeNode code startPosition - 1)
		and: (aCodeNode code stopPosition + 1 to: aCodeNode stopPosition)
		whenOutside: aCodeNode sourceInterval."
	aCodeNode isForSmalltalk
		ifTrue: [ (text from: aCodeNode stopPosition to: aCodeNode stopPosition)
				attributes:
					{(GtButtonAttribute new
						beAppend;
						stencil: [ GtButtonStencil new
								icon: BrGlamorousVectorIcons play;
								tooltip: 'Execute';
								action:
										[ :aWidget :aButtonModel | self evaluateCodeBlock: aCodeNode expanded: false from: aWidget ] ]).
					(GtButtonAttribute new
						beAppend;
						stencil: [ GtButtonStencil new
								icon: BrGlamorousVectorIcons playinspect;
								tooltip: 'Inspect';
								action:
									[ :aWidget :aButtonModel | self evaluateCodeBlock: aCodeNode expanded: true from: aWidget ] ])}.
			self executionResults
				at: aCodeNode code
				ifPresent: [ :result | self styleResult: result for: aCodeNode ] ]
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleExpandingButton: aLink text: aSubText [
	aSubText
		expandingAdornment: [ :aTBrTextEditorTextualPiece :anEditorElement | 
			| anElement |
			anElement := self newExpandedElement: aLink.
			Array with: anElement ]
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleExternalLink: anExternalLink [
	| linkText |

	linkText := self text
		from: anExternalLink startPosition
		to: anExternalLink stopPosition.
	self styleLinkText: linkText valid: (self isValidLink: anExternalLink url).
	self styleAutoHiding: anExternalLink sourceInterval text: linkText.
	self styleExternalLinkButton: anExternalLink text: linkText.
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleExternalLinkButton: aLink text: aSubText [
	"Append a button to the supplied link text.
	If the link is defined (not empty), the button opens the link.
	If the link is empty, open a dialog allowing the user to select a file"

	aLink url
		ifEmpty: [ self styleFileSelection: aLink text: aSubText ]
		ifNotEmpty: [ self styleOpenExternalLinkButton: aLink text: aSubText ].

]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleFileSelection: aLink text: aSubText [
	"Append a button to the supplied link text that opens the link"

	aSubText appendingAdornment: [ :aTBrTextEditorTextualPiece :anEditorElement | 
		| selectStencil selectDropdown |

		selectStencil := LeFileSelectStencil new 
			label: aLink label;
			tooltip: 'Import file from disk';
			extent: 600@400;
			textEditorPiece: aTBrTextEditorTextualPiece;
			visitor: self;
			subText: aSubText.
		selectDropdown := selectStencil asElement.
		selectDropdown aptitude - BrGlamorousButtonExteriorAptitude.
		selectDropdown ]
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleHeader: aHeaderNode [
	aHeaderNode parts isEmpty ifTrue: [ ^ self ].

	(self text from: aHeaderNode startPosition to: aHeaderNode stopPosition)
		bold;
		fontSize: (self fontSizeForHeadingLevel: aHeaderNode headerLevel).
	self
		styleAutoHiding: (aHeaderNode hidingInterval)
		text: (self text
				from: aHeaderNode hidingStartPosition
				to: aHeaderNode hidingStopPosition).
	aHeaderNode startPosition > 1
		ifTrue: [ (self text from: aHeaderNode startPosition to: aHeaderNode stopPosition)
				paragraphMargin: (BlInsets
						top: (5 - aHeaderNode numberSigns size max: 1) * 10
						left: 0
						bottom: 5
						right: 0) ]
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleItalic: anItalicNode [
	(self text
		from: anItalicNode startPosition
		to: anItalicNode stopPosition)
			italic.

	self
		styleAutoHiding: anItalicNode leftStar sourceInterval
		and: anItalicNode rightStar sourceInterval
		whenOutside: anItalicNode sourceInterval
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleLinkButton: aLink text: aSubText [
	"Style the text used to link to another page"

	aSubText
		appendingAdornment: [ :aTBrTextEditorTextualPiece :anEditorElement | 
			| button page highlight |
			page := self snippetViewModel snippetModel outgoingTextualLinks
					detect: [ :eachLink | eachLink node = aLink ]
					ifFound: [ :theLink | theLink target ]
					ifNone: [ nil ].

			highlight := referencedPage notNil and: [ page == referencedPage ].

			button := self class
					textLinkButtonPadding: aTBrTextEditorTextualPiece wordPadding
					margin: aTBrTextEditorTextualPiece wordMargin
					valid: page isNotNil.

			button model: page.

			highlight
				ifTrue: [ button
						aptitude: (BrGlamorousLinkButtonLabelAptitude new
								labelDo: [ :aLabelElement | aLabelElement padding: (BlInsets all: 0) ]);
						addAptitude: (BrGlamorousLinkButtonExteriorInnerAptitude new
								backgroundPaint: (BrGlamorousColors textHighlightColor alpha: 0.5));
						geometry: (BlRoundedRectangleGeometry cornerRadius: 4) ].

			button
				label: aLink linkUID;
				action: [ :aButton | 
					self snippetViewModel snippetModel
						spawnLinkTarget: aLink
						from: aButton
						inNewTab: false ].

			button viewModel
				when: BlClickEvent
				do: [ :anEvent | 
					anEvent modifiers isPrimaryModifier
						ifTrue: [ self snippetViewModel snippetModel
								spawnLinkTarget: aLink
								from: button
								inNewTab: true ] ].
			button viewModel
				when: BlMouseEnterEvent
				do: [ :anEvent | 
					anEvent consumed: true.
					anEvent modifiers isPrimaryModifier
						ifTrue: [ anEvent target mouseCursor: BlCopyCursor new ]
						ifFalse: [ anEvent target mouseCursor: nil ].
					anEvent target requestFocus ].

			button ]
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleLinkText: aSubText valid: hasValidTarget [
	"Set the colour of the source markup text"
	| aColor |
	aColor := hasValidTarget
		ifTrue: [ BrGlamorousColors textMarkupColor ]
		ifFalse: [ BrGlamorousColors linkWithErrorColor ].
	
	aSubText foreground: aColor.
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleOpenExternalImage: aLink text: aSubText [
	| anImageURL attribute pictureContainer widget |
	anImageURL := (self resolveUrl: aLink url) url asString.

	attribute := BrTextAdornmentDynamicAttribute new
			beAppend;
			withCache: self elements key: anImageURL;
			stencil: [ pictureContainer := BlElement new
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical fitContent ];
						layout: BlLinearLayout vertical;
						padding: (BlInsets
								top: 5
								left: 7
								bottom: 5
								right: 5);
						yourself.

				widget := (BrAsyncFileWidget new url: anImageURL)
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical exact: 300 ].
				pictureContainer addChild: widget as: #imageElement.
				pictureContainer
					addAptitude: (BrGlamorousWithVerticalResizerAptitude new beBottom
							resizerDo: [ :theResizer | 
								theResizer
									when: BlResizerResizedEvent
									do: [ :anEvent | 
										pictureContainer
											childWithId: #imageElement
											ifFound: [ :anImageElement | (BrResizerElementLength exact: anEvent extent y) adjustHeightFor: anImageElement ]
											ifNone: [  ] ] ]) ].

	aSubText attribute: attribute
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleOpenExternalLinkButton: aLink text: aSubText [
	"Append a button to the supplied link text that opens the link"

	aSubText
		appendingAdornment: [ :aTBrTextEditorTextualPiece :anEditorElement | 
			| button oldLook |
			button := self class
					textLinkButtonPadding: aTBrTextEditorTextualPiece wordPadding
					margin: aTBrTextEditorTextualPiece wordMargin.
			oldLook := button aptitude.
			button
				removeAptitude: oldLook;
				addAptitude: (BrGlamorousButtonLabelAndIconAptitude new defaultColor: oldLook defaultColor);
				addAptitude: (BrGlamorousWithExplicitTooltipAptitude text: aLink url asString asRopedText);
				icon: BrGlamorousVectorIcons link;
				label: aLink displayLabel;
				action: [ :aButton | 
					| urlUtility |
					urlUtility := self resolveUrl: aLink url.
					urlUtility isFile
						ifTrue: [ aButton phlow spawnObject: urlUtility asFileReference ]
						ifFalse: [ WebBrowser openOn: urlUtility asString ] ].
			button ]
]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleResult: result for: aCodeNode [
	| evaluatedCodeAttribute |
	results add: result.

	"result expanded
		ifTrue: [
			| previewAttribute |
			
			previewAttribute := GtResizablePreviewAttribute new
				withCache: result selector: #cachedPreview;
				result: result value;
				showSelector: #gtViewsFor:;
				height: 300.

			text
				attribute: previewAttribute
				from: aCodeNode stopPosition
				to: aCodeNode stopPosition ]."

	evaluatedCodeAttribute := GtPlaygroundEvaluatedCodeButtonAttribute new
		result: result value;
		action: [ :aButton :anEvent |
			aButton phlow spawnObject: result value ].
	(text
		from: aCodeNode code startPosition + result position - 1
		to: aCodeNode code startPosition + result position - 1)
		attributes: {evaluatedCodeAttribute}

]

{ #category : #'private - styling' }
LeSnippetStylerVisitor >> styleSmalltalkCodeBlock: aCodeNode [
	| aStyler |
	aStyler := BrRBTextStyler new.
	aStyler workspace: self variableBindings.
	aStyler
		style:
			(text
				from: aCodeNode code startPosition
				to: aCodeNode code stopPosition)
]

{ #category : #accessing }
LeSnippetStylerVisitor >> styler [
	^ styler
]

{ #category : #accessing }
LeSnippetStylerVisitor >> styler: anObject [
	styler := anObject
]

{ #category : #'api - accessing' }
LeSnippetStylerVisitor >> text [
	^ text
]

{ #category : #'api - accessing' }
LeSnippetStylerVisitor >> text: anObject [
	text := anObject
]

{ #category : #evaluating }
LeSnippetStylerVisitor >> variableBindings [
	^ GtSharedVariablesBindings new
]

{ #category : #visiting }
LeSnippetStylerVisitor >> visitBold: aBoldNode [
	self styleBold: aBoldNode.
	^ self visitContent: aBoldNode
]

{ #category : #visiting }
LeSnippetStylerVisitor >> visitCodeBlock: aCodeBlock [
	self styleCodeBlock: aCodeBlock.
	^ self visitContent: aCodeBlock
]

{ #category : #visiting }
LeSnippetStylerVisitor >> visitDefinedLink: aLink [
	| hasValidTarget aSubText |
	super visitDefinedLink: aLink.

	hasValidTarget := self snippetViewModel snippetModel hasLinkTarget: aLink.

	aSubText := self text
		from: aLink startPosition
		to: aLink stopPosition.

	self styleLinkText: aSubText valid: hasValidTarget.
	self styleAutoHiding: aLink sourceInterval text: aSubText.
	self styleLinkButton: aLink text: aSubText.

	hasValidTarget
		ifFalse: [ ^ self ].
	
	self styleExpandingButton: aLink text: aSubText.
]

{ #category : #visiting }
LeSnippetStylerVisitor >> visitExternalImageLink: anExternalLink [ 
	| linkText url validLink |

	linkText := self text
		from: anExternalLink startPosition
		to: anExternalLink stopPosition.
	url := anExternalLink url.
	validLink := self isValidLink: url.
	self styleLinkText: linkText valid: validLink.
	super visitExternalImageLink: anExternalLink.
	self styleAutoHiding: anExternalLink sourceInterval text: linkText.
	anExternalLink url
		ifEmpty: [ self styleFileSelection: anExternalLink text: linkText ]
		ifNotEmpty: [ self styleOpenExternalImage: anExternalLink text: linkText ].

]

{ #category : #visiting }
LeSnippetStylerVisitor >> visitExternalLabelUrlLink: anExternalLink [ 

	super visitExternalLabelUrlLink: anExternalLink.
	self styleExternalLink: anExternalLink.

]

{ #category : #visiting }
LeSnippetStylerVisitor >> visitExternalUrlLink: anExternalLink [ 

	super visitExternalUrlLink: anExternalLink.
	self styleExternalLink: anExternalLink.

]

{ #category : #visiting }
LeSnippetStylerVisitor >> visitHeader: aHeader [
	self styleHeader: aHeader.
	^ self visitContent: aHeader
]

{ #category : #visiting }
LeSnippetStylerVisitor >> visitInlineCode: anInlineCode [
	self
		styleCode: anInlineCode
		size:
			((anInlineCode code source at: 2) = $`
				ifTrue: [ 2 ]
				ifFalse: [ 1 ]).
	^ self visitContent: anInlineCode
]

{ #category : #visiting }
LeSnippetStylerVisitor >> visitItalic: anItalicNode [
	self styleItalic: anItalicNode.
	^ self visitContent: anItalicNode
]
