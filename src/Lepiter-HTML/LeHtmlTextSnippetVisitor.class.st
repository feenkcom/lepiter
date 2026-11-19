Class {
	#name : #LeHtmlTextSnippetVisitor,
	#superclass : #Object,
	#traits : 'TLeExtensibleContentNodeVisitor + TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait + TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'context',
		'snippet',
		'exportedNodes',
		'elementIds'
	],
	#classInstVars : [
		'componentVisitorClasses'
	],
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #'text lines' }
LeHtmlTextSnippetVisitor >> blocksOfTextLinesIn: aString [
	"Answer the lines of the string grouped in blocks of lines of the same kind, or nil when no line is a list item or a quote (and the usual single paragraph is enough)."

	| lines |
	aString sortedChildren size = aString parts size ifFalse: [ ^ nil ].
	lines := self textLinesIn: aString parts.
	(lines anySatisfy: [ :each | each isPlain not ]) ifFalse: [ ^ nil ].
	^ self groupTextLines: lines
]

{ #category : #accessing }
LeHtmlTextSnippetVisitor >> context [
	^ context
]

{ #category : #accessing }
LeHtmlTextSnippetVisitor >> context: anObject [
	context := anObject
]

{ #category : #private }
LeHtmlTextSnippetVisitor >> convertToLocalOrAbsoluteUrl: linkUrl [
	<return: #String>
	^ LeUrlStringUtilityBuilder new
		database: context database;
		urlString: linkUrl;
		build;
		asString
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> defaultWidth [
	^ LeSnippetParagraphWidth new
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> elementIds [
	^ elementIds ifNil: [ elementIds := OrderedCollection new ]
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> elementIds: aCollection [
	elementIds := aCollection
]

{ #category : #'text lines' }
LeHtmlTextSnippetVisitor >> groupTextLines: aCollectionOfLines [
	"Consecutive lines of the same kind are one block."

	| blocks |
	blocks := OrderedCollection new.
	aCollectionOfLines
		do: [ :each | 
			(blocks isNotEmpty and: [ blocks last first kind = each kind ])
				ifTrue: [ blocks last add: each ]
				ifFalse: [ blocks add: (OrderedCollection with: each) ] ].
	^ blocks
]

{ #category : #initialization }
LeHtmlTextSnippetVisitor >> initialize [ 
	super initialize.
	
	"I am used to identify nodes that are not exported."
	exportedNodes := OrderedCollection new.
]

{ #category : #'text lines' }
LeHtmlTextSnippetVisitor >> isEndOfLineNode: aNode [
	^ (aNode isKindOf: LeTextNode)
		and: [ aNode content isNotEmpty
				and: [ aNode content
						allSatisfy: [ :each | each = Character cr or: [ each = Character lf ] ] ] ]
]

{ #category : #private }
LeHtmlTextSnippetVisitor >> logUnsupportedAnnotation: anAnnotation [
	^ context log
		addItem: (LeExportUnsupportedTextSnippetNodeLogItem new
				snippet: snippet;
				node: anAnnotation)

]

{ #category : #'private - exporting' }
LeHtmlTextSnippetVisitor >> resourcesFor: aSource [
	| snippetResources |
	snippetResources := context resources select: [ :eachResource | 
		eachResource source == aSource ].
	
	^ LeExportSnippetResources new
		resources: snippetResources
]

{ #category : #accessing }
LeHtmlTextSnippetVisitor >> snippet [
	^ snippet
]

{ #category : #accessing }
LeHtmlTextSnippetVisitor >> snippet: anObject [
	snippet := anObject
]

{ #category : #'text lines' }
LeHtmlTextSnippetVisitor >> textLinesIn: aCollectionOfNodes [
	"Split the nodes at the end-of-line text nodes."

	| lines current |
	lines := OrderedCollection new.
	current := OrderedCollection new.
	aCollectionOfNodes
		do: [ :each | 
			(self isEndOfLineNode: each)
				ifTrue: [ lines add: (LeHtmlTextLine nodes: current asArray eol: each).
					current := OrderedCollection new ]
				ifFalse: [ current add: each ] ].
	lines add: (LeHtmlTextLine nodes: current asArray eol: nil).
	^ lines
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitBold: aBold [
	exportedNodes add: aBold.
	
	context html inlineTag: 'b' do: [ self visitContent: aBold ]
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitCodeBlock: aCodeBlock [
	context html
		tag: #div
		attributes: #('class' 'code_block') 
		do: [
			context html
				tag: 'pre' 
				do: [
					context html 
						tag: 'code' 
						attributes: #('class' 'smalltalk') 
						with: aCodeBlock code value asString trimBoth.
				]
		]
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitContent: aContent [

	exportedNodes 
		detect: [ :eachNode | eachNode == aContent ] 
		ifFound: [ :aNode | "ignore" ] 
		ifNone: [ 
			context log addItem: (LeExportUnsupportedTextSnippetNodeLogItem new 
				snippet: snippet;
				node: aContent) ].

	^ self visitSmaCCParseNode: aContent
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitDocumenterAnnotation: aDocumenterAnnotation [
	| anAnnotation aVisitor |
	anAnnotation := aDocumenterAnnotation annotation.
	anAnnotation ifNil: [ ^ aDocumenterAnnotation ].
	anAnnotation isErrorNode
		ifTrue: [ ^ self writeUnknownAnnotation: aDocumenterAnnotation ].

	aVisitor := self
			annotationVisitorFor: anAnnotation
			default: (LeHtmlTextSnippetAnnotationVisitor new
					context: context;
					snippet: snippet).

	aVisitor
		ifNil: [ self logUnsupportedAnnotation: anAnnotation ]
		ifNotNil: [ anAnnotation acceptVisitor: aVisitor ].

	^ aDocumenterAnnotation

]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitDoubleBracketLink: aDoubleBracketLink [
	context pageLinks ifNil: [ ^ aDoubleBracketLink ].

	context pageLinks
		linkTitled: aDoubleBracketLink linkUID
		ifFound: [ :aLink | 
			context html 
				inlineTag: #a
				attributes: { 'href'. 
					(self context hrefBuilder  hrefFromPageLink: aLink) }
				with: aDoubleBracketLink linkUID ]
		ifNone: [ 
			context html 
				inlineTag: #div
				with: aDoubleBracketLink linkUID ].

	^ aDoubleBracketLink
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitExternalImageLink: anExternalImageLink [
	| resources |
	resources := self resourcesFor: anExternalImageLink.

	resources
		ifEmpty: [ "ignore" ]
		ifOne: [ :aResource | 
			LeHtmlFigureImageWriter new
				html: context html;
				imageSrc: aResource imgSrc;
				caption: anExternalImageLink label;
				width: self defaultWidth;
				write ]
		ifMore: [ :aCollection | "ignore" ]
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitExternalLabelUrlLink: anExternalLabelUrlLink [
	| linkUrl convertedUrl label |
	linkUrl := anExternalLabelUrlLink url.
	convertedUrl := self convertToLocalOrAbsoluteUrl: linkUrl.
	
	label := anExternalLabelUrlLink label trimBoth.
	label ifEmpty: [ label := linkUrl ].
	
	context html 
		inlineTag: #a 
		attributes: { #href. convertedUrl } 
		with: label
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitExternalUrlLink: anExternalUrlLink [
	| linkUrl convertedUrl |
	linkUrl := anExternalUrlLink url.
	convertedUrl := self convertToLocalOrAbsoluteUrl: linkUrl.
	
	context html 
		inlineTag: #a 
		attributes: { #href. convertedUrl } 
		with: convertedUrl
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitHeader: aHeader [
	| anElementId |
	exportedNodes add: aHeader.
	
	anElementId := LeHtmlElementIdBuilder new
		existingIds: self elementIds;
		contentNode: aHeader;
		build;
		elementId.
		
	context html
		tag: 'h' , (aHeader headerLevel + 1) asString
		attributes: { 'id'. anElementId }
		do: [ 
			context html
				tag: 'a'
				attributes: {
					'href'. '#' , anElementId }
				do: [ self visitContent: aHeader ] ]
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitInlineCode: anInlineCode [
	| md code |
	md := anInlineCode code value.
	code := md copyFrom: 2 to: md size - 1.
	context html inlineTag: #code with: code.
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitItalic: anItalic [
	exportedNodes add: anItalic.

	context html
		tag: #i
		do: [ context html noIndentDo: [ self visitContent: anItalic ] ].
		
	^ anItalic
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitSmaCCError: aSmaCCErrorNode [
	"Text that could not be parsed, for example an annotation without its closing braces.
	Write it as it was typed, so that no text is lost, and log it."

	exportedNodes add: aSmaCCErrorNode.
	context html escape: aSmaCCErrorNode source.
	context log
		addItem: (LeExportUnsupportedTextSnippetNodeLogItem new
				snippet: snippet;
				node: aSmaCCErrorNode).

	^ aSmaCCErrorNode

]

{ #category : #visiting }
LeHtmlTextSnippetVisitor >> visitString: aString [
	"Split around tables so block-level table elements never appear inside paragraphs."

	| pending |
	exportedNodes add: aString.
	(aString parts anySatisfy: [ :each | each isKindOf: LeTableNode ])
		ifTrue: [ pending := OrderedCollection new.
			aString parts
				do: [ :each | 
					(each isKindOf: LeTableNode)
						ifTrue: [ self writeTableSurroundingParts: pending.
							pending removeAll.
							self acceptNode: each ]
						ifFalse: [ pending add: each ] ].
			self writeTableSurroundingParts: pending.
			^ aString ].
	aString parts
		ifNotEmpty: [ :parts | 
			(parts first isKindOf: LeHeaderNode)
				ifFalse: [ (self blocksOfTextLinesIn: aString)
						ifNil: [ context html tag: #p do: [ self visitContent: aString ] ]
						ifNotNil: [ :blocks | blocks do: [ :each | self writeBlockOfTextLines: each ] ].
					^ aString ] ].
	^ self visitContent: aString
]

{ #category : #visiting }
LeHtmlTextSnippetVisitor >> visitTable: aTable [
	"Tables are block elements. Delimiter rows specify alignment and are not rendered."

	exportedNodes add: aTable.
	context html
		tag: #table
		do: [ context html
				tag: #thead
				do: [ self
						writeTableRow: aTable header
						tag: #th
						separator: aTable separator ].
			context html
				tag: #tbody
				do: [ aTable rows
						do: [ :row | 
							self
								writeTableRow: row
								tag: #td
								separator: aTable separator ] ] ].
	^ aTable
]

{ #category : #generated }
LeHtmlTextSnippetVisitor >> visitText: aText [
	context html escape: aText content.
	
	exportedNodes add: aText
]

{ #category : #'text lines' }
LeHtmlTextSnippetVisitor >> writeBlockOfTextLines: aCollectionOfLines [
	| kind |
	kind := aCollectionOfLines first kind.
	kind = #ul
		ifTrue: [ ^ self
				writeListOfTextLines: aCollectionOfLines
				tag: #ul
				attributes: #() ].
	kind = #ol
		ifTrue: [ ^ self
				writeListOfTextLines: aCollectionOfLines
				tag: #ol
				attributes: (aCollectionOfLines first number = 1
						ifTrue: [ #() ]
						ifFalse: [ {'start'.
								aCollectionOfLines first number printString} ]) ].
	kind = #quote ifTrue: [ ^ self writeQuoteOfTextLines: aCollectionOfLines ].
	^ self writeParagraphOfTextLines: aCollectionOfLines
]

{ #category : #'text lines' }
LeHtmlTextSnippetVisitor >> writeContentOfTextLine: aLine [
	"Write the text after the marker, then the other nodes of the line."

	exportedNodes addAll: aLine droppedNodes.
	aLine prefixText isEmpty ifFalse: [ context html escape: aLine prefixText ].
	self acceptNodes: aLine nodes
]

{ #category : #'text lines' }
LeHtmlTextSnippetVisitor >> writeListOfTextLines: aCollectionOfLines tag: aTag attributes: anArray [
	| writeItems |
	writeItems := [ aCollectionOfLines
			do: [ :each | 
				context html inlineTag: #li do: [ self writeContentOfTextLine: each ].
				each eol ifNotNil: [ :node | exportedNodes add: node ] ] ].
	anArray isEmpty
		ifTrue: [ context html tag: aTag do: writeItems ]
		ifFalse: [ context html
				tag: aTag
				attributes: anArray
				do: writeItems ]
]

{ #category : #'text lines' }
LeHtmlTextSnippetVisitor >> writeParagraphOfTextLines: aCollectionOfLines [
	"Write the lines in one paragraph, keeping the line breaks between them. Nothing is written when the lines are empty."

	| lastIndex |
	(aCollectionOfLines allSatisfy: [ :each | each isEmpty ])
		ifTrue: [ aCollectionOfLines
				do: [ :each | 
					exportedNodes addAll: each droppedNodes.
					each eol ifNotNil: [ :node | exportedNodes add: node ] ].
			^ self ].
	lastIndex := aCollectionOfLines size.
	context html
		tag: #p
		do: [ aCollectionOfLines
				withIndexDo: [ :each :index | 
					self writeContentOfTextLine: each.
					each eol
						ifNotNil: [ :node | 
							index < lastIndex
								ifTrue: [ self acceptNode: node ]
								ifFalse: [ exportedNodes add: node ] ] ] ]
]

{ #category : #'text lines' }
LeHtmlTextSnippetVisitor >> writeQuoteOfTextLines: aCollectionOfLines [
	"A line with only the `>` marker ends a paragraph of the quote."

	| paragraph |
	paragraph := OrderedCollection new.
	context html
		tag: #blockquote
		do: [ aCollectionOfLines
				do: [ :each | 
					each isEmpty
						ifTrue: [ self writeParagraphOfTextLines: paragraph.
							paragraph := OrderedCollection new.
							exportedNodes addAll: each droppedNodes.
							each eol ifNotNil: [ :node | exportedNodes add: node ] ]
						ifFalse: [ paragraph add: each ] ].
			self writeParagraphOfTextLines: paragraph ]
]

{ #category : #writing }
LeHtmlTextSnippetVisitor >> writeTableRow: aRow tag: aTag separator: aSeparator [
	exportedNodes add: aRow.
	context html
		tag: #tr
		do: [ aRow cells
				withIndexDo: [ :cell :index | 
					| alignment attributes |
					alignment := index <= aSeparator cells size
							ifTrue: [ (aSeparator cells at: index) alignment ]
							ifFalse: [ #default ].
					attributes := alignment = #default
							ifTrue: [ #() ]
							ifFalse: [ {'style'.
									'text-align: ' , alignment asString} ].
					context html
						tag: aTag
						attributes: attributes
						do: [ exportedNodes add: cell.
							cell parts do: [ :part | self acceptNode: part ] ] ] ]
]

{ #category : #writing }
LeHtmlTextSnippetVisitor >> writeTableSurroundingParts: parts [
	"Keep paragraphs and lists outside the table; do not wrap block tables in p elements."

	| lines |
	parts ifEmpty: [ ^ self ].
	(parts anySatisfy: [ :each | each isKindOf: LeHeaderNode ])
		ifTrue: [ parts do: [ :each | self acceptNode: each ].
			^ self ].
	lines := self textLinesIn: parts.
	(self groupTextLines: lines) do: [ :block | self writeBlockOfTextLines: block ]
]

{ #category : #'private - exporting' }
LeHtmlTextSnippetVisitor >> writeUnknownAnnotation: aDocumenterAnnotation [
	"Write an unknown or malformed annotation, for example {{gtFoo:bar}}, as it was typed, and log it"

	context html
		inlineTag: 'span'
		attributes: #('class' 'annotation annotation-unknown')
		with: aDocumenterAnnotation source.

	context log
		addItem: (LeExportUnresolvedAnnotationLogItem new
				snippet: snippet;
				annotation: aDocumenterAnnotation;
				reason: 'Unknown or malformed annotation: ' , aDocumenterAnnotation source).

	^ aDocumenterAnnotation

]
