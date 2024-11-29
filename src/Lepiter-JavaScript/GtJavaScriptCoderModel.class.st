"
GtJavaScriptCoderModel is a coder for JavaScript (obviously).

Variables that are used, but not declared, in the JS snippet and exist in the pharo bindings will have their value passed in and out.  Globally declared variables in the JS snippet will have their values passed out.

E.g. evaluating the following sequence of snippets:

```
phVar := 41.
```

```lang=javascript
var jsVar;
jsVar = ""hello, world"";
phVar += 1;
```

```
{ phVar, jsVar }
```

will result in an array with 42 and 'hello, world'.

"
Class {
	#name : #GtJavaScriptCoderModel,
	#superclass : #GtSourceCoder,
	#instVars : [
		'jsLinkApplicationStrategy',
		'pharoBindings'
	],
	#category : #'Lepiter-JavaScript-Coder'
}

{ #category : #converting }
GtJavaScriptCoderModel >> asCoderViewModel [

	^ GtSourceCoderViewModel new coder: self
]

{ #category : #'private - execution' }
GtJavaScriptCoderModel >> bindAndExecute: sourceString [
	"Answer the source code with all declared variables returned in an immediate dictionary"
	<gtIgnoreConstraint: #GtRBAcceptVisitorCalledFromNonVisitingMethods>
	| trimmedSource visitor ast lastStatement varNames jsBindings jsSource commandFactory application |

	trimmedSource := SmaCCString on: sourceString trimRight.
	visitor := LeJavaScriptVarNodeVisitor new.
	ast := JSParser parse: trimmedSource.
	ast acceptVisitor: visitor.
	"The variables to be returned are:
	1. globals declared in the code
	2. undeclared names that are in pharoBindings"
	varNames := visitor declaredVarNames, 
		(visitor allUndeclaredNames asSet intersection: pharoBindings bindingNames asSet).

	"Assign the final statement to snippetResult"
	lastStatement := ast items last.
	trimmedSource 
		insert: 'var snippetResult = ' 
		at: lastStatement startPosition.
	varNames add: 'snippetResult'.

	"Assign the current value to any variables that aren't initialised and are currently bound in the receiver"
	jsBindings := self jsBindingsFrom: visitor.

	"Get the final source to execute"
	jsSource := self sourceFrom: trimmedSource asString returnedVarNames: varNames.

	application := jsLinkApplicationStrategy applicationServer.
	application isRunning ifFalse: [ application start ].
	commandFactory := application newCommandFactory.
	jsBindings do: [ :binding |
		commandFactory addBinding: binding ].

	^ commandFactory
		<< jsSource;
		sendAndWait.

]

{ #category : #'api - ast' }
GtJavaScriptCoderModel >> computeAst: theSourceString [
	^ JSParser parseWithErrors: theSourceString
]

{ #category : #'api - ast' }
GtJavaScriptCoderModel >> implicitVariableReferencesTo: aString do: aBlock [
	self astSync allNodesOfType: JSNameExpressionNode do: [ :node | 
		node name source = aString ifTrue: [ 
			(node parent isKindOf: JSVariableDeclarationNode)
				ifTrue: [ ^ self ]
				ifFalse: [ aBlock value: node ] ] ]
]

{ #category : #initialize }
GtJavaScriptCoderModel >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: (GtCoderAstSmaCCParserStyler new smaccStyler: JSParser gtStyler).
	
	addOns
		addMainAction: 'Evaluate' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doIt
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItActionId.
	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doItAndGo
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.
]

{ #category : #initialize }
GtJavaScriptCoderModel >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderDoItShortcut new;
		addShortcut: GtSourceCoderDoItAndInspectShortcut new
]

{ #category : #'private - execution' }
GtJavaScriptCoderModel >> jsBindingsFrom: visitor [
	"Answer a collection of JS bindings for variables that aren't declared in the JS source and are in the snipets bindings"
	| jsBindings |

	jsBindings := OrderedCollection new.
	visitor allUndeclaredNames do: [ :name | | nameSymbol |
		nameSymbol := name asSymbol.
		(pharoBindings hasBindingOf: nameSymbol) ifTrue: 
			[ jsBindings add: (JSLinkBinding key: name wrap: (pharoBindings bindingOf: nameSymbol) value) ] ].
	^ jsBindings
]

{ #category : #accessing }
GtJavaScriptCoderModel >> jsLinkApplicationStrategy [
	^ jsLinkApplicationStrategy
]

{ #category : #accessing }
GtJavaScriptCoderModel >> jsLinkApplicationStrategy: anObject [
	jsLinkApplicationStrategy := anObject
]

{ #category : #'instance creation' }
GtJavaScriptCoderModel >> newCompletionStrategy [
	^ GtCompletionStrategy new
]

{ #category : #accessing }
GtJavaScriptCoderModel >> pharoBindings [
	^ pharoBindings
]

{ #category : #accessing }
GtJavaScriptCoderModel >> pharoBindings: anObject [
	pharoBindings := anObject
]

{ #category : #'private - actions' }
GtJavaScriptCoderModel >> primitiveDebug: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	self flag: #TODO
]

{ #category : #'private - actions' }
GtJavaScriptCoderModel >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| result |

	result := self bindAndExecute: aSourceString.
	
	result removeKey: '__jsLinkImmediate'.
	result associationsDo: [ :binding | (pharoBindings bindingOf: binding key asSymbol) value: binding value ].

	^ result
		at: 'snippetResult'
		ifAbsent: anEvaluationFailBlock
]

{ #category : #'private - execution' }
GtJavaScriptCoderModel >> sourceFrom: trimmedSourceString returnedVarNames: varNames [
	"Answer the modified source to return the declared variables"

	^ String streamContents: [ :stream |
		stream << trimmedSourceString.
		trimmedSourceString last = $; ifFalse:
			[ stream nextPut: $; ].
		stream 
			cr
			<< '{ '.
		varNames do: [ :varName |
			stream 
				<< varName;
				<< ': ';
				<< varName;
				<< ', ' ].
		"Answer the variable dictionary as an immediate object"
		stream
			<< '__jsLinkImmediate: true }' ]
]

{ #category : #accessing }
GtJavaScriptCoderModel >> variableBindings: aGtSnippetBindings [

	^ self pharoBindings: aGtSnippetBindings
]
