"
I am playground using a Lepiter page.

"
Class {
	#name : #LePlayground,
	#superclass : #BlElement,
	#traits : 'TGtPagerWindowOpener',
	#classTraits : 'TGtPagerWindowOpener classTrait',
	#instVars : [
		'title',
		'titleNotifier'
	],
	#category : #'Lepiter-Playground'
}

{ #category : #'api - instantiation' }
LePlayground class >> create [
	^ self createOn: self newDefaultPage.
]

{ #category : #'api - instantiation' }
LePlayground class >> createWithNotePage [
	^ self createOn: self newDefaultNotePage
]

{ #category : #'api - instantiation' }
LePlayground class >> createWithNotePageInKnowledgeBase: aKnowledgeBase [
	^ self createOn: (self newDefaultNotePageInKnowledgeBase: aKnowledgeBase)
]

{ #category : #'api - instantiation' }
LePlayground class >> createWithPharoCodePageInKnowledgeBase: aKnowledgeBase [
	^ self createOn: (self newDefaultPharoCodePageInKnowledgeBase: aKnowledgeBase)
]

{ #category : #accessing }
LePlayground class >> defaultIcon [
	^ LeIcons lepiterPage
]

{ #category : #'window creation' }
LePlayground class >> newBasicEmptyNotePage [
	 ^ LePage unnamedPageWithDefaultTitle: 'Note'
]

{ #category : #'window creation' }
LePlayground class >> newBasicNotePage [
	| page |
	page := self newBasicEmptyNotePage.
	page addSnippet: LeTextSnippet new.
	^ page
]

{ #category : #'window creation' }
LePlayground class >> newBasicPharoCodePage [
	| page |
	page := LePage unnamedPageWithDefaultTitle: 'Playground'.
	page addSnippet: LePharoSnippet new.
	^ page
]

{ #category : #'window creation' }
LePlayground class >> newDefaultNotePage [
	^ self newDefaultNotePageInKnowledgeBase: LeDatabasesRegistry default 
		currentLoadedDefaultLogicalDatabase.
]

{ #category : #'window creation' }
LePlayground class >> newDefaultNotePageInKnowledgeBase: aKnowledgeBase [
	| page |
	page := self newBasicEmptyNotePage.
	aKnowledgeBase primaryDB addPage: page.
	
	"Add the initial snippet after the page is added to the database, 
	so that this is a normal snippet addition."
	page addSnippet: LeTextSnippet new.
	^ page
]

{ #category : #'window creation' }
LePlayground class >> newDefaultPage [
	^ self newDefaultPharoCodePage
]

{ #category : #'window creation' }
LePlayground class >> newDefaultPharoCodePage [
	^ self newDefaultPharoCodePageInKnowledgeBase: LeDatabasesRegistry default 
		currentLoadedDefaultLogicalDatabase.
]

{ #category : #'window creation' }
LePlayground class >> newDefaultPharoCodePageInKnowledgeBase: aKnowledgeBase [
	| page |
	page := self newBasicPharoCodePage.
	aKnowledgeBase playgroundDB addPage: page.
	^ page
]

{ #category : #'instance creation' }
LePlayground class >> newOn: aPage [
	"Create a playground element on the given page."
	^ self new page: aPage
]

{ #category : #'instance creation' }
LePlayground class >> newOnNotePage [
	^ self newOn: self newDefaultNotePage
]

{ #category : #'instance creation' }
LePlayground class >> newWithSnippets: snippets [
	self flag: #TODO
]

{ #category : #'window creation' }
LePlayground class >> open [
	^ self openOn: self newDefaultPage.
]

{ #category : #initialization }
LePlayground >> initialize [
	super initialize.
	self clipChildren: false.
	self
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	
	self beFocusable.
	self when: BlClickEvent do: [ self requestFocus ].
]

{ #category : #accessing }
LePlayground >> page: aPage [
	| toolElement |
	"self titleNotifier shortLabel: aPage title."
	
	toolElement := aPage asLepiterPagePhlowTool asElementDo: [ :e | e ].
	self "contentElement"
		removeChildren;
		addChild: toolElement.
]

{ #category : #opening }
LePlayground >> pagerWindowTitle [
	^ self title
]

{ #category : #accessing }
LePlayground >> title [
	^ title ifNil: [ 'Playground' ]
]

{ #category : #accessing }
LePlayground >> title: aString [
	title := aString
]
