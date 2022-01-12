Class {
	#name : #LeJavaScriptVarNodeVisitor,
	#superclass : #Object,
	#traits : 'TJSProgramNodeVisitor',
	#classTraits : 'TJSProgramNodeVisitor classTrait',
	#instVars : [
		'initializedVarNodes',
		'declaredVarNodes',
		'letNodes',
		'varNodes',
		'stack'
	],
	#category : 'Lepiter-JavaScript'
}

{ #category : #accessing }
LeJavaScriptVarNodeVisitor >> allNames [
	"Answer all the variable names"

	^ ((initializedVarNodes , declaredVarNodes, letNodes) collect: [ :node |
			node variable name value. ]),
		(varNodes collect: [ :node | node name value. ])
]

{ #category : #accessing }
LeJavaScriptVarNodeVisitor >> allUndeclaredNames [
	"Answer the set of variable names that aren't declared (either as var or let)"

	^ self allNames difference: self declaredNames
]

{ #category : #accessing }
LeJavaScriptVarNodeVisitor >> declaredNames [
	"Answer all the declared names"

	^ (initializedVarNodes , declaredVarNodes, letNodes) collect: [ :node |
		node variable name value. ]
]

{ #category : #accessing }
LeJavaScriptVarNodeVisitor >> declaredVarNames [
	"Answer all the declared variable names"

	^ (initializedVarNodes , declaredVarNodes) collect: [ :node |
		node variable name value. ]
]

{ #category : #accessing }
LeJavaScriptVarNodeVisitor >> declaredVarNodes [

	^ declaredVarNodes
]

{ #category : #initialization }
LeJavaScriptVarNodeVisitor >> initialize [

	super initialize.
	initializedVarNodes := Set new.
	declaredVarNodes := Set new.
	varNodes := Set new.
	letNodes := Set new.
]

{ #category : #accessing }
LeJavaScriptVarNodeVisitor >> initializedVarNodes [

	^ initializedVarNodes
]

{ #category : #accessing }
LeJavaScriptVarNodeVisitor >> letNodes [

	^ letNodes
]

{ #category : #accessing }
LeJavaScriptVarNodeVisitor >> varNodes [

	^ varNodes
]

{ #category : #local }
LeJavaScriptVarNodeVisitor >> visitLexicalDeclaration: aLexicalDeclaration [

	aLexicalDeclaration bindings do: [ :binding|
		letNodes add: binding ].

]

{ #category : #local }
LeJavaScriptVarNodeVisitor >> visitNameExpression: aNameExpression [

	varNodes add: aNameExpression.
	^ self visitExpression: aNameExpression
]

{ #category : #local }
LeJavaScriptVarNodeVisitor >> visitVariableStatement: aVariableStatement [
	"Iterate over all the variables and add to the appropriate set"

	aVariableStatement variables do: [ :varDeclaration |
		varDeclaration value
			ifNil: [ declaredVarNodes add: varDeclaration ]
			ifNotNil: [ initializedVarNodes add: varDeclaration ] ].
	^ self visitStatement: aVariableStatement
]
