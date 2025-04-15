"
I am the model for a single text snippet. 
The following example display one {{gtClass:LePage|label=page}} with three blocks in a tree structure: {{gtExample:LeContentExamples>>#pageOneWithTwoSnippetsAndWithSnippetChild|noCode}} 
## Properties
Common properties that can be accessed from a LeSnippet include:
- {{gtMethod:LeTextSnippet>>#text|label=#selector}} is a  [Markdown](https://en.wikipedia.org/wiki/Markdown) text as a {{gtClass:BlText}} instance,
- {{gtMethod:LeSnippet>>#parent|label=#selector}} that can be either another {{gtClass:LeSnippet}} or {{gtClass:LePage}},
- {{gtMethod:LeSnippet>>#page|label=#selector}}  is a {{gtClass:LePage}} or nil,
- {{gtMethod:LeSnippet>>#topBlock|label=#selector}} is a {{gtClass:LeSnippet}} or nil,
- {{gtMethod:LeContent>>#children|label=#selector}} is a collection of other {{gtClass:LeSnippet}} instances.
Additional properties can be found in `api - accessing`.
## Initialization
The {{gtMethod:LeTextSnippet>>#text|label=#selector}} is **initialized** either using {{gtMethod:LeTextSnippet>>#text:|label=#selector}} or {{gtMethod:LeTextSnippet>>#string:|label=#selector}}.  The former one is useful particularly for the json reader and writer.
From a UI, new {{gtClass:LeSnippet}} can be created (added as my children) using {{gtMethod:LeContent>>#blockBuilder|label=#selector}}: {{gtExample:LeContentExamples>>#textSnippetInPageAndDatabase}} 
## Updates
A number of methods for **updating** text are provided (mirroring the protocol for {{gtClass:BlText}}:
- {{gtMethod:LeTextSnippet>>#updateText:source:|label=#selector}}
- {{gtMethod:LeTextualSnippet>>#updateString:|label=#selector}}
- {{gtMethod:LeTextSnippet>>#appendText:source:|label=#selector}}
- {{gtMethod:name=LeTextSnippet>>#insertText:at:|label=#selector}}

 {{gtExample:LeDatabaseSnippetUpdaterExamples>>#updateSnippetOneToTwo_Simplified_Text}} {{gtExample:LeDatabaseSnippetUpdaterExamples>>#updateSnippetOneToTwo_Simplified_String}} 
 

Text editors are responsible for using a copy of {{gtMethod:LeTextSnippet>>#text|label=#selector}} since sharing {{gtClass:BlTextAttribute|label=text attributes}}  may produces undesired (and undefinied) behavior. {{gtClass:BlText}} is not thread safe, it therefore cannot be edited simultaneously in several editors.
The text is stored as a {{gtClass:BlText}} (rather than a {{gtClass:String}}) since converting text to strings is expensive, and this would be done on every keystroke while editing in the UI.
## Navigation
A number of methods for navigating betwee blocks are provided, including:

- {{gtMethod:name=LeSnippet>>#previousSibling}}
- {{gtMethod:name=LeSnippet>>#nextSibling}}
- {{gtMethod:name=LeSnippet>>#previousBlockDo:ifNone:}}
- {{gtMethod:name=LeSnippet>>#nextBlockDo:ifNone:}}

next and previousBlockDo... are based on the user expectations of editing paragraphs in a text editor, i.e. the previous block is the deepest last child of the block's previous subling.


"
Class {
	#name : #LeTextSnippet,
	#superclass : #LePlainTextSnippet,
	#instVars : [
		'paragraphStyle'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #accessing }
LeTextSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		priority: 1;
		snippetClass: self;
		title: self description
]

{ #category : #accessing }
LeTextSnippet class >> description [
	^ 'Text'
]

{ #category : #accessing }
LeTextSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#paragraphStyle -> #paragraphStyle);
		add: (#string -> #string);
		yourself
]

{ #category : #accessing }
LeTextSnippet class >> leJsonV3Name [

	^ 'textSnippet'
]

{ #category : #accessing }
LeTextSnippet class >> leJsonV4AttributeMapping [

	"Using 'allButLast' below is a hack-ish way of not changing the serialized json for a page. By moving #string to the superclass the order of the two attributes changed. We try and preserve the same order."
	^ super leJsonV4AttributeMapping allButLast
		add: (#paragraphStyle -> #paragraphStyle);
		add: (#string -> #string);
		yourself
]

{ #category : #accessing }
LeTextSnippet class >> leJsonV4Name [

	^ 'textSnippet'
]

{ #category : #visiting }
LeTextSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitTextSnippet: self
]

{ #category : #converting }
LeTextSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ LeTextCoderSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeTextSnippet >> changeToRenameClass: oldName to: newName [
	| modifiedSource |
	modifiedSource := SmaCCString on: self string.
	self ast
		withAllNodesDo: [ :node | 
			((node isKindOf: LeClassNameArgumentNode) and: [ node className = oldName ])
				ifTrue: [ modifiedSource
						replaceFrom: node value startPosition
						to: node value stopPosition
						with: newName ] ]
		andTokensDo: [ :token |  ]
		includesErrors: true.
	modifiedSource isModified ifFalse: [ ^ nil ].
	^ LeSnippetChange new
		snippet: self;
		newSource: modifiedSource asString;
		yourself
]

{ #category : #accessing }
LeTextSnippet >> changeToRenameSelector: oldName to: newName using: aRewriter [
	| modifiedSource |
	modifiedSource := SmaCCString on: self string.
	self ast
		withAllNodesDo: [ :node | 
			| firstIsHash selector |
			(node isKindOf: LeMethodNameArgumentNode)
				ifTrue: [ selector := node selector value.
					firstIsHash := selector first = $#.
					firstIsHash ifTrue: [ selector := selector allButFirst ].
					selector = oldName
						ifTrue: [ modifiedSource
								replaceFrom: node selector startPosition
								to: node selector stopPosition
								with: (firstIsHash ifTrue: [ '#' ] ifFalse: [ '' ]) , newName ] ] ]
		andTokensDo: [ :token |  ]
		includesErrors: true.
	modifiedSource isModified ifFalse: [ ^ nil ].
	^ LeSnippetChange new
		snippet: self;
		newSource: modifiedSource asString;
		yourself
]

{ #category : #accessing }
LeTextSnippet >> classAndSelectorReferencesPromise [
	^ [ | classes selectors |
	classes := Set new.
	selectors := Set new.
	self ast
		withAllNodesDo: [ :node | 
			(node isKindOf: LeClassNameArgumentNode)
				ifTrue: [ classes add: node className.
					(node isKindOf: LeMethodNameArgumentNode)
						ifTrue: [ | selector |
							selector := node selector value.
							selector first = $# ifTrue: [ selector := selector allButFirst ].
							selectors add: selector ] ] ]
		andTokensDo: [ :token |  ]
		includesErrors: true.
	{classes.
		selectors} ] asAsyncPromise
]

{ #category : #defaults }
LeTextSnippet >> defaultParagraphStyle [
	^ LeParagraphStyle text
]

{ #category : #converting }
LeTextSnippet >> fromStonMapKey: key value: value [

	super fromStonMapKey: key value: value.
	(key = #heading and: [ value isNotNil ]) ifTrue:
		[ self heading: value ].
]

{ #category : #accessing }
LeTextSnippet >> headers [
	^ self ast // #LeHeaderNode collect: [ :val | val headerName asString ]
]

{ #category : #'api - accessing' }
LeTextSnippet >> heading [
	<return: #Integer or: nil>
	^ self paragraphStyle level
]

{ #category : #'api - accessing' }
LeTextSnippet >> heading: anInteger [
	paragraphStyle := LeParagraphStyle heading: anInteger
]

{ #category : #initialization }
LeTextSnippet >> initialize [
	super initialize.
	paragraphStyle := self defaultParagraphStyle.
]

{ #category : #'api - testing' }
LeTextSnippet >> isTextSnippet [

	^ true
]

{ #category : #'api - accessing' }
LeTextSnippet >> paragraphStyle [
	<return: #LeParagraphStyle>
	^ paragraphStyle 
]

{ #category : #'api - accessing' }
LeTextSnippet >> paragraphStyle: aLeParagraphStyle [

	paragraphStyle := aLeParagraphStyle
]

{ #category : #'private - updating' }
LeTextSnippet >> reloadSnippetSpecificAttributesFromContent: aLeSnippet [
	"Reload the receiver's attributes from the supplied snippet"
	| changed |
	
	changed := super reloadSnippetSpecificAttributesFromContent: aLeSnippet.
	paragraphStyle = aLeSnippet paragraphStyle ifFalse:
		[ paragraphStyle := aLeSnippet paragraphStyle.
		changed := true ].
	
	^ changed
]

{ #category : #converting }
LeTextSnippet >> roamJsonStringContent: aString [
	"Convert short UIDs to UUIDs"
	| snippetDictionary |
	
	snippetDictionary := { 'string' -> aString } asDictionary.
	LeJsonV4000Updater new 
		updateSnippetLinks: snippetDictionary.
			
	self string: (snippetDictionary at: 'string') 
]

{ #category : #accessing }
LeTextSnippet >> todoAnnotations [
	^ self ast // #LeTodoAnnotationNode
]
