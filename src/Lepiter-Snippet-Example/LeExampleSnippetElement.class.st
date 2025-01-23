Class {
	#name : #LeExampleSnippetElement,
	#superclass : #LeSnippetElement,
	#traits : 'TBlElementError',
	#classTraits : 'TBlElementError classTrait',
	#instVars : [
		'exampleContainer',
		'exampleEditor',
		'toolbarContainer',
		'browseExampleButton',
		'runExampleButton',
		'exportExampleButton',
		'mutexPreviewComputation'
	],
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #'private - event handling' }
LeExampleSnippetElement >> browseExample [
	self snippetViewModel gtExampleDo: [ :aGtExample |
		self phlow spawnTool: (GtMethodCoderTool compiledMethod: aGtExample method) ]
]

{ #category : #'private - updating' }
LeExampleSnippetElement >> computeExamplePreviewElement [
	<return: #BlElement>
	| anElement |
	self snippetViewModel
		cachedExamplePreviewDo: [ :aCachedComputedPreview | 
			self
				assert: [ aCachedComputedPreview element isNotNil ]
				description: [ 'Cached example preview element must be non-nil.' ].

			^ aCachedComputedPreview ].

	self snippetViewModel
		gtExampleDo: [ :aGtExample | 
			anElement := LeExampleSnippetComputedPreview new
					example: aGtExample;
					element: (GtExamplePreviewStencil new
							example: aGtExample asCachedExampleWithResult;
							codeExpanded: self snippetViewModel codeExpanded;
							noCode: self snippetViewModel noCode;
							previewExpanded: self snippetViewModel previewExpanded;
							previewShowSelector: self snippetViewModel previewShowSelector;
							previewSelectSelector: self snippetViewModel previewSelectSelector;
							previewHeight: self snippetViewModel previewHeight;
							asElement) ]
		ifAbsent: [ anElement := LeExampleSnippetNoPreview new
					element: (BrHorizontalPane new
							hMatchParent;
							vExact: self snippetViewModel previewHeight;
							geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
							alignCenter;
							background: self theme default backdropColor;
							addChild: (BrLabel new
									aptitude: (BrGlamorousLabelAptitude new light foreground: Color veryDarkGray);
									text: 'Example not found')) ].

	self snippetViewModel cacheExamplePreview: anElement.
	^ anElement
]

{ #category : #'private - updating' }
LeExampleSnippetElement >> criticalComputeExamplePreviewElement [
	<return: #BlElement>
	^ mutexPreviewComputation critical: [ self computeExamplePreviewElement ]
]

{ #category : #'private - event handling' }
LeExampleSnippetElement >> exportExample [

	self snippetViewModel gtExampleDo: [ :aGtExample | 
		exampleContainer
			childNamed: #example
			ifFound: [ :anExampleElement | 
				anExampleElement
					childNamed: #preview
					ifFound: [ :aPreviewElement | 
						| aFileName aQuery aQueryVisibility |
						aQuery := aPreviewElement parent query / BrResizer.
						aQueryVisibility := aQuery all collect: [ :eachElement | 
							                    eachElement visibility ].
						aQuery all do: [ :eachElement | 
							eachElement visibility: BlVisibility hidden ].
						exportExampleButton disable.

						aFileName := GtFileUtility
							             secureFileName:
								             aGtExample providerClass name , '_'
								             , aGtExample selector asString , '_'
								             ,
								             self snippetViewModel previewShowSelector
									             asString
							             extension: 'png'
							             maxLength: 72.

						aFileName asFileReference ensureDelete.

						self enqueueTask: (BlTaskAction new action: [ 
								 BlExporter png
									 element: anExampleElement;
									 scaled: 2;
									 fileName: aFileName;
									 export.

								 aQuery all doWithIndex: [ :eachElement :eachIndex | 
									 eachElement visibility: (aQueryVisibility at: eachIndex) ].
								 exportExampleButton enable ]) ] ] ]
]

{ #category : #initialization }
LeExampleSnippetElement >> initialize [
	super initialize.
	
	mutexPreviewComputation := Mutex new.
	
	exampleContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets top: 5 left: 7 bottom: 5 right: 5);
		yourself.	
	
	exampleEditor := GtTextualCoderEditorElement new
		hMatchParent;
		vFitContent;
		aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousEditorSpacingAptitude;
		padding: (BlInsets top: 2 left: 3 bottom: 2 right: 3);
		margin: (BlInsets left: 2 right: 2).
		
	LeSnippetEditorElementShortcuter new
		editor: exampleEditor;
		indent;
		moveUpAndDown;
		loseFocus.
	
	exampleEditor editor 
		addEventHandler: (LeEditorReachedBorderEventHandler new 
			snippetElement: self);
		ensureNoUndoRedoShortcuts.
	
	browseExampleButton := BrButton new
		beSmallSize;
		disable;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons browse;
		label: 'Browse example code';
		margin: (BlInsets top: 1 left: 4 bottom: 0 right: 3);
		action: [ self browseExample ].

	runExampleButton := BrButton new
		beSmallSize;
		disable;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons playinspect;
		label: 'Play and inspect example result';
		margin: (BlInsets top: 1 left: 4 bottom: 0 right: 3);
		action: [ self runExample ].
	
	exportExampleButton := BrButton new
		beSmallSize;
		disable;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousIcons save;
		label: 'Export example preview to a file';
		margin: (BlInsets top: 1 left: 4 bottom: 0 right: 3);
		action: [ self exportExample ].
		
	toolbarContainer := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		padding: (BlInsets top: 0 left: 3 bottom: 2 right: 3);
		addChildren: { 
			BrLabel new
				margin: (BlInsets top: 1);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
				text: '{{gtExample:'.
			exampleEditor.
			BrLabel new
				margin: (BlInsets top: 1);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
				text: '}}'.
			browseExampleButton.
			exportExampleButton.
			runExampleButton }.
	
	self initializeAsyncFuture
]

{ #category : #initialization }
LeExampleSnippetElement >> initializeAsyncFuture [
	self
		withAsyncFutureDo: [ :anElementFuture | 
			anElementFuture
				whenPending: [ :theContainer | self updateExamplePreviewWithRendingElement ];
				whenError: [ :theContainer :anError | self updateExamplePreviewWithError: anError ];
				whenSuccess: [ :theContainer :aComputedExamplePreview | self updateExamplePreviewWithPreview: aComputedExamplePreview ] ]
]

{ #category : #'private - event handling' }
LeExampleSnippetElement >> onExampleSnippetContentChanged [
	self enqueueTask: (BlTaskAction new action: [ self requestExamplePreviewUpdate ])
]

{ #category : #'api - snippet view model' }
LeExampleSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	self requestExamplePreviewUpdate
]

{ #category : #'api - snippet view model' }
LeExampleSnippetElement >> onSnippetViewModelFocused: aBoolean [
	"Override me to either request or lose focus when the focused state is changed in the UI Model"

	(aBoolean and: [ self snippetViewModel annotationCoderViewModel focused not ])
		ifTrue: [ self requestFocus ].

	aBoolean
		ifFalse: [ self loseFocus ]
]

{ #category : #'private - updating' }
LeExampleSnippetElement >> requestExamplePreviewUpdate [
	"I must be executed in a UI process."

	self
		withAsyncFutureDo: [ :anElementFuture | anElementFuture future: [ self criticalComputeExamplePreviewElement ] ]
]

{ #category : #'private - event handling' }
LeExampleSnippetElement >> runExample [
	self snippetViewModel gtExampleDo: [ :aGtExample |
		self phlow spawnObject: aGtExample run returnValue ]
]

{ #category : #'api - view' }
LeExampleSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ exampleContainer
]

{ #category : #'api - view' }
LeExampleSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ toolbarContainer
]

{ #category : #'api - snippet view model' }
LeExampleSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.
	
	self snippetViewModel weak
		when: LeExampleSnippetContentChanged, LeExampleSnippetViewModelExampleChanged
			send: #onExampleSnippetContentChanged
			to: self
]

{ #category : #'private - updating' }
LeExampleSnippetElement >> updateExamplePreviewWithError: anError [
	"I must be executed in a UI process."

	self snippetViewModel clearCachedExamplePreview.
	exportExampleButton disable.

	exampleContainer removeChildNamed: #example.
	exampleContainer addChild: anError asDebuggableElement as: #example
]

{ #category : #'private - updating' }
LeExampleSnippetElement >> updateExamplePreviewWithPreview: aComputedExamplePreview [
	"I must be executed in a UI process."

	self snippetViewModel
		cachedExamplePreviewDo: [ :aCachedComputedPreview | aCachedComputedPreview == aComputedExamplePreview ifFalse: [ ^ self ] ]
		ifAbsent: [ ^ self ].

	exampleEditor
		textualCoderViewModel: self snippetViewModel annotationCoderViewModel.

	aComputedExamplePreview hasExamplePreview
		ifTrue: [ exportExampleButton enable ]
		ifFalse: [ exportExampleButton disable ].

	aComputedExamplePreview hasExample
		ifTrue: [ browseExampleButton enable.
			runExampleButton enable ]
		ifFalse: [ browseExampleButton disable.
			runExampleButton disable ].

	(aComputedExamplePreview hasElement
		and: [ aComputedExamplePreview element parent = exampleContainer ])
		ifTrue: [ ^ self ].

	exampleContainer removeChildNamed: #example.
	aComputedExamplePreview hasElement
		ifTrue: [ "self
				assert: [ aComputedExamplePreview element isAttachedToSceneGraph not ]
				description: [ 'Cached example preview element must be detached from a scene graph.' ]."

			aComputedExamplePreview element removeFromParent.
			exampleContainer addChild: aComputedExamplePreview element as: #example ]
]

{ #category : #'private - updating' }
LeExampleSnippetElement >> updateExamplePreviewWithRendingElement [
	| anElement |
	self snippetViewModel
		cachedExamplePreviewDo: [ :aCachedComputedPreview | ^ self ].

	exportExampleButton disable.

	self snippetViewModel
		gtExampleDo: [ :aGtExample | 
			browseExampleButton enable.
			runExampleButton enable ]
		ifAbsent: [ browseExampleButton disable.
			runExampleButton disable ].

	exampleEditor
		textualCoderViewModel: self snippetViewModel annotationCoderViewModel.

	anElement := BrHorizontalPane new
			hMatchParent;
			vExact: self snippetViewModel previewHeight;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			alignCenter;
			addChild: (BrLabel new
					aptitude: (BrGlamorousLabelAptitude new light foreground: Color veryDarkGray);
					text: 'Rendering...').

	exampleContainer removeChildNamed: #example.
	exampleContainer addChild: anElement as: #example
]
