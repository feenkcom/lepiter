Class {
	#name : #LeGithubIssueViewModel,
	#superclass : #LeGitHubSnippetViewModel,
	#category : 'Lepiter-GitHub-UI Snippet View Models'
}

{ #category : #'api - actions' }
LeGithubIssueViewModel >> browseIssueWebsite [

	| aString |
	aString := self snippetModel htmlUrl.
	WebBrowser openOn: aString.
	^ aString 
]

{ #category : #'api - actions' }
LeGithubIssueViewModel >> copyIssueIdIntoClipboard [

	| aString |
	aString := self snippetModel longIdentificator.
	Clipboard clipboardText: aString.
	^ aString 
]

{ #category : #'gt - extensions' }
LeGithubIssueViewModel >> gtBrowseIssueWebsiteFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Browse Issue Website';
		icon: BrGlamorousVectorIcons link ;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 21;
		action: [ :aButton :aSnippetElement | self browseIssueWebsite ]
]

{ #category : #'gt - extensions' }
LeGithubIssueViewModel >> gtCopyIssueIdentificatorIntoClipboardFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Copy Issue ID Into Clipboard';
		icon: BrGlamorousVectorIcons clipboard;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 20;
		action: [ :aButton :aSnippetElement | self copyIssueIdIntoClipboard ]
]

{ #category : #accessing }
LeGithubIssueViewModel >> snippetElementClass [
	^ LeGitHubIssueSnippetElement
]
