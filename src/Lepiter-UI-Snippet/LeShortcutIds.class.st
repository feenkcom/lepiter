Class {
	#name : #LeShortcutIds,
	#superclass : #BlShortcutIds,
	#instVars : [
		'moveSnippetUpShortcutId',
		'splitSnippetShortcutId'
	],
	#category : 'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #initialization }
LeShortcutIds >> initialize [ 
	super initialize.
	
	moveSnippetUpShortcutId := BlShortcutId  identifier: #MoveSnippetUp.
	splitSnippetShortcutId := BlShortcutId  identifier:  #SplitSnippet.
	
]

{ #category : #ids }
LeShortcutIds >> moveSnippetUpShortcutId [
	^ moveSnippetUpShortcutId
]

{ #category : #ids }
LeShortcutIds >> splitSnippetShortcutId [
	^ splitSnippetShortcutId
]
