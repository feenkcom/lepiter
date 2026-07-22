Class {
	#name : #LeShortcutIds,
	#superclass : #BlShortcutIds,
	#instVars : [
		'moveSnippetUpShortcutId',
		'splitSnippetShortcutId',
		'deleteNextShortcutId',
		'deletePreviousShortcutId',
		'indentSnippetShortcutId',
		'moveSnippetDownShortcutId',
		'renameSnippetShortcutId',
		'secondaryNewLineShortcutId',
		'unindentSnippetShortcutId'
	],
	#category : #'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeShortcutIds >> deleteNextShortcutId [
	^ deleteNextShortcutId
]

{ #category : #accessing }
LeShortcutIds >> deletePreviousShortcutId [
	^ deletePreviousShortcutId
]

{ #category : #accessing }
LeShortcutIds >> indentSnippetShortcutId [
	^ indentSnippetShortcutId
]

{ #category : #initialization }
LeShortcutIds >> initialize [ 
	super initialize.
	
	moveSnippetUpShortcutId := BlShortcutId  identifier: #MoveSnippetUp.
	moveSnippetDownShortcutId := BlShortcutId identifier: #MoveSnippetDown.
	
	indentSnippetShortcutId := BlShortcutId identifier: #IndentSnippet.
	unindentSnippetShortcutId := BlShortcutId identifier: #UnindentSnippet.
	
	deleteNextShortcutId := BlShortcutId identifier: #DeleteNext.
	deletePreviousShortcutId := BlShortcutId identifier: #DeletePrevious.
	
	splitSnippetShortcutId := BlShortcutId  identifier:  #SplitSnippet.
	
	renameSnippetShortcutId := BlShortcutId identifier: #RenameSnippet.
	
	secondaryNewLineShortcutId := BlShortcutId identifier: #SecondaryNewLine.
]

{ #category : #accessing }
LeShortcutIds >> moveSnippetDownShortcutId [
	^ moveSnippetDownShortcutId
]

{ #category : #ids }
LeShortcutIds >> moveSnippetUpShortcutId [
	^ moveSnippetUpShortcutId
]

{ #category : #accessing }
LeShortcutIds >> renameSnippetShortcutId [
	^ renameSnippetShortcutId
]

{ #category : #accessing }
LeShortcutIds >> secondaryNewLineShortcutId [
	^ secondaryNewLineShortcutId
]

{ #category : #ids }
LeShortcutIds >> splitSnippetShortcutId [
	^ splitSnippetShortcutId
]

{ #category : #accessing }
LeShortcutIds >> unindentSnippetShortcutId [
	^ unindentSnippetShortcutId
]
