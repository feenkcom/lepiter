Class {
	#name : #LeAnnotationStylerVisitor,
	#superclass : #LeComponentStyler,
	#traits : 'TLeAnnotationParseNodeVisitor',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait',
	#instVars : [
		'normalFontSize',
		'lastUniqueId'
	],
	#category : #'Lepiter-UI-Snippet-Text styler'
}

{ #category : #styling }
LeAnnotationStylerVisitor >> applyButtonAttributeFor: aChangesAnnotation [
	^ GtButtonAttribute new
		beAppend;
		stencil:
			(GtButtonStencilBuilder new
				label: LepiterConstants applyButtonLabel;
				icon: LepiterConstants applyButtonIcon;
				action: [ aChangesAnnotation changes applyChanges ])
]

{ #category : #accessing }
LeAnnotationStylerVisitor >> changes [
	^ self composite changes
]

{ #category : #private }
LeAnnotationStylerVisitor >> changesFor: aChangesAnnotation [
	^ aChangesAnnotation filename
		ifNotNil: [ :fn | 
			self changes
				at: fn
				ifAbsentPut: [ | fileNameWithExtension filename changes |
					fileNameWithExtension := (fn
						endsWith: LepiterConstants changesFileExtension)
						ifTrue: [ fn ]
						ifFalse: [ fn , LepiterConstants changesFileExtension ].
					filename := self resolve: fileNameWithExtension.
					changes := GtEpicea new.
					changes ombuFile: filename.
					changes weak
						when: GtEpiceaUpdatedAnnouncement
						send: #handleEpiceaUpdate:
						to: self styler.
					changes ] ]
]

{ #category : #styling }
LeAnnotationStylerVisitor >> createButtonAttributeFor: aChangesAnnotation [
	^ GtButtonAttribute new
		beAppend;
		stencil:
			(GtButtonStencilBuilder new
				label: LepiterConstants createButtonLabel;
				icon: LepiterConstants createButtonIcon;
				action: [ :aButton | aButton phlow spawnObject: aChangesAnnotation changes ])
]

{ #category : #accessing }
LeAnnotationStylerVisitor >> elements [
	^ self composite elements
]

{ #category : #private }
LeAnnotationStylerVisitor >> exampleFor: aMethodDefinition [
	^ self examples
		at: aMethodDefinition
		ifAbsentPut: [
			aMethodDefinition compiledMethod 
				ifNotNil: [ :aMethod |
					aMethod gtExample 
						ifNotNil: #asExampleWithResult ] ]
]

{ #category : #accessing }
LeAnnotationStylerVisitor >> examples [
	^ self composite examples
]

{ #category : #accessing }
LeAnnotationStylerVisitor >> expanded [
	^ self composite expanded
]

{ #category : #styling }
LeAnnotationStylerVisitor >> hasCursorInside: start to: end [
	self composite editor ifNil: [ ^ false ].
	^ self composite editor cursors
		anySatisfy: [ :each | each position between: start and: end ]
]

{ #category : #initialization }
LeAnnotationStylerVisitor >> initialize [
	super initialize.

	normalFontSize := 16.
	lastUniqueId := 0.
]

{ #category : #private }
LeAnnotationStylerVisitor >> markCompleted: aTodoAnnotation [
	self
		modifyTodoAnnotation: aTodoAnnotation
		with:
			[ :model :source | 
			| property |
			property := 'completed=' , Date today iso8601.
			aTodoAnnotation completed
				ifNil:
					[ model
						insertText: ((aTodoAnnotation items isEmpty ifTrue: [ '' ] ifFalse: [ '|' ]) , property) asRopedText
						at: aTodoAnnotation stopPosition ]
				ifNotNil:
					[ :completed | model updateString: (source first: completed startPosition - 1) , property , (source allButFirst: completed stopPosition) ] ]
]

{ #category : #private }
LeAnnotationStylerVisitor >> markUncompleted: aTodoAnnotation [
	self
		modifyTodoAnnotation: aTodoAnnotation
		with:
			[ :model :source | 
			aTodoAnnotation completed
				ifNotNil:
					[ :completed | model updateString: (source first: completed equals stopPosition) , (source allButFirst: completed stopPosition) ] ]
]

{ #category : #private }
LeAnnotationStylerVisitor >> modifyTodoAnnotation: aTodoAnnotation with: aBlock [
	| model source |
	model := self styler snippetViewModel snippetModel.
	source := model string.
	aTodoAnnotation stopPosition > source size ifTrue: [ ^ self ].
	(source copyFrom: aTodoAnnotation startPosition to: aTodoAnnotation stopPosition) = aTodoAnnotation source
		ifFalse: [ ^ self ].
	aBlock value: model value: source
]

{ #category : #accessing }
LeAnnotationStylerVisitor >> nextUniqueId [
	lastUniqueId := lastUniqueId + 1.
	^ lastUniqueId
]

{ #category : #accessing }
LeAnnotationStylerVisitor >> normalFontSize [
	^ normalFontSize
]

{ #category : #accessing }
LeAnnotationStylerVisitor >> normalFontSize: anObject [
	normalFontSize := anObject
]

{ #category : #private }
LeAnnotationStylerVisitor >> resolve: aFilenameString [
	"Search for the supplied file name in the database or working directory"
	| fileReference |

	self snippetViewModel snippetModel database monitor ifNotNil: 
		[ :aMonitor |
		
		fileReference := aMonitor localRoot / aFilenameString.
		fileReference exists ifTrue: 
			[ ^ fileReference ] ].

	^ FileLocator workingDirectory / aFilenameString.
]

{ #category : #private }
LeAnnotationStylerVisitor >> restyleWhenClassChanged: aClassAnnotation [
	aClassAnnotation nameNode
		ifNotNil:
			[ :node | self styler restyleWhenClassChanged: node stringValue asSymbol ]
]

{ #category : #private }
LeAnnotationStylerVisitor >> restyleWhenMethodChanged: aMethodAnnotation [
	aMethodAnnotation nameNode
		ifNotNil: [ :node | 
			self styler
				restyleWhenMethodChanged: node methodName
				inClass:
					(node stringValue
						,
							(node classToken isNil
								ifTrue: [ '' ]
								ifFalse: [ ' class' ])) asSymbol ]
]

{ #category : #private }
LeAnnotationStylerVisitor >> showMarkup [
	^ self styler showMarkup
]

{ #category : #accessing }
LeAnnotationStylerVisitor >> snippetViewModel [
	^ self styler snippetViewModel
]

{ #category : #private }
LeAnnotationStylerVisitor >> sourceDirectory [
	^ '.' asFileReference
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleAnnotationWithMarkup: anAnnotation [
	self utility
		subtleMarkupsInText: self text
		start: anAnnotation parent startPosition
		stop: anAnnotation parent stopPosition
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleApplyButtonFor: aChangesAnnotation [
	aChangesAnnotation changes
		ifNotNil: [ :changes | 
			changes hasImpact
				ifFalse: [ ^ self ].
			(self text
				from: aChangesAnnotation parent stopPosition
				to: aChangesAnnotation parent stopPosition)
				attribute: (self applyButtonAttributeFor: aChangesAnnotation) ]
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleAutoHidingAnnotation: anAnnotation [
	| anAttribute aMarkerAttribute aStartPositionToHide aStopPositionToHide anAnnotationTextToHide aSurroundingTextToRespondToCursor aStartPositionToReactToCursor aStopPositionToReactToCursor |

	self showMarkup
		ifTrue: [ ^ self ].

	anAnnotation isDefined
		ifFalse: [ ^ self ].
		
	aStartPositionToHide := anAnnotation parent startPosition max: 1.
	aStopPositionToHide := anAnnotation parent stopPosition min: (self text size).
	aStartPositionToReactToCursor := (aStartPositionToHide - 2) max: 1.
	aStopPositionToReactToCursor := (aStopPositionToHide + 1) min: self text size.

	anAnnotationTextToHide := self text from: aStartPositionToHide to: aStopPositionToHide.
	aSurroundingTextToRespondToCursor := self text from: aStartPositionToReactToCursor to: aStopPositionToReactToCursor.
	
	"when https://github.com/feenkcom/gtoolkit/issues/1430 is solved this should be refactored!
	The issue was not really solved, the associated commits solve another issue. The editor is still requiered."
	self flag: #TODO.

	aMarkerAttribute := BrTextInvisibleMarkerAttribute new.

	"so that we will be able to find where to add adornment attribute dynamically"
	anAnnotationTextToHide attribute: aMarkerAttribute.

	anAttribute := BrTextHideAttribute new.

	(self hasCursorInside: aStartPositionToHide to: aStopPositionToHide)
		ifFalse: [ anAnnotationTextToHide attribute: anAttribute ].

	aSurroundingTextToRespondToCursor
		onCursorEnter: [ :aTextEditor |
			"we have a reference to the attribute instance. find its interval dynamically"
			aTextEditor text
				findAttribute: aMarkerAttribute
				indicesDo: [ :aStart :anEnd |
					aTextEditor text
						clearAttributes: aStart
						to: anEnd 
						if: [ :eachAttribute | eachAttribute == anAttribute ] ] ]

		leave: [ :aTextEditor |
			aTextEditor text
				findAttribute: aMarkerAttribute
				indicesDo: [ :aStart :anEnd |
					aTextEditor text 
						attribute: anAttribute
						from: aStart
						to: anEnd  ] ]
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleButton: anAnnotation for: object defaultLabel: aLabelBlock withTool: aBlock [
	"Style the buttons for gtClass and gtMethod annotations"

	| attribute anId |
	anAnnotation isDefined ifFalse: [ ^ self ].

	anId := LeTextSnippetAttributeLabelElementId indexed: self nextUniqueId.

	attribute := GtButtonAttribute new
			beAppend;
			stencil: [ | button label |
				label := object
						ifNil: [ anAnnotation nameNode
								ifNil: [ '' ]
								ifNotNil: [ :name | (name value ifNil: [ name ]) source ] ]
						ifNotNil: [ :obj | 
							anAnnotation labelNode
								ifNil: [ aLabelBlock value: obj ]
								ifNotNil: [ :node | node labelFor: obj ] ].
				button := LeSnippetStylerVisitor
						textLinkButtonPadding: (BlInsets top: 2)
						margin: BlInsets empty.
				button aptitude glamorousCodeFont.
				button
					id: anId;
					beSmallSize;
					label: label;
					action: [ :aButton | aButton phlow spawnTool: (aBlock cull: aButton) ].

				button viewModel
					when: BlClickEvent
					do: [ :anEvent | 
						anEvent modifiers isPrimaryModifier
							ifTrue: [ | aTool aSpace |
								aTool := aBlock cull: button.
								aSpace := BlSpace new.
								aSpace title: self gtDisplayString.
								aSpace icon: aTool icon.
								aSpace extent: 1200 @ 600.
								aSpace root background: Color transparent.
								aSpace
									addChild: (GtPager
											createOn: (GtPagerWrapperElement new
													tool: aTool;
													embellisher: (GtPagerPageEmbellisher new extension: GtPagerPageEmbellisherExtension null))) maximized.
								aSpace withHalos.
								button showSpace: aSpace ] ].
				button viewModel
					when: BlMouseEnterEvent
					do: [ :anEvent | 
						anEvent consumed: true.
						anEvent modifiers isPrimaryModifier
							ifTrue: [ anEvent target mouseCursor: BlCopyCursor new ]
							ifFalse: [ anEvent target mouseCursor: nil ].
						anEvent target requestFocus ].
				button ].

	self text
		attribute: attribute
		from: anAnnotation parent startPosition
		to: anAnnotation parent stopPosition
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleButton: anAnnotation for: object withTool: aBlock [
	self
		styleButton: anAnnotation
		for: object
		defaultLabel: #printString
		withTool: aBlock
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleButton: anAnnotation forValuable: aValuable defaultLabel: aLabelBlock withTool: aBlock [
	"Style the buttons for gtClass and gtMethod annotations"
	| attribute anId |

	anAnnotation isDefined
		ifFalse: [ ^ self ].
		
	anId := LeTextSnippetAttributeLabelElementId indexed: self nextUniqueId. 
		
	attribute := GtButtonAttribute new
		beAppend;
		stencil: [
			| button |
			button := LeSnippetStylerVisitor 
				textLinkButtonPadding: (BlInsets top: 2) 
				margin: BlInsets empty.
			button aptitude glamorousCodeFont.
			button
				id: anId;
				beSmallSize;
				label: '?';
				enabled: false.
				
			button withAsyncFutureDo: [ :anElementFuture | 
				anElementFuture
					whenPending: [ :theButton |
						button 
							label: '?';
							enabled: false ];
					whenError: [ :theButton :anError |
						| aLabel |
						aLabel := (anError messageText ifEmpty: [ anError printString ]) asRopedText.
						aLabel foreground: BrGlamorousColors errorBackgroundColor.
						theButton label: aLabel.
						theButton action: [ :aButton | aButton phlow spawnObject: anError ].
						theButton enabled: true.
					];
					whenSuccess: [ :theButton :anObject | 
						| aLabel |
						aLabel := anObject
							ifNil: [ anAnnotation nameNode
									ifNil: [ '' ]
									ifNotNil: [ :aName | (aName value ifNil: [ aName ]) source ] ]
							ifNotNil: [ :theObject | 
								anAnnotation labelNode
									ifNil: [ aLabelBlock value: theObject ]
									ifNotNil: [ :node | node labelFor: theObject ] ].
						theButton label: aLabel.
						
						theButton action: [ :aButton | aButton phlow spawnTool: (aBlock cull: aButton) ].
						theButton enabled: true
					].
					
					anElementFuture future: aValuable asAsyncFuture flatten.
				].
				
			button ].

	self text
		attribute: attribute
		from: anAnnotation parent startPosition
		to: anAnnotation parent stopPosition.
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleButton: anAnnotation withTool: aBlock [
	self
		styleButton: anAnnotation
		for: anAnnotation imageObject
		withTool: aBlock
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleCreateButtonFor: aChangesAnnotation [
	| changes |

	changes := aChangesAnnotation changes.

	(changes notNil and: [ changes hasChanges ])
		ifFalse: [ ^ self ].

	self text
		attribute: (self createButtonAttributeFor: aChangesAnnotation)
		from: aChangesAnnotation parent stopPosition
		to: aChangesAnnotation parent stopPosition
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleExpandingExample: anExampleAnnotation [
	| attribute anExample anId |

	anExampleAnnotation isDefined
		ifFalse: [ ^ self ].
		
	anExample := anExampleAnnotation imageObject 
		ifNotNil: [ :aMethodDefinition | 
			aMethodDefinition compiledMethod 
				ifNotNil: [ :aCompiledMethod | 
					aCompiledMethod gtExample 
						ifNotNil: #asCachedExampleWithResult ] ].
						
	anId := LeTextSnippetAttributeExampleElementId indexed: self nextUniqueId.

	attribute := GtExamplePreviewAttribute new
		withCache: self elements key: anExampleAnnotation source;
		beAppend;
		elementId: anId;
		example: anExample;
		codeExpanded: anExampleAnnotation codeExpanded;
		noCode: anExampleAnnotation noCode;
		previewExpanded: anExampleAnnotation previewExpanded;
		previewShowSelector:
			(anExampleAnnotation previewShowSelector
				ifNil: [ LepiterConstants defaultShowSelector ]);
		previewSelectSelector:(anExampleAnnotation previewSelectSelector);
		previewHeight:
			(anExampleAnnotation previewHeight
				ifNil: [ LepiterConstants defaultPreviewHeight ]).

	(self text
		from: anExampleAnnotation parent startPosition
		to: anExampleAnnotation parent stopPosition) attribute: attribute
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleExpandingObject: aClassAnnotation withDefault: aSymbol [
	| cacheKey attribute |
	aClassAnnotation isDefined
		ifFalse: [ ^ self ].

	cacheKey := aClassAnnotation source.
	
	attribute := GtCachedTextExpandButtonAttribute new
		isExpanded: (self expanded at: cacheKey ifAbsentPut: [ aClassAnnotation expanded ]);
		attributesCreatingBlock: [
			GtResizablePreviewAttribute new
				withCache: self elements key: cacheKey;
				result: aClassAnnotation imageObject;
				showSelector: (aClassAnnotation showSelector ifNil: [ aSymbol ]);
				height: (aClassAnnotation height ifNil: [ LepiterConstants defaultPreviewHeight ]) ];
		onCachingDo: [ :aBoolean :theAttribute | self expanded at: cacheKey put: aBoolean ].

	self text
		attribute: attribute
		from: aClassAnnotation parent startPosition
		to: aClassAnnotation parent stopPosition
]

{ #category : #'private - styling' }
LeAnnotationStylerVisitor >> styleLinkButton: aLink text: aSubText [
	"Style the buttons for gtPage annotations"

	aSubText
		appendingAdornment: [ :aTBrTextEditorTextualPiece :anEditorElement | 
			| button page snippetModel |
			snippetModel := self snippetViewModel snippetModel.
			page := snippetModel outgoingTextualLinks
				detect: [ :eachLink | eachLink node = aLink ]
				ifFound: [ :theLink | theLink target ]
				ifNone: [ nil ].
			button := LeSnippetStylerVisitor 
				textLinkButtonPadding: aTBrTextEditorTextualPiece wordPadding 
				margin: aTBrTextEditorTextualPiece wordMargin
				valid: page isNotNil.
			button 
				model: page;
				label: (aLink linkLabelInDatabase: snippetModel database);
				action: [ :aButton | self snippetViewModel snippetModel spawnLinkTarget: aLink from: aButton inNewTab: false ].
			button ]
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleName: aClassAnnotation [
	| nameNode aLinkColor |

	(nameNode := aClassAnnotation nameNode)
		ifNil: [ ^ self ].

	aLinkColor := nameNode isDefined
		ifTrue: [ BrGlamorousColors textMarkupColor ]
		ifFalse: [ BrGlamorousColors linkWithErrorColor ].

	(self text from: nameNode startPosition to: nameNode stopPosition)
		foreground: aLinkColor
]

{ #category : #styling }
LeAnnotationStylerVisitor >> styleTag: aPackageAnnotation [
	| nameNode aLinkColor tagNode |

	(nameNode := aPackageAnnotation nameNode)
		ifNil: [ ^ self ].

	(tagNode := aPackageAnnotation tagNode)
		ifNil: [ ^ self ].

	aLinkColor := (tagNode isDefinedIn: nameNode imageObject)
		ifTrue: [ BrGlamorousColors textMarkupColor ]
		ifFalse: [ BrGlamorousColors linkWithErrorColor ].

	(self text from: tagNode startPosition to: tagNode stopPosition)
		foreground: aLinkColor.
		
]

{ #category : #accessing }
LeAnnotationStylerVisitor >> styler [
	^ composite styler
]

{ #category : #accessing }
LeAnnotationStylerVisitor >> text [
	^ self composite text
]

{ #category : #styling }
LeAnnotationStylerVisitor >> utility [
	^ GtDocumentUtility
]

{ #category : #visiting }
LeAnnotationStylerVisitor >> visitAnnotation: anAnnotation [
	self styleAnnotationWithMarkup: anAnnotation.
	self styleAutoHidingAnnotation: anAnnotation.
	self visitAnnotationParse: anAnnotation
]

{ #category : #visiting }
LeAnnotationStylerVisitor >> visitChangesAnnotation: aChangesAnnotation [
	(self changesFor: aChangesAnnotation)
		ifNotNil: [ :changes | 
			aChangesAnnotation changes: changes.
			self styler subscribeToSystem ].
	self visitAnnotation: aChangesAnnotation.
	self
		styleButton: aChangesAnnotation
		for: aChangesAnnotation imageObject
		defaultLabel: [ :obj | obj ombuFile basename ]
		withTool: [ GtPhlowTool default object: aChangesAnnotation imageObject ].
	self
		styleExpandingObject: aChangesAnnotation
		withDefault: LepiterConstants defaultChangesShowSelector.
	self styleApplyButtonFor: aChangesAnnotation
]

{ #category : #visiting }
LeAnnotationStylerVisitor >> visitClassAnnotation: aClassAnnotation [
	self visitAnnotation: aClassAnnotation.
	self restyleWhenClassChanged: aClassAnnotation.
	self styleName: aClassAnnotation.
	self
		styleButton: aClassAnnotation
		withTool: [ GtClassCoderTool forClass: aClassAnnotation imageObject ].
	self
		styleExpandingObject: aClassAnnotation
		withDefault: LepiterConstants defaultClassShowSelector
]

{ #category : #visiting }
LeAnnotationStylerVisitor >> visitExampleAnnotation: anExampleAnnotation [
	| anExample |
	self visitAnnotation: anExampleAnnotation.
	self restyleWhenMethodChanged: anExampleAnnotation.
	self styleName: anExampleAnnotation.

	anExample := self exampleFor: anExampleAnnotation imageObject.
	anExample ifNil: [ ^ self ].

	anExampleAnnotation hasLabel
		ifTrue: [ self
				styleButton: anExampleAnnotation
				forValuable: (MessageSend receiver: anExample selector: #returnValue)
				defaultLabel: #printString
				withTool: [ GtInspectorTool new
						valuable: (MessageSend receiver: anExample selector: #returnValue) ] ]
		ifFalse: [ self styleExpandingExample: anExampleAnnotation ]
]

{ #category : #visiting }
LeAnnotationStylerVisitor >> visitMethodAnnotation: aMethodAnnotation [
	self visitAnnotation: aMethodAnnotation.
	self restyleWhenMethodChanged: aMethodAnnotation.
	self styleName: aMethodAnnotation.
	self
		styleButton: aMethodAnnotation
		withTool: [ GtMethodCoderTool compiledMethod: aMethodAnnotation imageObject ].
	self
		styleExpandingObject: aMethodAnnotation
		withDefault: LepiterConstants defaultMethodShowSelector
]

{ #category : #visiting }
LeAnnotationStylerVisitor >> visitPackageAnnotation: aPackageAnnotation [
	self visitAnnotation: aPackageAnnotation.
	self styleName: aPackageAnnotation.
	self styleTag: aPackageAnnotation.
	self
		styleButton: aPackageAnnotation
		for: aPackageAnnotation
		defaultLabel: #packageAndTagName
		withTool: [ aPackageAnnotation imageObject gtSpawnCoder ].
	self
		styleExpandingObject: aPackageAnnotation
		withDefault: LepiterConstants defaultPackageShowSelector
]

{ #category : #generated }
LeAnnotationStylerVisitor >> visitPackageNameArgument: aPackageNameArgument [
	^ self visitNameArgument: aPackageNameArgument
]

{ #category : #visiting }
LeAnnotationStylerVisitor >> visitPageAnnotation: aPageAnnotation [
	| linkText |

	self visitAnnotation: aPageAnnotation.
	linkText := self text
		from: aPageAnnotation parent startPosition
		to: aPageAnnotation parent stopPosition.
	self styleLinkButton: aPageAnnotation text: linkText.

]

{ #category : #visiting }
LeAnnotationStylerVisitor >> visitTodoAnnotation: aTodoAnnotation [
	self visitAnnotation: aTodoAnnotation.
	(self text from: aTodoAnnotation parent startPosition to: aTodoAnnotation parent stopPosition)
		appendingAdornment:
			[ :aTBrTextEditorTextualPiece :anEditorElement | 
			| checkbox |
			checkbox := (BrCheckbox new)
				margin: (BlInsets top: 3 left: 2);
				aptitude: BrGlamorousCheckboxAptitude;
				checked: aTodoAnnotation isCompleted;
				whenCheckedDo: [ self markCompleted: aTodoAnnotation ];
				whenUncheckedDo: [ self markUncompleted: aTodoAnnotation ];
				beSmallSize.
			aTodoAnnotation label
				ifNil: [ checkbox ]
				ifNotNil:
					[ :text | 
					| button |
					button := BrButton new.
					button
						addAptitude:
								((BrGlamorousButtonLabelAptitude new)
										defaultColor: BrGlamorousColors textMarkupColor;
										hoveredColor: BrGlamorousColors textMarkupColor muchDarker);
						padding: aTBrTextEditorTextualPiece wordPadding;
						margin: (BlInsets top: -1) + aTBrTextEditorTextualPiece wordMargin;
						layout: BlLinearLayout horizontal;
						fitContent;
						label: text.
					button action: [ :aButton | checkbox checked: checkbox isChecked not ].
					(BrHorizontalPane new)
						margin: (BlInsets top: -1);
						fitContent;
						addChild: checkbox;
						addChild: button ] ]
]
