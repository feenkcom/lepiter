"
The PharoLink snippet allows you to write, execute and inspect Pharo code in a remote image.  On Mac and Linux the remote image can be managed automatically, on Windows the image must be started manually.
"
Class {
	#name : #LePharoLinkSnippet,
	#superclass : #LeCodeSnippet,
	#category : #'Lepiter-Snippet-PharoLink-Snippet'
}

{ #category : #'api - accessing menu' }
LePharoLinkSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'api - accessing menu' }
LePharoLinkSnippet class >> description [
	^ 'PharoLink'
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
		applicationStrategy: (LePharoLinkApplicationGlobalStrategy new content: self)
]
