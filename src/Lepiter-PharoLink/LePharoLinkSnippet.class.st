Class {
	#name : #LePharoLinkSnippet,
	#superclass : #LeCodeSnippet,
	#category : #'Lepiter-PharoLink-Snippet'
}

{ #category : #'api - accessing menu' }
LePharoLinkSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'PharoLink'
]

{ #category : #'lepiter-store' }
LePharoLinkSnippet class >> leJsonV4Name [

	^ 'pharoLinkSnippet'
]

{ #category : #visiting }
LePharoLinkSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitPharoLinkSnippet: self
]

{ #category : #converting }
LePharoLinkSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LePharoLinkSnippetViewModel new snippetModel: self
]

{ #category : #initialization }
LePharoLinkSnippet >> newCoder [
	^ GtPharoLinkCoderModel new
]
