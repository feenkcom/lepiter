"
I exemplify {{gtClass:LeParser}}. 


"
Class {
	#name : #LeParserExamples,
	#superclass : #Object,
	#category : #'Lepiter-Parser'
}

{ #category : #'examples - annotations' }
LeParserExamples >> annotationNameLink [
	<gtExample>
	<return: #LeStringNode>
	| aNode found |
	aNode := self parse: '{{gtPage:pageName|db=594qh2fnllvcrdj2nmd623mmg}}'.
	found := false.
	aNode
		allNodesDo: [ :each | 
			(each isKindOf: LePageAnnotationNode)
				ifTrue: [ found := true.
					self assert: each nameNode value value equals: 'pageName'.
					self assert: each dbUuidString equals: '594qh2fnllvcrdj2nmd623mmg' ] ].
	self assert: found.
	^ aNode
]

{ #category : #'examples - annotations' }
LeParserExamples >> annotationUidLink [
	<gtExample>
	<return: #LeStringNode>
	| aNode found |
	aNode := self
			parse: '{{gtPage:id=594qh2fnllvcrdj2nmd623mmh|db=594qh2fnllvcrdj2nmd623mmg}}'.
	found := false.
	aNode
		allNodesDo: [ :each | 
			(each isKindOf: LePageAnnotationNode)
				ifTrue: [ found := true.
					self assert: each pageUidString equals: '594qh2fnllvcrdj2nmd623mmh'.
					self assert: each dbUuidString equals: '594qh2fnllvcrdj2nmd623mmg' ] ].
	self assert: found.
	^ aNode
]

{ #category : #'examples - links' }
LeParserExamples >> blockLink [
	<gtExample>
	<return: #LeStringNode>
	| aNode |
	aNode := self parse: '((4JsRVB4jq))'.
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 1.
	self assert: aNode parts first class equals: LeBlockLinkNode.
	self assert: aNode parts first linkUID equals: '4JsRVB4jq'.
	^ aNode
]

{ #category : #'examples - markdown' }
LeParserExamples >> bold [
	<gtExample>
	<return: #LeStringNode>
	| node bold |
	node := self
			parse: '**bold** not bold **bold**' , String cr , '****** stars' , String cr
					, 'line with **bold** item'.
	bold := node parts select: [ :each | each isKindOf: LeBoldNode ].
	self assert: bold size equals: 3.
	bold
		do: [ :each | 
			self assert: each parts size equals: 1.
			self assert: each parts first source equals: 'bold' ].
	^ node
]

{ #category : #'examples - markdown' }
LeParserExamples >> boldItalic [
	<gtExample>
	<return: #LeStringNode>
	| node bold italic boldItalic |
	node := self
			parse: '***bold**italic*' , String cr , '***italic*bold**' , String cr , '***both***'.
	bold := node parts select: [ :each | each isKindOf: LeBoldNode ].
	italic := node parts select: [ :each | each isKindOf: LeItalicNode ].
	self assert: bold size + italic size equals: 3.
	self assert: bold first parts first class equals: LeItalicNode.
	self assert: italic first parts first class equals: LeBoldNode.
	boldItalic := bold size > 1 ifTrue: [ bold last ] ifFalse: [ italic last ].
	self assert: boldItalic class ~= boldItalic parts first class.
	self
		assert: ({LeItalicNode.
				LeBoldNode} includes: boldItalic parts first class).
	^ node
]

{ #category : #'examples - markdown' }
LeParserExamples >> boldWithAStar [
	<gtExample>
	<return: #LeStringNode>
	| node bold |
	node := self parse: '**b*ld**'.
	bold := node parts select: [ :each | each isKindOf: LeBoldNode ].
	self assert: bold size equals: 1.
	bold
		do: [ :each | 
			self assert: each parts size equals: 3.
			self assert: each parts second source equals: '*' ].
	^ node
]

{ #category : #'examples - links' }
LeParserExamples >> bracketLink [
	<gtExample>
	<return: #LeStringNode>
	| aNode |
	aNode := self parse: '[[link one with kůň]]'.
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 1.
	self assert: aNode parts first class equals: LeDoubleBracketLinkNode.
	self assert: aNode parts first linkUID equals: 'link one with kůň'.
	^ aNode
]

{ #category : #'examples - markdown' }
LeParserExamples >> bracketedLink [
	<gtExample>
	<return: #LeStringNode>
	| node italic link |
	node := self
			parse: 'A *little* vinegar might help suspend hard water deposits (see [here](https://littlehouseinthesuburbs.com/baking-soda-and-vinegar))'.
	self assert: node parts size equals: 7.
	italic := node parts second.
	self assert: italic parts size equals: 1.
	self assert: italic parts first text value equals: 'little'.
	link := node parts at: 6.
	self assert: link label equals: 'here'.
	self
		assert: link url
		equals: 'https://littlehouseinthesuburbs.com/baking-soda-and-vinegar'.
	^ node
]

{ #category : #'examples - annotations' }
LeParserExamples >> changesAnnotation [
	<gtExample>
	<return: #LeStringNode>
	| aNode found |
	aNode := self parse: '{{gtChanges:directory/filename 1.ombu|height=400}}'.
	found := false.
	aNode
		allNodesDo: [ :each | 
			(each isKindOf: LeChangesAnnotationNode)
				ifTrue: [ found := true.
					self assert: each filename equals: 'directory/filename 1.ombu'.
					self assert: each height equals: 400.
					self assert: each labelNode isNil ] ].
	self assert: found.
	^ aNode
]

{ #category : #'examples - annotations' }
LeParserExamples >> classAnnotation [
	<gtExample>
	<return: #LeStringNode>
	| aNode found |
	aNode := self parse: '{{gtClass:Object class|label=#superclass}}'.
	found := false.
	aNode
		allNodesDo: [ :each | 
			(each isKindOf: LeClassAnnotationNode)
				ifTrue: [ found := true.
					self assert: each imageObject equals: Object class.
					self assert: each labelNode notNil ] ].
	self assert: found.
	^ aNode
]

{ #category : #'examples - markdown' }
LeParserExamples >> codeBlock [
	<gtExample>
	<return: #LeStringNode>
	| node codeBlocks |
	node := self
			parse: '```Smalltalk
Transcript show: 3 + 4 printString; cr
```

```
Unknown.language
```

```js
console.log(3 + 4);
```
'.
	codeBlocks := node parts select: [ :each | each isKindOf: LeCodeBlockNode ].
	self assert: codeBlocks size equals: 3.
	self assert: codeBlocks first language source equals: 'Smalltalk'.
	self
		assert: codeBlocks first code source trim
		equals: 'Transcript show: 3 + 4 printString; cr'.
	self assert: codeBlocks second language isNil.
	self assert: codeBlocks second code source trim equals: 'Unknown.language'.
	self assert: codeBlocks third language source equals: 'js'.
	self assert: codeBlocks third code source trim equals: 'console.log(3 + 4);'.
	^ node
]

{ #category : #'examples - empty links' }
LeParserExamples >> emptyBracketLink [
	<gtExample>
	<return: #LeStringNode>
	| aNode |
	aNode := self parse: '[[]]'.
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 1.
	self assert: aNode parts first class equals: LeEmptyDoubleBracketLinkNode.
	^ aNode
]

{ #category : #accessing }
LeParserExamples >> emptyBracketLink_Incomplete [
	<gtExample>
	<return: #LeStringNode>
	| aNode |
	aNode := self parse: '[[]'.
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 1.
	self assert: aNode parts first class equals: LeEmptyDoubleBracketLinkNode.
	^ aNode
]

{ #category : #'examples - links' }
LeParserExamples >> emptyLabelImageLink [
	<gtExample>
	<return: #LeStringNode>
	| aNode url linkNode |
	url := 'https://example.com'.
	aNode := self
			parse: (String
					streamContents: [ :s | 
						s
							<< 'Image';
							lf;
							<< '![';
							<< '](';
							<< url;
							<< ')' ]).
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size >= 2.
	linkNode := aNode parts last.
	self assert: linkNode class equals: LeExternalImageLinkNode.
	self assert: linkNode url equals: url.
	^ aNode
]

{ #category : #'examples - annotations' }
LeParserExamples >> exampleSnippet [
	<gtExample>
	<return: #LeStringNode>
	| aNode found method |
	method := thisContext method.
	aNode := self parse: '{{gtExample:LeParserExamples>>exampleSnippet}}'.
	found := false.
	aNode
		allNodesOfType: LeExampleAnnotationNode
		do: [ :each | 
			found := true.
			self assert: each imageObject compiledMethod equals: method.
			self assert: each labelNode isNil ].
	self assert: found.
	^ aNode
]

{ #category : #'examples - links' }
LeParserExamples >> externalImageLink [
	<gtExample>
	<return: #LeStringNode>
	| aNode label url linkNode |
	label := 'link label'.
	url := 'https://example.com'.
	aNode := self
			parse: (String
					streamContents: [ :s | 
						s
							<< 'Image';
							lf;
							<< '![';
							<< label;
							<< '](';
							<< url;
							<< ')' ]).
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size >= 2.
	linkNode := aNode parts last.
	self assert: linkNode class equals: LeExternalImageLinkNode.
	self assert: linkNode url equals: url.
	self assert: linkNode label equals: label.
	^ aNode
]

{ #category : #'examples - links' }
LeParserExamples >> externalLabelUrlLink [
	<gtExample>
	<return: #LeStringNode>
	| aNode label url |
	label := 'link label'.
	url := 'https://example.com'.
	aNode := self
			parse: (String
					streamContents: [ :s | 
						s
							<< '[';
							<< label;
							<< '](';
							<< url;
							<< ')' ]).
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 1.
	self assert: aNode parts first class equals: LeExternalLabelUrlLinkNode.
	self assert: aNode parts first url equals: url.
	self assert: aNode parts first label equals: label.
	^ aNode
]

{ #category : #'examples - links' }
LeParserExamples >> externalLabelUrlLinkWithSpace [
	<gtExample>
	<return: #LeStringNode>
	| aNode label url |
	label := 'link label'.
	url := 'file://attachments/a file.txt'.
	aNode := self
			parse: (String
					streamContents: [ :s | 
						s
							<< '[';
							<< label;
							<< '](';
							<< url;
							<< ')' ]).
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 1.
	self assert: aNode parts first class equals: LeExternalLabelUrlLinkNode.
	self assert: aNode parts first url equals: url.
	self assert: aNode parts first label equals: label.
	^ aNode
]

{ #category : #'examples - links' }
LeParserExamples >> externalUrlLink [
	<gtExample>
	<return: #LeStringNode>
	| aNode url |
	url := 'https://example.com'.
	aNode := self
			parse: (String
					streamContents: [ :s | 
						s
							<< '<';
							<< url;
							<< '>' ]).
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 1.
	self assert: aNode parts first class equals: LeExternalUrlLinkNode.
	self assert: aNode parts first url equals: url.
	^ aNode
]

{ #category : #'examples - markdown' }
LeParserExamples >> headerWithInitialSpaces [
	<gtExample>
	<return: #LeStringNode>
	| node header |
	node := self parse: '# Title 1'.
	node allNodesOfType: LeHeaderNode do: [ :each | header := each ].
	self assert: header hidingStartPosition equals: 1.
	self assert: header hidingStopPosition equals: 2.
	self
		assert: (node source copyFrom: header hidingStartPosition to: header hidingStopPosition)
		equals: '# '.

	^ node
]

{ #category : #'examples - markdown' }
LeParserExamples >> headerWithInitialSpaces2 [
	<gtExample>
	<return: #LeStringNode>
	| node header |
	node := self parse: '#    	(Ahoj  )'.
	node allNodesOfType: LeHeaderNode do: [ :each | header := each ].
	self assert: header hidingStartPosition equals: 1.
	self assert: header hidingStopPosition equals: 6.
	self
		assert: (node source copyFrom: header hidingStartPosition to: header hidingStopPosition)
		equals: '#    	'.

	^ node
]

{ #category : #'examples - markdown' }
LeParserExamples >> headerWithoutInitialSpaces [
	<gtExample>
	<return: #LeStringNode>
	| node header |
	node := self parse: '#Title 1'.
	node allNodesOfType: LeHeaderNode do: [ :each | header := each ].
	self assert: header hidingStartPosition equals: 1.
	self assert: header hidingStopPosition equals: 1.
	self
		assert: (node source copyFrom: header hidingStartPosition to: header hidingStopPosition)
		equals: '#'.

	^ node
]

{ #category : #'examples - markdown' }
LeParserExamples >> headers [
	<gtExample>
	<return: #LeStringNode>
	| node headers |
	node := self
			parse: '#header with a #text' , String cr , String cr , '## h2' , String cr , '### h3'.
	headers := node parts select: [ :each | each isKindOf: LeHeaderNode ].
	self assert: headers size equals: 3.
	1
		to: headers size
		do: [ :i | self assert: (headers at: i) numberSigns size equals: i ].
	^ node
]

{ #category : #'examples - markdown' }
LeParserExamples >> headers2 [
	<gtExample>
	<return: #LeStringNode>
	| node headers |
	node := self
			parse: '# I am __Header One (Letter A)__' , String cr , String cr
					, '## I am *Header Two {Letter B}*' , String cr
					, '### I am {{gtClass:BrButton}} header' , String cr , '#### 中国 header'.
	headers := node parts select: [ :each | each isKindOf: LeHeaderNode ].
	self assert: headers size equals: 4.
	1
		to: headers size
		do: [ :i | self assert: (headers at: i) numberSigns size equals: i ].
	^ node
]

{ #category : #'examples - markdown' }
LeParserExamples >> inlineCode [
	<gtExample>
	<return: #LeStringNode>
	| node code |
	node := self parse: '`code` not code ``co`de``'.
	code := node parts select: [ :each | each isKindOf: LeInlineCodeNode ].
	self assert: code size equals: 2.
	self assert: code first source equals: '`code`'.
	self assert: code last source equals: '``co`de``'.
	^ node
]

{ #category : #'examples - markdown' }
LeParserExamples >> italic [
	<gtExample>
	<return: #LeStringNode>
	| node italic |
	node := self
			parse: '*italic* not bold *italic*' , String cr , '****** stars' , String cr
					, 'line with *italic* item'.
	italic := node parts select: [ :each | each isKindOf: LeItalicNode ].
	self assert: italic size equals: 3.
	italic
		do: [ :each | 
			self assert: each parts size equals: 1.
			self assert: each parts first source equals: 'italic' ].
	^ node
]

{ #category : #'examples - links' }
LeParserExamples >> keywordLink [
	<gtExample>
	<return: #LeStringNode>
	| aNode |
	aNode := self parse: 'diagram::'.
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 1.
	self assert: aNode parts first class equals: LeKeywordLinkNode.
	self assert: aNode parts first linkUID equals: 'diagram'.
	^ aNode
]

{ #category : #'examples - links' }
LeParserExamples >> keywordLinkFollowedByText [
	<gtExample>
	<return: #LeStringNode>
	| aNode |
	aNode := self parse: 'kůň diagram:: text one'.
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 2.
	self assert: aNode parts first class equals: LeKeywordLinkNode.
	self assert: aNode parts first linkUID equals: 'kůň diagram'.
	self assert: aNode parts second class equals: LeTextNode.
	self assert: aNode parts second content equals: ' text one'.
	^ aNode
]

{ #category : #'examples - links' }
LeParserExamples >> keywordLinkWithTwoWords [
	<gtExample>
	<return: #LeStringNode>
	| aNode |
	aNode := self parse: 'kůň diagram::'.
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 1.
	self assert: aNode parts first class equals: LeKeywordLinkNode.
	self assert: aNode parts first linkUID equals: 'kůň diagram'.
	^ aNode
]

{ #category : #'examples - annotations' }
LeParserExamples >> methodAnnotation [
	<gtExample>
	<return: #LeStringNode>
	| aNode found |
	aNode := self parse: '{{gtMethod:Object>>printString|expanded}}'.
	found := false.
	aNode
		allNodesDo: [ :each | 
			(each isKindOf: LeMethodAnnotationNode)
				ifTrue: [ found := true.
					self assert: each imageObject compiledMethod equals: Object >> #printString.
					self assert: each labelNode isNil.
					self assert: each expanded ] ].
	self assert: found.
	^ aNode
]

{ #category : #'examples - annotations' }
LeParserExamples >> packageAnnotation [
	<gtExample>
	<return: #LeStringNode>
	| aNode found |
	aNode := self parse: '{{gtPackage:GToolkit-Coder}}'.
	found := false.
	aNode
		allNodesDo: [ :each | 
			(each isKindOf: LePackageAnnotationNode)
				ifTrue: [ found := true.
					self assert: (each imageObject isKindOf: RPackage).
					self assert: each tag isNil ] ].
	self assert: found.
	^ aNode
]

{ #category : #'examples - annotations' }
LeParserExamples >> packageTagAnnotation [
	<gtExample>
	<return: #LeStringNode>
	| aNode found |
	aNode := self parse: '{{gtPackage:GToolkit-Coder|tag=Ast}}'.
	found := false.
	aNode
		allNodesDo: [ :each | 
			(each isKindOf: LePackageAnnotationNode)
				ifTrue: [ found := true.
					self assert: (each imageObject isKindOf: RPackageTag).
					self assert: each tag notNil ] ].
	self assert: found.
	^ aNode
]

{ #category : #'examples - support' }
LeParserExamples >> parse: aString [
	<gtExample>
	| aResult |
	aResult := self parser parse: aString.
	self assert: aResult isNotNil.
	^ aResult
]

{ #category : #'examples - support' }
LeParserExamples >> parser [
	<gtExample>
	<return: #'LeParser class'>
	^ LeParser
]

{ #category : #'examples - links' }
LeParserExamples >> specialCharacterBracketLink [
	<gtExample>
	<return: #LeStringNode>
	| node source links |
	source := '[[a:b]]
[[a[b]]
[[a]c]]
[[a[b]c]]
[[a{b]]
[[a}d]]
[[a{b}c]]
[[a!]]
[[a(b]]
[[a)b]]
[[a(b)c]]
[[a*b]]
[[a<b]]
[[a>b]]
[[a<b>c]]
[[a\b]]
[[a?]]'.
	node := self parse: source.
	links := OrderedCollection new.
	node allNodesOfType: LeDoubleBracketLinkNode do: [ :each | links add: each ].
	self assert: links size equals: source lines size.
	^ node
]

{ #category : #'examples - strings' }
LeParserExamples >> text [
	<gtExample>
	<return: #LeStringNode>
	| aNode |
	aNode := self parse: 'text one with žížala'.
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 1.
	self assert: aNode parts first class equals: LeTextNode.
	^ aNode
]

{ #category : #accessing }
LeParserExamples >> textAndLinkAndURL [
	<gtExample>
	<return: #LeStringNode>
	| aNode |
	aNode := self
			parse: 'text one! [[link one]] text two https://example.com and <https://example.com>'.
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 8.
	self assert: aNode parts fourth class equals: LeDoubleBracketLinkNode.
	self assert: (aNode parts at: 8) class equals: LeExternalUrlLinkNode.
	^ aNode
]

{ #category : #'examples - strings' }
LeParserExamples >> textAndLinks [
	<gtExample>
	<return: #LeStringNode>
	| aNode |
	aNode := self parse: 'text one [[link one]] text two [[link two]] text three'.
	self assert: aNode class equals: LeStringNode.
	self assert: aNode parts size equals: 5.
	self assert: aNode parts first class equals: LeTextNode.
	self assert: aNode parts second class equals: LeDoubleBracketLinkNode.
	self assert: aNode parts third class equals: LeTextNode.
	self assert: aNode parts fourth class equals: LeDoubleBracketLinkNode.
	self assert: aNode parts fifth class equals: LeTextNode.
	^ aNode
]

{ #category : #'examples - annotations' }
LeParserExamples >> unknownAnnotation [
	<gtExample>
	<return: #LeStringNode>
	| aNode annotationNode |
	aNode := LeParser parseWithErrors: '{{unknownAnnotation:something}}'.
	annotationNode := aNode parts first.
	self assert: (annotationNode isKindOf: LeDocumenterAnnotationNode).
	self assert: annotationNode right source equals: '}}'.
	^ aNode
]
