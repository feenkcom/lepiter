Class {
	#name : 'LeGemStoneSnippet',
	#superclass : 'LeCodeSnippet',
	#category : 'Lepiter-Snippet-GemStone-Snippet'
}

{ #category : 'api - accessing menu' }
LeGemStoneSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'GemStone'
]

{ #category : 'lepiter-store' }
LeGemStoneSnippet class >> leJsonV4Name [

	^ 'gemstoneSnippet'
]

{ #category : 'visiting' }
LeGemStoneSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitGemStoneSnippet: self
]

{ #category : 'converting' }
LeGemStoneSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeGemStoneSnippetViewModel new snippetModel: self
]

{ #category : 'initialization' }
LeGemStoneSnippet >> newCoder [
	^ GtGemStoneCoderModel new
]
