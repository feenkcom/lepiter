Trait {
	#name : #TLeContentNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
TLeContentNodeVisitor >> visitAnnotation: anAnnotation [
	^ self visitContent: anAnnotation
]

{ #category : #generated }
TLeContentNodeVisitor >> visitBlockLink: aBlockLink [
	^ self visitDefinedLink: aBlockLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitBold: aBold [
	^ self visitContent: aBold
]

{ #category : #generated }
TLeContentNodeVisitor >> visitCodeBlock: aCodeBlock [
	^ self visitContent: aCodeBlock
]

{ #category : #generated }
TLeContentNodeVisitor >> visitContent: aContent [
	^ self visitSmaCCParseNode: aContent
]

{ #category : #generated }
TLeContentNodeVisitor >> visitDefinedLink: aDefinedLink [
	^ self visitLink: aDefinedLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitDocumenterAnnotation: aDocumenterAnnotation [
	^ self visitContent: aDocumenterAnnotation
]

{ #category : #generated }
TLeContentNodeVisitor >> visitDoubleBracketLink: aDoubleBracketLink [
	^ self visitPageLink: aDoubleBracketLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitEmptyDoubleBracketLink: anEmptyDoubleBracketLink [
	^ self visitEmptyLink: anEmptyDoubleBracketLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitEmptyExternalLink: anEmptyExternalLink [
	^ self visitContent: anEmptyExternalLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitEmptyHashLink: anEmptyHashLink [
	^ self visitEmptyLink: anEmptyHashLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitEmptyLink: anEmptyLink [
	^ self visitLink: anEmptyLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitExternalImageLink: anExternalImageLink [
	^ self visitExternalLink: anExternalImageLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitExternalLabelUrlLink: anExternalLabelUrlLink [
	^ self visitExternalLink: anExternalLabelUrlLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitExternalLink: anExternalLink [
	^ self visitContent: anExternalLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitExternalUrlLink: anExternalUrlLink [
	^ self visitExternalLink: anExternalUrlLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitFullHashLink: aFullHashLink [
	^ self visitHashLink: aFullHashLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitHashLink: aHashLink [
	^ self visitPageLink: aHashLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitHeader: aHeader [
	^ self visitContent: aHeader
]

{ #category : #generated }
TLeContentNodeVisitor >> visitInlineCode: anInlineCode [
	^ self visitContent: anInlineCode
]

{ #category : #generated }
TLeContentNodeVisitor >> visitItalic: anItalic [
	^ self visitContent: anItalic
]

{ #category : #generated }
TLeContentNodeVisitor >> visitKeywordLink: aKeywordLink [
	^ self visitPageLink: aKeywordLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitLink: aLink [
	^ self visitContent: aLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitPageLink: aPageLink [
	^ self visitDefinedLink: aPageLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitShortHashLink: aShortHashLink [
	^ self visitHashLink: aShortHashLink
]

{ #category : #generated }
TLeContentNodeVisitor >> visitString: aString [
	^ self visitContent: aString
]

{ #category : #generated }
TLeContentNodeVisitor >> visitText: aText [
	^ self visitContent: aText
]
