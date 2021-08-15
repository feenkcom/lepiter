Class {
	#name : 'LePythonSnippet',
	#superclass : 'LeCodeSnippet',
	#category : 'Lepiter-Python-Snippet'
}

{ #category : 'api - accessing menu' }
LePythonSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'Python'
]

{ #category : 'lepiter-store' }
LePythonSnippet class >> leJsonV3Name [

	^ 'pythonSnippet'
]

{ #category : 'lepiter-store' }
LePythonSnippet class >> leJsonV4Name [

	^ 'pythonSnippet'
]

{ #category : 'visiting' }
LePythonSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitPythonSnippet: self
]

{ #category : 'converting' }
LePythonSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LePythonSnippetViewModel new snippetModel: self
]

{ #category : 'initialization' }
LePythonSnippet >> newCoder [
	^ GtPythonCoderModel new
]
