"
I build an HTML element ID for a given {{gtMethod:LeHtmlElementIdBuilder >> #contentNode: | label=content node}}. 
# Example
{{gtExample:LeHtmlElementIdBuilderExamples>>#headerWithParentheses | codeExpanded=false | previewExpanded=true}}
"
Class {
	#name : #LeHtmlElementIdBuilder,
	#superclass : #Object,
	#traits : 'TLeAnnotationParseNodeVisitor + (TLeContentNodeVisitor - {#visitAnnotation:})',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'contentNode',
		'elementId',
		'existingIds',
		'stream',
		'isDash'
	],
	#category : #'Lepiter-HTML-Support'
}

{ #category : #building }
LeHtmlElementIdBuilder >> build [
	isDash := false.
	elementId := String streamContents: [ :aStream | 
		stream := aStream.
		self acceptNode: contentNode ].
		
	self ensureUniqueId.	
	self existingIds add: elementId.
		
	^ LeHtmlElementId new
		existingIds: self existingIds;
		contentNode: contentNode;
		elementId: elementId
]

{ #category : #accessing }
LeHtmlElementIdBuilder >> contentNode [
	<return: #LeContentNode>
	^ contentNode
]

{ #category : #accessing }
LeHtmlElementIdBuilder >> contentNode: aLeContentNode [
	contentNode := aLeContentNode
]

{ #category : #accessing }
LeHtmlElementIdBuilder >> elementId [
	^ elementId
]

{ #category : #writing }
LeHtmlElementIdBuilder >> ensureUniqueId [
	| aModifiedElementId anIndex |
	anIndex := 1.
	aModifiedElementId := elementId.
	
	[ self existingIds includes: aModifiedElementId ] whileTrue: [ 
		anIndex := anIndex + 1.
		aModifiedElementId := elementId , anIndex asString ].
	
	elementId := aModifiedElementId
]

{ #category : #accessing }
LeHtmlElementIdBuilder >> existingIds [
	^ existingIds ifNil: [ existingIds := OrderedCollection new: 1 ]
]

{ #category : #accessing }
LeHtmlElementIdBuilder >> existingIds: aCollection [
	existingIds := aCollection
]

{ #category : #writing }
LeHtmlElementIdBuilder >> pushFilteredString: aString [
	| aFilteredString aTrimmedString |
	self
		assert: [ aString isString ]
		description: [ 'Must be string: {1}' format: {aString} ].
		
	aFilteredString := String 
		new: aString size 
		streamContents: [ :aStream | 
			aString  do: [ :aCharacter | 
				aCharacter isAlphaNumeric 
					ifTrue: [ 
						aStream nextPut: aCharacter asLowercase.
						isDash := false ] 
					ifFalse: [
						isDash ifFalse: [ 
							aStream nextPut: $- ].
						isDash := true ] ] ].
		
	aTrimmedString := aFilteredString trimBoth: [ :each | each = $- ].
	
	stream nextPutAll: aTrimmedString
]

{ #category : #generated }
LeHtmlElementIdBuilder >> visitText: aText [
	self pushFilteredString: aText content
]
