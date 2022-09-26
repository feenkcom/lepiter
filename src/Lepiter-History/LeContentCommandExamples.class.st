Class {
	#name : #LeContentCommandExamples,
	#superclass : #Object,
	#instVars : [
		'thePage'
	],
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
LeContentCommandExamples >> assertEmptyPageHistoryForPage: aPage [
	self assert: aPage editHistory eventStore isEmpty. 
	self assert: aPage editHistory redoUndoActions isEmpty. 
	self assert: aPage editHistory isUndoEnabled.  
]

{ #category : #accessing }
LeContentCommandExamples >> createTargetPage [
	<gtExample>
	
	| newPage|
	newPage := LePage named: 'TestPage'.
		
	self assertEmptyPageHistoryForPage: newPage.
	
	^ newPage
]

{ #category : #accessing }
LeContentCommandExamples >> targetPage [
	<gtExample>
	
	^ thePage ifNil: [
		thePage := self createTargetPage ]
]
