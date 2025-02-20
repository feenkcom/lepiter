Class {
	#name : #LeJenkinsSnippetElement,
	#superclass : #LeSnippetElement,
	#traits : 'TLeWithJenkinsSnippetViewModel',
	#classTraits : 'TLeWithJenkinsSnippetViewModel classTrait',
	#instVars : [
		'contentElement',
		'urlInputElement',
		'userInputElement',
		'tokenInputElement',
		'resultContainer',
		'formElement',
		'toolbar',
		'showFormToggle'
	],
	#category : #'Lepiter-Snippet-Jenkins-View-Element'
}

{ #category : #accessing }
LeJenkinsSnippetElement >> addInspectResultToContainer: anObject [ 
	resultContainer removeChildNamed:  #jenkinsResult.
	resultContainer addChild: ((GtPhlowTool default object: anObject) asElement) as: #jenkinsResult.
]

{ #category : #accessing }
LeJenkinsSnippetElement >> addInspectResultToContainer: anObject spawnObject: anObject1 [ 
]

{ #category : #accessing }
LeJenkinsSnippetElement >> contentElement [
	^ contentElement
]

{ #category : #accessing }
LeJenkinsSnippetElement >> createFormElement [
	| formElement jenkinsAccount |
	formElement := BlElement new.
	formElement
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ].
	formElement
		layout:
			(BlGridLayout horizontal
				columnCount: 2;
				cellSpacing: 10).
		urlInputElement := self inputElementNamed: 'Url' in: formElement.
	userInputElement := self inputElementNamed: 'User' in: formElement.
	tokenInputElement := self inputElementNamed: 'Token' in: formElement.
	
	tokenInputElement editor text replacingText: $*.
	jenkinsAccount := GtJenkinsUserIdentity instance jenkinsAccount.
	jenkinsAccount
		ifNotNil: [ userInputElement text: jenkinsAccount username.
			urlInputElement text: ''.
			tokenInputElement text: jenkinsAccount token.
			tokenInputElement editor text replacingText: $* ].
	^ formElement
]

{ #category : #accessing }
LeJenkinsSnippetElement >> createInspectButtonToolbar [
	| playInspectButton tb result |
	tb := BrToolbar new
			aptitude: BrToolbarAptitude new;
			layout: (BlGridLayout horizontal
					rowCount: 1;
					cellSpacing: 10);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].
	playInspectButton := BrButton new.
	playInspectButton
		beSmallSize;
		aptitude: BrGlamorousButtonWithIconAptitude;
		label: 'Inspect connection';
		icon: BrGlamorousVectorIcons playinspect;
		action: [ | client username tokenString urlString |
			username := userInputElement editor text asString.
			tokenString := tokenInputElement editor text asString.
			urlString := urlInputElement editor text asString.
			self
				storeJenkinsAccountToPreferencesFolderWith: username
				token: tokenString
				andUrl: urlString.
			client := JcJenkinsClient new
					username: username
					token: tokenString
					url: urlString.
			client hasValidUrl
				ifTrue: [ [ result := client blueOcean.
					playInspectButton phlow spawnObject: result ]
						on: KeyNotFound
						do: [ playInspectButton phlow spawnObject: client plainJenkinsApi ] ] ].
	tb addItem: playInspectButton.
	^ tb
]

{ #category : #accessing }
LeJenkinsSnippetElement >> createResultContainer [
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 300 ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets top: 5 left: 7 bottom: 5 right: 5);
		addAptitude: (BrGlamorousWithVerticalResizerAptitude new beBottom);
		yourself
]

{ #category : #accessing }
LeJenkinsSnippetElement >> createShowFormToggleButton [
	^ BrToggle new
		beSmallSize;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignBottom ];
		margin: (BlInsets all: 15);
		padding: (BlInsets all: 10);
		zIndex: 10;
		aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousToggleBackgroundAptitude;
		icon: BrGlamorousIcons hamburger asElement;
		label: 'Form' asString;
		when: BrToggleActivatedEvent
			do: [ :anEvent | self snippetViewModel showForm ];
		when: BrToggleDeactivatedEvent
			do: [ :anEvent | self snippetViewModel hideForm ];
		yourself
]

{ #category : #accessing }
LeJenkinsSnippetElement >> initialize [
	super initialize.
	contentElement := BrVerticalPane new.
	formElement := self createFormElement.
	toolbar := self createInspectButtonToolbar.
"	resultContainer := self createResultContainer.
"	contentElement
		vFitContent;
		hMatchParent.
"	contentElement addChild: resultContainer."
	contentElement addChild: formElement.
	contentElement addChild: toolbar.
	showFormToggle := self createShowFormToggleButton.
	contentElement addChild: showFormToggle.
]

{ #category : #accessing }
LeJenkinsSnippetElement >> inputElementNamed: aString in: aFormElement [
	| labelElement inputElement |
	labelElement := BrLabel new text: aString, ':'; aptitude: BrGlamorousLabelAptitude.
	labelElement constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent.
		c grid vertical alignCenter ].
	
	inputElement := BrEditor new
				hMatchParent;
				vFitContentLimited;
				aptitude: BrGlamorousInputFieldSpacingAptitude new + BrGlamorousRegularEditorAptitude new;
				text: ''.
	
	aFormElement addChild: labelElement.
	aFormElement addChild: inputElement.
	^ inputElement
]

{ #category : #'api - jenkins snippet view model' }
LeJenkinsSnippetElement >> onJenkinsSnippetViewModelChanged [
	"Is sent when a new jenkinsSnippet view model is assigned to the element"
	
	| username tokenString urlString client |
	urlInputElement text: self jenkinsSnippetViewModel jenkinsUrl.
	username := userInputElement editor text asString.
	tokenString := tokenInputElement editor text asString.
	urlString := urlInputElement editor text asString.
	(tokenString size > 0 and: [username size > 0  ]) ifTrue: [
		client := JcJenkinsClient new
				username: username
				token: tokenString
				url: urlInputElement editor text asString.
		"client hasValidUrl ifTrue: [
			self addInspectResultToContainer: client blueOcean]"].
	
]

{ #category : #accessing }
LeJenkinsSnippetElement >> onSnippetViewModelChanged [ 
	super onSnippetViewModelChanged.
	self jenkinsSnippetViewModel: self snippetViewModel.
	self updateFormVisibility.
]

{ #category : #accessing }
LeJenkinsSnippetElement >> onSnippetViewModelFocused: aBoolean [
	aBoolean 
		ifTrue: [ showFormToggle visibility: BlVisibility visible ]
		ifFalse: [ showFormToggle visibility: BlVisibility gone ]
]

{ #category : #accessing }
LeJenkinsSnippetElement >> snippetContent [
	^ contentElement
]

{ #category : #accessing }
LeJenkinsSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ nil
]

{ #category : #accessing }
LeJenkinsSnippetElement >> storeJenkinsAccountToPreferencesFolderWith: username token: tokenString andUrl: aJenkinsUrl [
	GtJenkinsUserIdentity instance 
		jenkinsAccount: (GtJenkinsAccount new 
			username:username; 
			token: tokenString).
	self jenkinsSnippetViewModel jenkinsUrl: aJenkinsUrl.
	GtJenkinsUserIdentity instance storeAuthTokens.
]

{ #category : #'api - jenkins snippet view model' }
LeJenkinsSnippetElement >> subscribeToJenkinsSnippetViewModel [
	"Is sent after a new jenkinsSnippet view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromJenkinsSnippetViewModel if elements subscribe to them"

	self snippetViewModel weak
		when: LeJenkinsSnippetShowFormAnnouncement
		send: #updateFormVisibility
		to: self
]

{ #category : #'api - jenkins snippet view model' }
LeJenkinsSnippetElement >> unsubscribeFromJenkinsSnippetViewModel [
	"Is sent before a new jenkinsSnippet view model is assigned to the element.
	Elements that subscribe to jenkinsSnippet view model in domain model are required to implement this methods"
	
	self snippetViewModel unsubscribe: self
]

{ #category : #'api - jenkins snippet view model' }
LeJenkinsSnippetElement >> updateFormVisibility [
	^ self snippetViewModel shouldShowForm
		ifTrue: [ toolbar visibility: BlVisibility visible.
			formElement visibility: BlVisibility visible ]
		ifFalse: [ toolbar visibility: BlVisibility gone.
			formElement visibility: BlVisibility gone ]
]
