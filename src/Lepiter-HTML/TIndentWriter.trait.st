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
		nextPutAll: aString;
		cr
]

{ #category : #accessing }
TIndentWriter >> putString: aString [
	stream
		tab: nestingLevel;
		nextPutAll: aString;
		cr
]

{ #category : #accessing }
TIndentWriter >> putTag: aTag andAttributes: attributesString with: aBlock [
	self putString: '<',aTag, (attributesString ifNotEmpty: [' ',attributesString]), '>'.
	self indent:aBlock.
	self putString: '</',aTag,'>'.
]

{ #category : #accessing }
TIndentWriter >> putTag: aTag with: aBlock [
	self putTag: aTag andAttributes: '' with: aBlock
]

{ #category : #accessing }
TIndentWriter >> stream [
	^ stream
]

{ #category : #accessing }
TIndentWriter >> stream: anObject [
	stream := anObject
]
