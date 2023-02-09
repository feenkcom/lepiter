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
		self shouldApplyUndo 
			ifTrue: [ self executeUndoEdit ] 
			ifFalse: [ self executeMainEdit ].
		
		self targetContent announceTextChangedBy: self source ]
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
	^ (self targetSnippet commandBuilder editTextValueSnippetCommand
		textEditCommand: self textEditCommand;
		reverseEditDirection) createCommandSpecification
]

{ #category : #execution }
LeEditTextValueSnippetCommand >> executeMainEdit [
	self targetSnippet text 
		insertStrings: self textEditCommand strings
		atAll: self textEditCommand redoIndices.
]

{ #category : #execution }
LeEditTextValueSnippetCommand >> executeUndoEdit [
	| toDeleteIntervals |
	
	toDeleteIntervals := self textEditCommand strings 
		with: self textEditCommand undoIndices 
		collect: [ :eachString :eachIndex | 
			eachIndex + 1
				to: eachIndex + eachString size ].
		
	self targetSnippet text deleteAll: toDeleteIntervals
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
