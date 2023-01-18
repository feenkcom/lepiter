Class {
	#name : #LeTransferSnippetChildrenCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'sourceSnippet',
		'sourceSnippetUid'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #converting }
LeTransferSnippetChildrenCommand >> createCommandSpecification [
	^ LeTransferSnippetChildrenCommandSpecification new 
		contentUid: self targetSnippetUid;
		commandTypeName: self className;
		sourceSnippetUid: self sourceSnippetUid
]

{ #category : #'execution - utils' }
LeTransferSnippetChildrenCommand >> createUndoCommand [
	self subclassResponsibility
]

{ #category : #'execution - utils' }
LeTransferSnippetChildrenCommand >> createUndoCommandSpecification [
	^ self createUndoCommand createCommandSpecification
]

{ #category : #initialization }
LeTransferSnippetChildrenCommand >> initializeFromSpecification: aCommandSpecification withBuilder: aBuilder [
	super initializeFromSpecification: aCommandSpecification withBuilder: aBuilder.
	
	self sourceSnippetUid: aCommandSpecification sourceSnippetUid
]

{ #category : #accessing }
LeTransferSnippetChildrenCommand >> sourceSnippet [

	self targetSnippet page  withAllChildrenBreadthFirstDo: [ :aContent |
		aContent uid = self sourceSnippetUid ifTrue: [ ^ aContent ] ].
	
	Error signal: 'Could not find content with uid ', self sourceSnippetUid printString.
]

{ #category : #accessing }
LeTransferSnippetChildrenCommand >> sourceSnippetUid [
	^ sourceSnippetUid
]

{ #category : #accessing }
LeTransferSnippetChildrenCommand >> sourceSnippetUid: anUid [
	sourceSnippetUid := anUid
]
