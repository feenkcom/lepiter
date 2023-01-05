Class {
	#name : #LeContentCommandExamples,
	#superclass : #Object,
	#instVars : [
		'thePage'
	],
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
LeContentCommandExamples >> assertCommand: aCommand forSnippet: aTargetSnippet [ 
	self assert: aCommand uid notNil.
	self assert: aCommand targetContent equals: aTargetSnippet.
]

{ #category : #asserting }
LeContentCommandExamples >> assertEmptyPageHistoryForPage: aPage [
	self assert: aPage editHistory eventStore isEmpty. 
	self assert: aPage editHistory redoUndoActions isEmpty. 
	self assert: aPage editHistory isUndoEnabled.  
]

{ #category : #asserting }
LeContentCommandExamples >> assertStructure: structureDescription forContent: aLepiterContent [

	self assert: structureDescription size equals: aLepiterContent children size.
	structureDescription withIndexDo: [ :assoc :index |
		| currentSnippet textValue |
		currentSnippet := aLepiterContent children at: index.
		textValue := assoc value isAssociation 
			ifTrue: [ assoc value key ] 
			ifFalse: [ assoc value ].
		self assert: currentSnippet string equals: textValue.
		assoc value isAssociation ifTrue: [
			self 
				assertStructure: assoc value value
				forContent: currentSnippet  ] ]
]

{ #category : #asserting }
LeContentCommandExamples >> assertValidCommandFor: aCommand [ 
	self assert: aCommand uid notNil
]

{ #category : #'examples - setup' }
LeContentCommandExamples >> createTargetPage [
	<gtExample>
	
	| newPage|
	newPage := LePage named: 'TestPage'.
		
	self assertEmptyPageHistoryForPage: newPage.
	
	^ newPage
]

{ #category : #'examples - setup' }
LeContentCommandExamples >> targetPage [
	<gtExample>
	
	^ thePage ifNil: [
		thePage := self createTargetPage ]
]
