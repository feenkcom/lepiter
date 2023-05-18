Trait {
	#name : #TIndentWriter,
	#instVars : [
		'nestingLevel',
		'stream'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #accessing }
TIndentWriter >> indent: aBlock [
	nestingLevel := nestingLevel + 1.
	aBlock value.
	nestingLevel := nestingLevel - 1.
]

{ #category : #accessing }
TIndentWriter >> nestingLevel: aNestingLevel [
	nestingLevel := aNestingLevel
]

{ #category : #accessing }
TIndentWriter >> putPre: aString [
	stream
		newLine;
		escape: aString;
		newLine
]

{ #category : #accessing }
TIndentWriter >> putPre: aTag andAttributes: attributesString with: aBlock [
	stream
		tag: aTag
		attributes: attributesString
		do: aBlock
]

{ #category : #accessing }
TIndentWriter >> putString: aString [
	stream escape: aString
]

{ #category : #accessing }
TIndentWriter >> putStringInline: aString [
	stream nextPutAll: aString
]

{ #category : #accessing }
TIndentWriter >> putTag: aTag andAttributes: attributesPair [ 
	stream tag: aTag attributes: attributesPair.
]

{ #category : #accessing }
TIndentWriter >> putTag: aTag andAttributes: attributesPair with: aBlock [
	stream
		tag: aTag
		attributes: attributesPair
		do: aBlock
]

{ #category : #accessing }
TIndentWriter >> putTag: aTag with: aBlock [
	self putTag: aTag andAttributes: #() with: aBlock
]

{ #category : #accessing }
TIndentWriter >> putTagInline: aTag andAttributes: attributesPair with: aBlock [
	stream
		tag: aTag
		attributes: attributesPair
		do: aBlock
]

{ #category : #accessing }
TIndentWriter >> putTagInline: aTag with: aBlock [
	self putTagInline: aTag andAttributes: #() with: aBlock
]

{ #category : #accessing }
TIndentWriter >> stream [
	^ stream
]

{ #category : #accessing }
TIndentWriter >> stream: aStream [
	(aStream isKindOf: LeHtmlOutputPrettyStream)
		ifTrue: [ stream := aStream ]
		ifFalse: [ stream := LeHtmlOutputPrettyStream on: aStream ]
]
