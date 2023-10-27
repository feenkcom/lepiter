Class {
	#name : #LePageDevScripterTarget,
	#superclass : #BlDevScripterCustomTarget,
	#category : #'Lepiter-UI-Scripter'
}

{ #category : #accessing }
LePageDevScripterTarget >> onFirstSnippet [
	self onSnippetAtIndex: 1
]

{ #category : #accessing }
LePageDevScripterTarget >> onFirstSnippetInPage [
	self onPageContent.
	self onSnippetsTree.
	self onFirstSnippet
]

{ #category : #accessing }
LePageDevScripterTarget >> onPageContent [
	self scripterStep // LePageToolContentTreeElement
]

{ #category : #accessing }
LePageDevScripterTarget >> onSnippetAtIndex: aSnippetIndex [
	self scripterStep 
		id: LeSnippetElementId index: aSnippetIndex
]

{ #category : #accessing }
LePageDevScripterTarget >> onSnippetsTree [
	self scripterStep // LePageSnippetsTreeElementId
]
