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
		title: self description
]

{ #category : #accessing }
LePharoSnippet class >> description [
	^ 'Pharo'
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
	coder astSync
		allNodesOfType: GtPharoVariableNode
		do: [ :node | 
			(node whoDefines notNil or: [ Smalltalk globals includesKey: node variableName ])
				ifFalse: [ variables add: node variableName ] ].
	newAST body addTemporariesNamed: variables.
	newAST addPragma: (RBPragmaNode selector: #gtExample arguments: #()).
	newAST addReturn.
	^ newAST formattedCode
]

{ #category : #converting }
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

{ #category : #enumerating }
LePharoSnippet >> followingSnippets [
	^ self withFollowingSnippets allButFirst
]

{ #category : #enumerating }
LePharoSnippet >> indentAll [
	self withFollowingSnippets do: #indent
]

{ #category : #testing }
LePharoSnippet >> isForLocalImage [
	^ true
]

{ #category : #enumerating }
LePharoSnippet >> moveFollowingSnippetsToPage: pageName [
	"Use this to split a lepiter snippet by evaluating or inspecting this in a code
	snippet at the split point.
		thisSnippet moveFollowingSnippetsToPage: 'A page name'
	NB: If used in a top-level code snippet, it will move all following snippets
	of the page. If used within a nested snippet, it will only move the following
	children of that snippet in the tree.
	"

	| targetPage |
	targetPage := self page database ensurePageNamed: pageName.
	self followingSnippets
		do: [ :each | 
			self parent removeSnippet: each.
			targetPage addSnippet: each ].
	^ targetPage
]

{ #category : #initialization }
LePharoSnippet >> newCoder [
	^ GtPharoSnippetCoder new
]

{ #category : #enumerating }
LePharoSnippet >> unindentAll [
	self withFollowingSnippets reversed do: #unindent
]

{ #category : #enumerating }
LePharoSnippet >> withFollowingSnippets [
	"This snippet and all following children of the same parent.
	Sample usages:
		thisSnippet withFollowingSnippets do: #indent.
		thisSnippet withFollowingSnippets reversed do: #unindent.
	"
	| snippets stop start |
	snippets := self parent children asArray.
	start := snippets indexOf: self.
	stop := snippets size.
	^ snippets copyFrom: start to: stop
]
