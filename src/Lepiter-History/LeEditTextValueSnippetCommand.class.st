Class {
	#name : #LeEditTextValueSnippetCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'textEditCommand',
		'shouldApplyUndo',
		'source'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeEditTextValueSnippetCommand >> basicExecute [
	^ self withUndoExecute: [ 
		| wrappedTextEditCommand |
		wrappedTextEditCommand := BrTextEditorWrappedHistoryCommand 
			forCommand: self textEditCommand.
		self shouldApplyUndo ifTrue: [
			wrappedTextEditCommand markForUndo ].
		
		self targetSnippet
			updateFromTextEditCommand: wrappedTextEditCommand 
			source: self source ]
]

{ #category : #converting }
LeEditTextValueSnippetCommand >> createCommandSpecification [
	^ LeGenericCommandSpecification new
		contentUid: self targetSnippetUid;
		commandTypeName: self className;
		attributeAt: #textEditCommand put: self textEditCommand;
		attributeAt: #shouldApplyUndo put: self shouldApplyUndo
]

{ #category : #accessing }
LeEditTextValueSnippetCommand >> createUndoCommandSpecification [
	^ (self targetSnippet commandBuilder compositeCommand
		label: 'Undo Text Edit';
		addSubcommand: (self targetSnippet commandBuilder 
			editTextValueSnippetCommand
				textEditCommand: self textEditCommand;
				reverseEditDirection);
		addSubcommand: (self targetSnippet commandBuilder  
			editSnippetStateCommand
				snippetState: self targetSnippet extractCommonState)) createCommandSpecification
]

{ #category : #execution }
LeEditTextValueSnippetCommand >> executeEditFor: aText [ 
	self shouldApplyUndo 
		ifTrue: [ self executeUndoEditFor:  aText ] 
		ifFalse: [ self executeMainEditFor: aText ].
]

{ #category : #execution }
LeEditTextValueSnippetCommand >> executeMainEdit [
	^ self textEditCommand 
		redoTextChangeOn:  self targetSnippet text
]

{ #category : #execution }
LeEditTextValueSnippetCommand >> executeMainEditFor: aText [
	^ self textEditCommand 
		redoTextChangeOn:  aText
]

{ #category : #execution }
LeEditTextValueSnippetCommand >> executeUndoEdit [
	self textEditCommand 
		undoTextChangeOn: self targetSnippet text 
]

{ #category : #execution }
LeEditTextValueSnippetCommand >> executeUndoEditFor: aText [
	self textEditCommand 
		undoTextChangeOn: aText
]

{ #category : #initialization }
LeEditTextValueSnippetCommand >> initializeFromSpecification: aCommandSpecification withBuilder: aBuilder [
	super initializeFromSpecification: aCommandSpecification withBuilder: aBuilder.
	
	self 
		textEditCommand: (aCommandSpecification 
			attributeAt: #textEditCommand);
		shouldApplyUndo: (aCommandSpecification 
			attributeAt: #shouldApplyUndo)
]

{ #category : #accessing }
LeEditTextValueSnippetCommand >> reverseEditDirection [
	shouldApplyUndo := self shouldApplyUndo not.
]

{ #category : #testing }
LeEditTextValueSnippetCommand >> shouldApplyUndo [
	^ shouldApplyUndo ifNil: [ false ]
]

{ #category : #accessing }
LeEditTextValueSnippetCommand >> shouldApplyUndo: aBoolean [
	shouldApplyUndo := aBoolean
]

{ #category : #accessing }
LeEditTextValueSnippetCommand >> source [
	^ source
]

{ #category : #accessing }
LeEditTextValueSnippetCommand >> source: anObject [
	source := anObject
]

{ #category : #accessing }
LeEditTextValueSnippetCommand >> textEditCommand [
	^ textEditCommand
]

{ #category : #accessing }
LeEditTextValueSnippetCommand >> textEditCommand: anObject [
	textEditCommand := anObject
]

{ #category : #'updating - view model' }
LeEditTextValueSnippetCommand >> updateCursorForMainEditInSnippetViewModel: aSnippetUIModel [
	aSnippetUIModel coderViewModel
		cursors: self textEditCommand cursorForRedoEdit
]

{ #category : #'updating - view model' }
LeEditTextValueSnippetCommand >> updateCursorForUndoEditInSnippetViewModel: aSnippetUIModel [
	aSnippetUIModel coderViewModel
		cursors: self textEditCommand cursorForUndoEdit
]

{ #category : #'updating - view model' }
LeEditTextValueSnippetCommand >> updateSnippetsViewModelFor: aSnippetsViewModel withResult: aCommandResult [		
	| snippetUIModel |		
	
	snippetUIModel := aSnippetsViewModel findSnippetViewModel: self targetContent.
	snippetUIModel focused: true.
	
	snippetUIModel coderViewModel selectNone.
	self shouldApplyUndo 
		ifTrue: [ self updateCursorForUndoEditInSnippetViewModel: snippetUIModel ] 
		ifFalse: [ self updateCursorForMainEditInSnippetViewModel: snippetUIModel ].
]
