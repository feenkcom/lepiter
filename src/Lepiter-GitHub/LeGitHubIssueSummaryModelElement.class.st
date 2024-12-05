Class {
	#name : #LeGitHubIssueSummaryModelElement,
	#superclass : #LeGitHubModelElement,
	#instVars : [
		'titleElement',
		'bodyElement'
	],
	#category : #'Lepiter-GitHub-UI Model Elements'
}

{ #category : #'private - accessing' }
LeGitHubIssueSummaryModelElement >> bodyElement [
	<return: #BrEditor>
	^ bodyElement
]

{ #category : #'api - actions' }
LeGitHubIssueSummaryModelElement >> copyIssueIdIntoClipboard [
]

{ #category : #'gt - extensions' }
LeGitHubIssueSummaryModelElement >> gtCopyIssueIdentificatorIntoClipboardFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Copy Issue ID Into Clipboard';
		icon: BrGlamorousVectorIcons clipboard;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 20;
		action: [ :aButton :aSnippetElement | self copyIssueIdIntoClipboard ]
]

{ #category : #initialization }
LeGitHubIssueSummaryModelElement >> initialize [
	super initialize.
	self initializeTitleElement.
	self initializeBodyElement.
	
	self addChild: self titleElement as: #title.
	self addChild: self bodyElement as: #body.
	
	self addAptitude: (BrLayoutResizerAptitude new 
		anyToFitContent: self titleElement;
		hInherit: self bodyElement;
		vAnyToFitContent: self bodyElement).
]

{ #category : #initialization }
LeGitHubIssueSummaryModelElement >> initializeBodyElement [
	bodyElement := BrEditor new
			beReadOnlyWithSelection;
			aptitude: BrGlamorousRegularEditorAptitude;
			hMatchParent;
			vFitContentLimited
]

{ #category : #initialization }
LeGitHubIssueSummaryModelElement >> initializeIssueIdElement [
]

{ #category : #initialization }
LeGitHubIssueSummaryModelElement >> initializeTitleElement [
	titleElement := BrLabel new
		text: '';
		beLargeSize;
		aptitude: (BrGlamorousLabelAptitude new bold);
		fitContent.
]

{ #category : #'as yet unclassified' }
LeGitHubIssueSummaryModelElement >> snippetViewModel: anObject [
	super snippetViewModel: anObject.
	bodyElement
		styler: (LeSnippetStyler new snippetViewModel: self snippetViewModel)
]

{ #category : #'private - accessing' }
LeGitHubIssueSummaryModelElement >> titleElement [
	<return: #BrLabel>
	^ titleElement
]

{ #category : #'private - updating' }
LeGitHubIssueSummaryModelElement >> updateElement [
	
	super updateElement.
	self titleElement text: self model title.
	self bodyElement text: self model body.
]
