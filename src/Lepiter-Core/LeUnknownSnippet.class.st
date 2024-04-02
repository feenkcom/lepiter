"
LeUnkownSnippet is used to hold the json of any snippet type that isn't recognised.

It's capable of serialising itself in the original json, so pages can otherwise be modified.

Note that metadata (timestamps and email addresses) from the unknown snippet are lost since the original json is used for serialisation.

"
Class {
	#name : #LeUnknownSnippet,
	#superclass : #LeTextualSnippet,
	#instVars : [
		'jsonString'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #factory }
LeUnknownSnippet class >> empty [
	"Return a block with empty text"
	^ self new
]

{ #category : #'instance creation' }
LeUnknownSnippet class >> jsonString: aString [ 

	^ self new jsonString: aString.
]

{ #category : #serializing }
LeUnknownSnippet class >> leJsonV3MappingFor: aNeoJSONMapper [
	"LeUnknownSnippet simply writes its jsonString out"

	"This should just be a custom mapper that encodes and decodes the json string in the snippet"
	aNeoJSONMapper for: self customDo: [ :mapping | 
		mapping 
			reader: [ :jsonReader :arg | 
				self error: 'Unknown snippet decoding happens in LeJsonV3Reader' ];
			writer: [ :jsonWriter :leUnknownSnippet | | map |
				map := STONJSON fromString: leUnknownSnippet jsonString.
				map at: #children put: leUnknownSnippet children.
				map neoJsonOn: jsonWriter ] ]
]

{ #category : #serializing }
LeUnknownSnippet class >> leJsonV4MappingFor: aNeoJSONMapper [
	"LeUnknownSnippet simply writes its jsonString out"

	"This should just be a custom mapper that encodes and decodes the json string in the snippet"
	aNeoJSONMapper for: self customDo: [ :mapping | 
		mapping 
			reader: [ :jsonReader :arg | 
				self error: 'Unknown snippet decoding happens in LeJsonV4Reader' ];
			writer: [ :jsonWriter :leUnknownSnippet | | map |
				map := STONJSON fromString: leUnknownSnippet jsonString.
				map at: #children put: leUnknownSnippet children.
				map neoJsonOn: jsonWriter ] ]
]

{ #category : #serializing }
LeUnknownSnippet class >> leJsonV4Name [

	^ #unknownSnippet
]

{ #category : #visiting }
LeUnknownSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitUnknownSnippet: self
]

{ #category : #'api - editing' }
LeUnknownSnippet >> appendText: aText source: anObject [
	"Text attributes aren't part of the model, so appending an empty text with attributes is meaningless and can be ignored"
	aText ifEmpty: [ ^ self ].

	self 
		jsonString: jsonString, String cr, aText asString 
		source: anObject.
]

{ #category : #'api - accessing' }
LeUnknownSnippet >> contentAsString [
	<return: #String>

	^ jsonString
]

{ #category : #'gt-extensions' }
LeUnknownSnippet >> gtStringFor: aView [
	<gtView>

	jsonString ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'JSON string';
		priority: 10;
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: JSONParser gtStyler;
		text: [ self jsonString ]
]

{ #category : #initialization }
LeUnknownSnippet >> initialize [
	super initialize.
	jsonString = ''.
]

{ #category : #testing }
LeUnknownSnippet >> isUnknownSnippet [ 
	^ true
]

{ #category : #'api - accessing' }
LeUnknownSnippet >> jsonString [
	<return: #String>

	^ jsonString
]

{ #category : #accessing }
LeUnknownSnippet >> jsonString: aString [

	jsonString := aString
]

{ #category : #accessing }
LeUnknownSnippet >> jsonString: aString source: anObject [

	jsonString := aString.
	self updateEditTimeAndEmail.
	self updateUnlinkedReferences.
	self announceTextChangedBy: anObject
]

{ #category : #'private - exporting' }
LeUnknownSnippet >> markdownOn: stream level: anInteger [
	"Write the receiver as an HTML string on the supplied stream.
	This is currently a simplistic implementation which doesn't handle line breaks within the block properly (they need to be indented)"

	(jsonString isNotEmpty or: [ self hasChildren ]) ifFalse: [ ^ self ].

	anInteger * 4 timesRepeat:
		[ stream nextPut: Character space ].
	stream 
		<< '- ';
		<< self jsonString trimBoth.

	self childrenDo: [ :child |
		stream cr.
		child markdownOn: stream level: anInteger + 1 ]
]

{ #category : #printing }
LeUnknownSnippet >> printOn: aStream [
	super printOn: aStream.
	
	jsonString ifNil: [ ^ self ].
	jsonString ifEmpty: [ ^ self ].
	
	aStream 
		nextPutAll: '(';
		nextPutAll: jsonString;
		nextPutAll: ')'
]

{ #category : #'private - updating' }
LeUnknownSnippet >> reloadAttributesFromContent: aLeContent [
	"Update only the jsonString.
	No other metadata needs to be update for an unknown snippet, as that
	snippet is created on-the-fly by the importer."

	| changed metaDataChanged |
	changed := false.
	jsonString = aLeContent jsonString
		ifFalse: [ self jsonString: aLeContent jsonString.
			changed := true ].
	metaDataChanged := self reloadCommonMetadataFromContent: aLeContent.
	^ metaDataChanged or: [ changed ]
]

{ #category : #'private - updating' }
LeUnknownSnippet >> reloadFromContent: aLeSnippet [
	"Reload the receiver from the supplied snippet"

	"If the snippet is now known, replace myself with the new snippet.
	Save my current parent since it will be nilled out while removing me."
	aLeSnippet class = self class ifFalse: [ 
		| myParent index |
		myParent := parent.
		index := myParent children indexOf: self.
		self removeSelf.
		myParent addSnippet: aLeSnippet beforeIndex: index.
		^ true ].

	"It's still unknown, update the children snippets and its properties."
	^ super reloadFromContent: aLeSnippet
]

{ #category : #printing }
LeUnknownSnippet >> storeOn: aStream [

	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' jsonString: '.
	self jsonString storeOn: aStream.
	aStream nextPut: $)
]

{ #category : #'api - accessing' }
LeUnknownSnippet >> text [ 
	<return: #BlText>

	^ jsonString asRopedText
]

{ #category : #'api - accessing' }
LeUnknownSnippet >> text: aBlText [

	jsonString := aBlText asString
]
