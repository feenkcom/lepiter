Class {
	#name : #LeFileSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'contentElement',
		'form'
	],
	#category : #'Lepiter-Snippet-File'
}

{ #category : #accessing }
LeFileSnippetElement >> go [
	| file bindingName sharedBindings binding |
	file := form fileReference asFileReference.
	self snippetViewModel fileReference: file.
	bindingName := form bindingName.
	self snippetViewModel bindingName: bindingName.
	sharedBindings := self snippetViewModel snippetBindings.
	binding := sharedBindings bindingOf: bindingName asSymbol.
	binding value: file.
	^ file
]

{ #category : #initalization }
LeFileSnippetElement >> initialize [
	| formElement indicatorElement |
	super initialize.
	
	form := LeFileResourcePane new.
	form
		acceptAction: [ self go ];
		inspectAction: [ :model :element | element phlow spawnObject: self go ].
		
	formElement := form asElement margin: (BlInsets all: 10).
	formElement
		constraintsDo: [ :c | 
			c frame horizontal alignLeft.
			c frame vertical alignTop ].
	formElement hMatchParent.
	
	indicatorElement := self newIndicatorElement.
	indicatorElement constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignTop ].
		
	contentElement := BrFrame new
		hMatchParent;
		vFitContent;
		addChildren: { formElement. indicatorElement } 
]

{ #category : #accessing }
LeFileSnippetElement >> newFileSelection: fileReference [
	"self inform: 'Go: ' , fileReference pathString."
	form fileReference: fileReference pathString.
	self snippetViewModel fileReference: fileReference
]

{ #category : #accessing }
LeFileSnippetElement >> newIndicatorElement [
	| newIndicatorElement aptitude |
	
	aptitude := BrGlamorousWithExplicitDropdownAptitude
		handle: [
			BrButton new
				aptitude: BrGlamorousButtonRectangularAptitude 
								+ BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude;
				label: 'File';
				beSmallSize ]
		content: [ | fileBrowser |
			fileBrowser := BrFileSelector new margin: (BlInsets all: 5).
			fileBrowser buttonLabel: 'Select'.
			fileBrowser okAction: [ :filePath | 
				self newFileSelection: filePath.
				fileBrowser fireEvent: BrDropdownHideWish new ].
			fileBrowser fileFilterBlock: [ :aFileReference | true ].
			fileBrowser addAptitude: BrGlamorousPopoverResizableAptitude new.
			fileBrowser ].
			
	newIndicatorElement := BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude + aptitude - BrGlamorousButtonExteriorAptitude;
		label: 'File';
		beSmallSize;
		margin: (BlInsets top: 5 right: 5).
		
	^ newIndicatorElement
]

{ #category : #'api - snippet view model' }
LeFileSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	form
		fileReference: (self snippetViewModel fileReference
				ifNotNil: [ :fileReference | fileReference pathString ]).
	form bindingName: self snippetViewModel bindingName
]

{ #category : #accessing }
LeFileSnippetElement >> snippetContent [
	^ contentElement
]

{ #category : #accessing }
LeFileSnippetElement >> snippetToolbar [
	^ nil
]
