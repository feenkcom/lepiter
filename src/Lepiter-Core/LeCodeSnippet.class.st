"
# Code snippet
{{gtClass:LeCodeSnippet}} is an abstract representation of a snipet of code in any language.
The language support is provided by specialized {{gtClass:GtSourceCoder}}

### Instance Variables
	code:		<String>


### Implementation Points

"
Class {
	#name : #LeCodeSnippet,
	#superclass : #LeTextualSnippet,
	#instVars : [
		'coder'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #'instance creation' }
LeCodeSnippet class >> code: aString [

	^ self new code: aString
]

{ #category : #factory }
LeCodeSnippet class >> empty [ 

	^ self new
]

{ #category : #accesing }
LeCodeSnippet class >> stateAttributes [
	^ self leJsonV4AttributeMapping collect: [ :aMapping |
		aMapping key = #code
			ifTrue: [ LeTextualSnippetStringAttribute named: aMapping key ]
			ifFalse: [ LeGenericSnippetStateAttribute named: aMapping key ] ]
]

{ #category : #'api - editing' }
LeCodeSnippet >> appendText: aText source: anObject [

	coder
		appendText: aText
		with: (GtCoderUpdateStrategy new source: anObject)
]

{ #category : #'api - accessing' }
LeCodeSnippet >> code [
	<return: #String>

	^ coder currentSourceString
]

{ #category : #'api - accessing' }
LeCodeSnippet >> code: aString [ 

	^ self code: aString source: self
]

{ #category : #'api - accessing' }
LeCodeSnippet >> code: aString source: anObject [
	"Set a new source string"

	coder
		sourceCode: (GtCoderExplicitSourceCode new source: aString)
		withStrategy: (GtCoderUpdateStrategy new source: anObject)
]

{ #category : #'api - accessing' }
LeCodeSnippet >> coder [
	<return: #GtTextualCoder>

	^ coder
]

{ #category : #'api - accessing' }
LeCodeSnippet >> contentAsString [
	^ self code
]

{ #category : #'private - event handling' }
LeCodeSnippet >> executeWithLoggingAction: aBlock afterChange: aGtCoderSourceCodeChanged [ 
	"Execute the given block by creating a trace event 
	for the given coder change."
	| fakeCommand undoSpecification traceEvent |
	fakeCommand := self commandBuilder editTextualSnippetCommand
		string: aGtCoderSourceCodeChanged newText asString.
	
	undoSpecification := fakeCommand createUndoCommandSpecification.
	(undoSpecification snippetState 
		attributeNamed: 'code' )
			string: aGtCoderSourceCodeChanged previousText asString.
	
	traceEvent := LeContentEditTraceEvent new
		mainCommandSpecification: fakeCommand createCommandSpecification
			asSpecificationForLogStorage;
		undoCommandSpecification: undoSpecification 
			asSpecificationForLogStorage.
	
	aBlock value.
	
	self announceTraceableChangeExecutedFor: traceEvent
]

{ #category : #initialization }
LeCodeSnippet >> initialize [ 
	super initialize.

	coder := self newCoder.
	coder weak
		when: GtCoderSourceCodeChanged
			send: #onCoderSourceModified:
			to: self;
		when: GtCoderRenameTemporaryRequestedAnnouncement
			send: #onCoderRenameTemporaryRequested:
			to: self
]

{ #category : #'api - testing' }
LeCodeSnippet >> isCodeSnippet [
	^ true
]

{ #category : #initialization }
LeCodeSnippet >> newCoder [
	^ self subclassResponsibility
]

{ #category : #'private - event handling' }
LeCodeSnippet >> onCoderRenameTemporaryRequested: aGtCoderRenameTemporaryRequestedAnnouncement [
	self page
		allChildrenDepthFirstDo:
			[ :each | 
			(each isCodeSnippet
				and: [ each coder hasImplicitVariableReferenceTo: aGtCoderRenameTemporaryRequestedAnnouncement variableName ])
				ifTrue: [ aGtCoderRenameTemporaryRequestedAnnouncement interestedCoders add: each coder ] ]
]

{ #category : #'private - event handling' }
LeCodeSnippet >> onCoderSourceModified: aGtCoderSourceCodeChanged [
	"Is announced by the Coder model when its source code changes"
	
	"In case the source of the event is a command, 
	do not log another trace of the change."
	(self shouldAddTraceEventForChange: aGtCoderSourceCodeChanged) 
		ifFalse: [ ^ self updateAfterChange: aGtCoderSourceCodeChanged ].
	
	self 
		executeWithLoggingAction: [ 
			self updateAfterChange: aGtCoderSourceCodeChanged ]  
		afterChange: aGtCoderSourceCodeChanged
]

{ #category : #printing }
LeCodeSnippet >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: (self code 
			ifNil: [''] ifNotNil: [self code takeFirst: 20]);
		nextPutAll: ')'
]

{ #category : #'private - event handling' }
LeCodeSnippet >> shouldAddTraceEventForChange: aGtCoderSourceCodeChanged [ 
	"We only add a trace event if we have the previous text, 
	and the change was not the result of another command."
	
	^ aGtCoderSourceCodeChanged previousText notNil and: [
		 aGtCoderSourceCodeChanged updateStrategy notNil and: [
			(aGtCoderSourceCodeChanged updateStrategy 
				propertyNamed: #isFromEditCommand ifAbsent: [ false ]) not ]]
]

{ #category : #printing }
LeCodeSnippet >> storeOn: aStream [

	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new code: '.
	self code storeOn: aStream.
	self childrenDo: [ :snippet | 
		aStream nextPutAll: '; addSnippet: '.
		snippet storeOn: aStream ].
	aStream nextPutAll: '; yourself)'
]

{ #category : #'api - accessing' }
LeCodeSnippet >> text [
	<return: #BlText>

	^ coder currentSourceText
]

{ #category : #'private - event handling' }
LeCodeSnippet >> updateAfterChange: aGtCoderSourceCodeChanged [ 
	"The snippet stores the entire coder model, so after a change 
	in coder, we do not need to modify the code in the snippet.
	We only update metadata and links."
	
	self updateEditTimeAndEmail.
	
	self updateUnlinkedReferences.
	self announceTextChangedBy: aGtCoderSourceCodeChanged source
]

{ #category : #'api - editing' }
LeCodeSnippet >> updateFromCommandText: aText source: anObject [
	coder
		currentSourceText: aText
		with: (GtCoderUpdateStrategy new 
			source: anObject;
			propertyNamed: #isFromEditCommand put: true;
			yourself)
]

{ #category : #'api - editing' }
LeCodeSnippet >> updateFromEditValueCommandText: aText source: anObject [
	self updateFromCommandText: aText source: anObject
]

{ #category : #'api - editing' }
LeCodeSnippet >> updateText: aText source: anObject [
	"Change the text of the textual snippet to a given one. A source object represent an object that requested a text change"

	coder
		currentSourceText: aText
		with: (GtCoderUpdateStrategy new 
			source: anObject)
]
