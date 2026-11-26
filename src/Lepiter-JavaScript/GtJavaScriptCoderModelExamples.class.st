Class {
	#name : #GtJavaScriptCoderModelExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-JavaScript-Examples'
}

{ #category : #examples }
GtJavaScriptCoderModelExamples >> pageVariablesReturned [
	"A JavaScript snippet returns the page variables (Symbol names) it assigns, and the variables it declares.
	The parsed names are Strings"

	<gtExample>
	<return: #GtJavaScriptCoderModel>
	| coder bindings |
	bindings := GtSharedVariablesBindings new.
	(bindings bindingOf: #x) value: 42.
	coder := GtJavaScriptCoderModel new.
	coder pharoBindings: bindings.

	self
		assert: (self returnedNamesOf: 'x = x + 1' in: coder)
		equals: #('x').
	self
		assert: (self returnedNamesOf: 'var w = 1' in: coder)
		equals: #('w').
	self
		assert: (self returnedNamesOf: 'u = 1' in: coder)
		equals: #().
	^ coder
]

{ #category : #examples }
GtJavaScriptCoderModelExamples >> returnedNamesOf: aSourceString in: aCoder [
	| visitor |
	visitor := LeJavaScriptVarNodeVisitor new.
	visitor acceptNode: (JSParser parse: (SmaCCString on: aSourceString)).
	^ ((aCoder returnedVariableNamesFrom: visitor)
		collect: [ :each | each asString ]) asArray sort
]
