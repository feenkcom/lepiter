"
I exemplify how displayed example snippet elements subscribe to the system announcer while they are in a scene graph, and that example snippet models do not.
I use a temporary class from a {{gtClass:GtPharoDummyEnvironment}} with a single example method, which I modify to trigger system announcements.
"
Class {
	#name : #LeExampleSnippetSystemSubscriptionExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'Lepiter-Snippet-Example-Examples'
}

{ #category : #cleanup }
LeExampleSnippetSystemSubscriptionExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ].
	environment := nil
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> compileTemporaryClassSideExampleReturning: aNumber [
	self
		compileTemporaryExampleReturning: aNumber
		in: self temporaryClass classSide
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> compileTemporaryExampleReturning: aNumber [
	self compileTemporaryExampleReturning: aNumber in: self temporaryClass
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> compileTemporaryExampleReturning: aNumber in: aBehavior [
	GtPharoCodeModifier
		compileMethodSource: (self temporaryExampleSourceReturning: aNumber)
		in: aBehavior
		protocol: #examples
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> dummyEnvironment [
	^ environment
		ifNil: [ environment := GtPharoDummyEnvironment withPackages: 1 classes: 1 ]
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> isNotFoundPreviewCurrentAndDisplayedIn: anExampleSnippetElement [
	| aPreview |
	anExampleSnippetElement snippetViewModel
		cachedExamplePreviewDo: [ :eachPreview | aPreview := eachPreview ].
	^ aPreview notNil
		and: [ aPreview hasExample not
				and: [ self isPreviewCurrentAndDisplayedIn: anExampleSnippetElement ] ]
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> isPreviewCurrentAndDisplayedIn: anExampleSnippetElement [
	"Return true if the displayed preview was computed for the current fingerprint
	(snippet settings and version of the referenced example method)"

	| aViewModel aPreview |
	aViewModel := anExampleSnippetElement snippetViewModel.
	aViewModel cachedExamplePreviewDo: [ :eachPreview | aPreview := eachPreview ].
	aPreview ifNil: [ ^ false ].
	^ aViewModel isCachedExamplePreviewCurrent
		and: [ aPreview element hasParent: anExampleSnippetElement ]
]

{ #category : #'examples - model' }
LeExampleSnippetSystemSubscriptionExamples >> modifyTemporaryExampleWithoutDisplayedSnippet [
	<gtExample>
	<after: #cleanUp>
	<return: #LePage>
	| aPage theAnnouncements |
	aPage := self pageWithTemporaryExampleSnippet.
	theAnnouncements := OrderedCollection new.
	aPage database weak
		when: LeSnippetContentChanged
		send: #add:
		to: theAnnouncements.
	self compileTemporaryExampleReturning: 43.
	self assert: theAnnouncements isEmpty.
	^ aPage
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> pageWithExampleSnippetReferencing: aBehaviorName [
	| aDatabase aPage aSnippet |
	aDatabase := LeDatabase new.
	aPage := LePage named: 'Example snippet system subscription'.
	aDatabase addPage: aPage.
	aSnippet := LeExampleSnippet new
			exampleBehaviorName: aBehaviorName;
			exampleSelector: self temporaryExampleSelector;
			noCode: true;
			yourself.
	aPage addSnippet: aSnippet.
	self assert: (self systemSubscriptionsCountOf: aSnippet) equals: 0.
	^ aPage
]

{ #category : #'examples - model' }
LeExampleSnippetSystemSubscriptionExamples >> pageWithTemporaryClassSideExampleSnippet [
	<gtExample>
	<after: #cleanUp>
	<return: #LePage>
	self compileTemporaryClassSideExampleReturning: 42.
	^ self pageWithExampleSnippetReferencing: self temporaryClass name , ' class'
]

{ #category : #'examples - model' }
LeExampleSnippetSystemSubscriptionExamples >> pageWithTemporaryExampleSnippet [
	<gtExample>
	<after: #cleanUp>
	<return: #LePage>
	self compileTemporaryExampleReturning: 42.
	^ self pageWithExampleSnippetReferencing: self temporaryClass name
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> scripterForPage: aPageBlock [
	| aScripter |
	aScripter := BlScripter new.
	aScripter
		substep: 'Initialize model and UI'
		do: [ :aStep | 
			aStep set
				label: 'Initialize a page with an example snippet';
				model: aPageBlock;
				play.
			aStep set
				label: 'Initialize the page element';
				element: [ :aPage | 
					LePageToolContentTreeElement new
						pageViewModel: aPage asContentUIModel;
						matchParent ];
				onModel;
				play ].
	aScripter set
		label: 'Remember the example snippet element';
		key: #exampleElement value: [ :anElement | anElement ];
		// LeExampleSnippetElement;
		play.
	aScripter set
		label: 'Remember the parent of the example snippet element';
		key: #exampleElementParent value: [ :anElement | anElement parent ];
		// LeExampleSnippetElement;
		play.
	aScripter assert
		label: 'Displayed example snippet element has one system subscription';
		// LeExampleSnippetElement;
		value: [ :anElement | self systemSubscriptionsCountOf: anElement ] equals: 1;
		play.
	aScripter assert
		label: 'Example snippet model has no system subscription';
		// LeExampleSnippetElement;
		value: [ :anElement | self systemSubscriptionsCountOf: anElement snippetViewModel snippetModel ]
			equals: 0;
		play.
	aScripter assert
		label: 'Example preview is computed and displayed';
		// LeExampleSnippetElement;
		satisfies: [ :anElement | self isPreviewCurrentAndDisplayedIn: anElement ];
		play.
	^ aScripter
]

{ #category : #'examples - scripter' }
LeExampleSnippetSystemSubscriptionExamples >> scripterWithTemporaryClassSideExampleSnippet [
	<gtExample>
	<after: #cleanUp>
	<return: #BlScripter>
	^ self scripterForPage: [ self pageWithTemporaryClassSideExampleSnippet ]
]

{ #category : #'examples - scripter' }
LeExampleSnippetSystemSubscriptionExamples >> scripterWithTemporaryClassSideExampleSnippet_removeExampleClass [
	<gtExample>
	<after: #cleanUp>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithTemporaryClassSideExampleSnippet.
	aScripter do
		label: 'Remove the class of the referenced class-side example';
		action: [ :aTarget | self cleanUp ];
		play.
	aScripter assert
		label: 'Class-side preview is recomputed and shows that the example is not found';
		// LeExampleSnippetElement;
		satisfies: [ :anElement | self isNotFoundPreviewCurrentAndDisplayedIn: anElement ];
		play.
	^ aScripter
]

{ #category : #'examples - scripter' }
LeExampleSnippetSystemSubscriptionExamples >> scripterWithTemporaryExampleSnippet [
	<gtExample>
	<after: #cleanUp>
	<return: #BlScripter>
	^ self scripterForPage: [ self pageWithTemporaryExampleSnippet ]
]

{ #category : #'examples - scripter' }
LeExampleSnippetSystemSubscriptionExamples >> scripterWithTemporaryExampleSnippet_addElementBack [
	<gtExample>
	<after: #cleanUp>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithTemporaryExampleSnippet_removeElement.
	aScripter do
		label: 'Add the example snippet element back';
		action: [ :aTarget :aUserData | (aUserData at: #exampleElementParent) addChild: (aUserData at: #exampleElement) ];
		play.
	aScripter assert
		label: 'Example snippet element has again one system subscription';
		// LeExampleSnippetElement;
		value: [ :anElement | self systemSubscriptionsCountOf: anElement ] equals: 1;
		play.
	^ aScripter
]

{ #category : #'examples - scripter' }
LeExampleSnippetSystemSubscriptionExamples >> scripterWithTemporaryExampleSnippet_modifyExample [
	<gtExample>
	<after: #cleanUp>
	<return: #BlScripter>
	| aScripter theAnnouncements |
	aScripter := self scripterWithTemporaryExampleSnippet.
	theAnnouncements := OrderedCollection new.
	aScripter do
		label: 'Collect snippet content changes announced to the database';
		action: [ :aTarget :aUserData | 
			(aUserData at: #exampleElement) snippetViewModel snippetModel page database weak
				when: LeSnippetContentChanged
				send: #add:
				to: theAnnouncements ];
		play.
	aScripter do
		label: 'Modify the referenced example method';
		action: [ :aTarget | self compileTemporaryExampleReturning: 43 ];
		play.
	aScripter assert
		label: 'Preview of the modified example method is displayed';
		// LeExampleSnippetElement;
		satisfies: [ :anElement | self isPreviewCurrentAndDisplayedIn: anElement ];
		play.
	aScripter assert
		label: 'A displayed snippet does not announce content changes to the database';
		value: [ :aTarget | theAnnouncements size ] equals: 0;
		play.
	^ aScripter
]

{ #category : #'examples - scripter' }
LeExampleSnippetSystemSubscriptionExamples >> scripterWithTemporaryExampleSnippet_modifyExampleWhileRemoved [
	<gtExample>
	<after: #cleanUp>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithTemporaryExampleSnippet_removeElement.
	aScripter do
		label: 'Modify the referenced example method while the element is removed';
		action: [ :aTarget | self compileTemporaryExampleReturning: 44 ];
		play.
	aScripter assert
		label: 'Cached preview is outdated, since nobody listened';
		value: [ :aTarget :aUserData | (aUserData at: #exampleElement) snippetViewModel isCachedExamplePreviewOutdated ]
			equals: true;
		play.
	aScripter do
		label: 'Add the example snippet element back';
		action: [ :aTarget :aUserData | (aUserData at: #exampleElementParent) addChild: (aUserData at: #exampleElement) ];
		play.
	aScripter assert
		label: 'Example preview catches up with the modification';
		// LeExampleSnippetElement;
		satisfies: [ :anElement | self isPreviewCurrentAndDisplayedIn: anElement ];
		play.
	^ aScripter
]

{ #category : #'examples - scripter' }
LeExampleSnippetSystemSubscriptionExamples >> scripterWithTemporaryExampleSnippet_removeElement [
	<gtExample>
	<after: #cleanUp>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithTemporaryExampleSnippet.
	aScripter do
		label: 'Remove the example snippet element from the scene graph';
		action: [ :aTarget :aUserData | (aUserData at: #exampleElement) removeFromParent ];
		play.
	aScripter assert
		label: 'Removed example snippet element has no system subscription';
		value: [ :aTarget :aUserData | self systemSubscriptionsCountOf: (aUserData at: #exampleElement) ]
			equals: 0;
		play.
	^ aScripter
]

{ #category : #'examples - scripter' }
LeExampleSnippetSystemSubscriptionExamples >> scripterWithTemporaryExampleSnippet_removeExampleClass [
	<gtExample>
	<after: #cleanUp>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripterWithTemporaryExampleSnippet.
	aScripter do
		label: 'Remove the class of the referenced example';
		action: [ :aTarget | self cleanUp ];
		play.
	aScripter assert
		label: 'Preview is recomputed and shows that the example is not found';
		// LeExampleSnippetElement;
		satisfies: [ :anElement | self isNotFoundPreviewCurrentAndDisplayedIn: anElement ];
		play.
	^ aScripter
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> systemSubscriptionsCountOf: anObject [
	| aCount |
	aCount := 0.
	SystemAnnouncer uniqueInstance subscriptions
		subscriptionsOf: anObject
		do: [ :eachSubscription | aCount := aCount + 1 ].
	^ aCount
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> temporaryClass [
	^ self dummyEnvironment anyDummyClass realClass
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> temporaryExampleSelector [
	^ #temporaryExample
]

{ #category : #private }
LeExampleSnippetSystemSubscriptionExamples >> temporaryExampleSourceReturning: aNumber [
	^ String
		streamContents: [ :aStream | 
			aStream
				nextPutAll: self temporaryExampleSelector;
				cr;
				tab;
				nextPutAll: '<gtExample>';
				cr;
				tab;
				nextPutAll: '^ ';
				print: aNumber ]
]
