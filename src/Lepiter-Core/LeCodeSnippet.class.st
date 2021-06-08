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

{ #category : #initialization }
LeCodeSnippet >> initialize [ 
	super initialize.

	coder := self newCoder.
	coder weak
		when: GtCoderSourceCodeChanged
		send: #onCoderSourceModified:
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
LeCodeSnippet >> onCoderSourceModified: aGtCoderSourceCodeChanged [
	"Is announced by the Coder model when its source code changes"

	self updateEditTimeAndEmail.
	self updateUnlinkedReferences.
	self announceTextChangedBy: aGtCoderSourceCodeChanged source
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

{ #category : #'api - accessing' }
LeCodeSnippet >> text [ 
	<return: #BlText>

	^ coder sourceText
]

{ #category : #'api - editing' }
LeCodeSnippet >> updateText: aText source: anObject [
	"Change the text of the textual snippet to a given one. A source object represent an object that requested a text change"

	coder
		currentSourceText: aText
		with: (GtCoderUpdateStrategy new source: anObject)
]
