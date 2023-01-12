Class {
	#name : #LeContentCommandExamples,
	#superclass : #Object,
	#instVars : [
		'thePage'
	],
	#category : #'Lepiter-History-Examples'
}

{ #category : #testing }
LeContentCommandExamples class >> isAbstract [ 
	^ self name = #LeContentCommandExamples
]

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
LeContentCommandExamples >> assertEqualCreateEditMetadataSetForSnippet: aSnippet [ 
	self assert: aSnippet createTime equals: aSnippet editTime.
	self assert: aSnippet createEmail equals: aSnippet editEmail.
]

{ #category : #asserting }
LeContentCommandExamples >> assertExecutionResultFor: aCommandResult [
	self assert: aCommandResult command notNil.
	self assert: aCommandResult undoSpecification notNil.
]

{ #category : #asserting }
LeContentCommandExamples >> assertFullMetadataSetForSnippet: aSnippet [ 
	self assert: aSnippet hasCreateAndEditMetadata.
]

{ #category : #asserting }
LeContentCommandExamples >> assertOneEventInPageHistory [
	self assert: self targetPage editHistory eventStore size equals: 1.
]

{ #category : #asserting }
LeContentCommandExamples >> assertOnlyTimeMetadataSetForSnippet: aSnippet [ 
	self assert: aSnippet createTime notNil.
	self assert: aSnippet editTime notNil.
	self assert: aSnippet createTime equals: aSnippet editTime.
	
	self assert: aSnippet createEmail isNil.
	self assert: aSnippet editEmail isNil.
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
LeContentCommandExamples >> assertTargePageIsSerialisable [
	| jsonString|
	jsonString := LeJsonV4 uniqueInstance 
		serializePretty: self targetPage.
	self assert: jsonString notNil.
	
	LeJsonV4 uniqueInstance 
		deserialize: jsonString readStream
]

{ #category : #asserting }
LeContentCommandExamples >> assertValidCommandFor: aCommand [ 
	self assert: aCommand uid notNil.
	self assert: aCommand targetContent notNil.
]

{ #category : #'examples - setup  pages' }
LeContentCommandExamples >> createTargetPage [
	<gtExample>
	
	| newPage|
	newPage := LePage named: 'TestPage'.
		
	self assertEmptyPageHistoryForPage: newPage.
	
	^ newPage
]

{ #category : #'examples - setup  pages' }
LeContentCommandExamples >> ensureTargetPageWithTwoBasicSnippetsAndFirstTarget [
	<gtExample>
	| targetPage |
	
	targetPage := self targetPage.
	targetPage addSnippet: (self textSnippetWithString: 'Target').
	targetPage addSnippet: (self textSnippetWithString: 'A').
	
	^ targetPage
]

{ #category : #utils }
LeContentCommandExamples >> pharoCodeSnippetWithString: aString [ 
	^ (LePharoSnippet code: aString)
		uid: LeUID new;
		yourself
]

{ #category : #'examples - setup  pages' }
LeContentCommandExamples >> targetPage [
	<gtExample>
	
	^ thePage ifNil: [
		thePage := self createTargetPage ]
]

{ #category : #'examples - setup  pages' }
LeContentCommandExamples >> targetSnippet [
	self targetPage allChildrenBreadthFirstDo: [ :aSnippet |
		aSnippet string = 'Target' ifTrue: [ ^ aSnippet ] ].
	
	NotFound signal.
]

{ #category : #utils }
LeContentCommandExamples >> textSnippetWithString: aString [ 
	^ (LeTextSnippet string: aString)
		uid: LeUID new;
		yourself
]

{ #category : #accessing }
LeContentCommandExamples >> thePage [
	^ thePage
]

{ #category : #accessing }
LeContentCommandExamples >> thePage: aPage [
	^ thePage := aPage
]
