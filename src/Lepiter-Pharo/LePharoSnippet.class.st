"
A LePharoSnippet is an executable piece of Pharo code, i.e. a script.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
## Internal Representation and Key Implementation Points.

### Instance Variables
	code:		<String>


## Implementation Points

"
Class {
	#name : #LePharoSnippet,
	#superclass : #LeCodeSnippet,
	#category : #'Lepiter-Pharo-Snippet'
}

{ #category : #accessing }
LePharoSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>

	^ LeContextMenuItemSpecification new
		priority: 2;
		snippetClass: self;
		title: 'Pharo'
]

{ #category : #accessing }
LePharoSnippet class >> leJsonV3Name [

	^ 'pharoSnippet'
]

{ #category : #accessing }
LePharoSnippet class >> leJsonV4Name [

	^ 'pharoSnippet'
]

{ #category : #visiting }
LePharoSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitPharoSnippet: self
]

{ #category : #converting }
LePharoSnippet >> asExampleMethodStringFor: aSelector [
	| newAST variables |
	newAST := RBParser parseMethod: aSelector , String cr , coder currentSourceText.
	variables := Set new.
	coder astAwait
		allNodesOfType: GtPharoVariableNode
		do: [ :node | 
			(node whoDefines notNil or: [ Smalltalk globals includesKey: node variableName ])
				ifFalse: [ variables add: node variableName ] ].
	newAST body addTemporariesNamed: variables.
	newAST addPragma: (RBPragmaNode selector: #gtExample arguments: #()).
	newAST addReturn.
	^ newAST formattedCode
]

{ #category : #accessing }
LePharoSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ LePharoSnippetViewModel new snippetModel: self
]

{ #category : #converting }
LePharoSnippet >> compileExampleMethod: aSelector in: aClass classified: aSymbol [
	| change newSource |
	newSource := self asExampleMethodStringFor: aSelector.
	change := RBAddMethodChange
		compile: newSource
		in: aClass
		classified: aSymbol.
	GtPharoCodeModifier current performRefactoryChange: change
]

{ #category : #converting }
LePharoSnippet >> convertToExample: aSelector in: aClass classified: aSymbol [
	self
		compileExampleMethod: aSelector
		in: aClass
		classified: aSymbol.
	self
		addSnippetAfterSelf:
			((LeExampleSnippet new)
				exampleBehaviorName: aClass name;
				exampleSelector: aSelector).
	self removeSelf
]

{ #category : #initialization }
LePharoSnippet >> newCoder [
	^ GtPharoSnippetCoder new
]
