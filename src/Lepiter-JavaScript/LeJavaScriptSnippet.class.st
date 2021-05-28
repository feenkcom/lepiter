"
A LeJavaScriptSnippet is an executable piece of JavaScript code, i.e. a script.

 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	code:		<String>


!!Implementation Points

"
Class {
	#name : #LeJavaScriptSnippet,
	#superclass : #LeCodeSnippet,
	#category : #'Lepiter-JavaScript-Snippet'
}

{ #category : #'api - accessing menu' }
LeJavaScriptSnippet class >> contextMenuItemSpefication [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'Javascript'
]

{ #category : #'lepiter-store' }
LeJavaScriptSnippet class >> leJsonV3Name [

	^ 'javascriptSnippet'
]

{ #category : #'lepiter-store' }
LeJavaScriptSnippet class >> leJsonV4Name [

	^ 'javascriptSnippet'
]

{ #category : #visiting }
LeJavaScriptSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitJavaScriptSnippet: self
]

{ #category : #converting }
LeJavaScriptSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeJavaScriptSnippetViewModel new snippetModel: self
]

{ #category : #initialization }
LeJavaScriptSnippet >> newCoder [
	^ GtJavaScriptCoderModel new
]
