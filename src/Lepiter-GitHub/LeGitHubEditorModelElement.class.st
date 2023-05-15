Class {
	#name : #LeGitHubEditorModelElement,
	#superclass : #LeGitHubModelElement,
	#instVars : [
		'inputFieldsElement',
		'toolbarElement',
		'ownerEditor',
		'projectEditor',
		'errorLabel'
	],
	#category : #'Lepiter-GitHub-UI Model Elements'
}

{ #category : #initialization }
LeGitHubEditorModelElement >> defaultTitle [
	"Return a widget title that indicates to users what the element is about"
	<return: #String>
	^ self subclassResponsibility 
]

{ #category : #'private - accessing' }
LeGitHubEditorModelElement >> errorLabel [
	<return: #BrLabel>
	^ errorLabel
]

{ #category : #initialization }
LeGitHubEditorModelElement >> initialize [
	| aTitle |
	super initialize.
	
	aTitle := self newTitleElement.
	self initializeInputFieldsElement.
	self initializeToolbarElement.
	
	self addChild: aTitle as: #title.
	self addChild: self inputFieldsElement as: #inputFields.
	self addChild: self toolbarElement as: #toolbar.
	
	self addAptitude: (BrLayoutResizerAptitude new
		inherit: self inputFieldsElement;
		hInherit: self toolbarElement;
		vAnyToFitContent: self toolbarElement)
]

{ #category : #initialization }
LeGitHubEditorModelElement >> initializeInputFieldsElement [
	inputFieldsElement := BrHorizontalGrid new
		columnCount: 2.
	
	ownerEditor := self newInputNamed: self ownerFieldName onModificationDo: [ :anEvent |
			self onOwnerInputModified: anEvent ].
		
	projectEditor := self newInputNamed: self projectFieldName onModificationDo: [ :anEvent |
			self onProjectInputModified: anEvent ].
	
]

{ #category : #initialization }
LeGitHubEditorModelElement >> initializeToolbarElement [
	| anAcceptButton |
	toolbarElement := BrToolbar new
		aptitude: BrGlamorousToolbarAptitude;
		hMatchParent;
		vFitContent.
	
	anAcceptButton := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		label: 'Accept';
		action: [ :aButton | self onAcceptAction: aButton ];
		margin: (BlInsets top: 0 right: 0 bottom: 0 left: 0);
		constraintsDo: [ :c | c linear horizontal alignLeft ];
		fitContent.
		
	self toolbarElement addItem: anAcceptButton.
	
	errorLabel := BrLabel new
		id: LeGitHubErrorMessageElementId;
		aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors errorBackgroundColor);
		text: '';
		vFitContentLimited;
		vFitContent.
		
	self toolbarElement addItem: errorLabel
]

{ #category : #'private - accessing' }
LeGitHubEditorModelElement >> inputFieldsElement [
	<return: #BrHorizontalGrid>
	^ inputFieldsElement
]

{ #category : #'private - instance creation' }
LeGitHubEditorModelElement >> newInputNamed: aName onModificationDo: aModificationBlock [
	| aLabel anEditor |
	aLabel := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		text: aName;
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 0);
		constraintsDo: [ :c | c grid horizontal alignLeft ];
		fitContent.
	self inputFieldsElement addChild: aLabel.
	
	anEditor := BrEditor new
		id: (LeGitHubInputFieldId new name: aName);
		aptitude: BrGlamorousEditorAptitude + BrGlamorousInputFieldSpacingAptitude;
		inputFilter: BrTextEditorNoSpaceInputFilter new;
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 5);
		constraintsDo: [ :c | c grid horizontal alignLeft ];
		vFitContent;
		hMatchParent.
	
	anEditor editor
		when: BrTextEditorModifiedEvent
		do: aModificationBlock.
		
	self inputFieldsElement addChild: anEditor.
	
	^ anEditor.
]

{ #category : #'private - instance creation' }
LeGitHubEditorModelElement >> newTitleElement [
	^ BrLabel new
		text: self defaultTitle;
		beLargeSize;
		aptitude: (BrGlamorousLabelAptitude new bold);
		fitContent.
]

{ #category : #'private - event handling' }
LeGitHubEditorModelElement >> onAcceptAction: aButton [
	self updateErrorText: ''.
	[ 
		aButton disable.
		self model 
			clearResponse;
			responseFrom: self.
		self updateElement.
	 ] ensure: [ aButton enable ]
]

{ #category : #accessing }
LeGitHubEditorModelElement >> onConfigurationChanged: anAnnouncement [
	anAnnouncement source = self ifTrue: [ ^ self ].
	self enqueueTask: (BlTaskAction new action: [
		self updateInputFieldsElement ])
]

{ #category : #initialization }
LeGitHubEditorModelElement >> onOwnerInputModified: anEvent [
	self model ownerName: anEvent text asString source: self
]

{ #category : #initialization }
LeGitHubEditorModelElement >> onProjectInputModified: anEvent [ 
	self model projectName: anEvent text asString source: self
]

{ #category : #'private - accessing' }
LeGitHubEditorModelElement >> ownerEditor [
	<return: #BrEditor>
	^ ownerEditor
]

{ #category : #'private - constants' }
LeGitHubEditorModelElement >> ownerFieldName [
	^ 'Owner'
]

{ #category : #'private - accessing' }
LeGitHubEditorModelElement >> projectEditor [
	<return: #BrEditor>
	^ projectEditor
]

{ #category : #'private - constants' }
LeGitHubEditorModelElement >> projectFieldName [
	^ 'Project'
]

{ #category : #'private - subscriptions' }
LeGitHubEditorModelElement >> subscribeToModel [
	super subscribeToModel.
	self model weak
		when: LeGitHubModelConfigurationChangedAnnouncement 
		send: #onConfigurationChanged: 
		to: self
]

{ #category : #'private - accessing' }
LeGitHubEditorModelElement >> toolbarElement [
	<return: #BrToolbar>
	^ toolbarElement
]

{ #category : #'private - updating' }
LeGitHubEditorModelElement >> updateElement [
	super updateElement.
	self updateErrorText.
	self updateInputFieldsElement.
]

{ #category : #'private - updating' }
LeGitHubEditorModelElement >> updateErrorText [
	self model 
		ifError: [ self updateErrorText: self model response message ]
		otherwise: [ self updateErrorText: '' ]
]

{ #category : #'private - updating' }
LeGitHubEditorModelElement >> updateErrorText: aString [
	self errorLabel text: aString
]

{ #category : #'private - updating' }
LeGitHubEditorModelElement >> updateInputFieldsElement [
	self ownerEditor text: self model ownerName.
	self projectEditor text: self model projectName.
]
