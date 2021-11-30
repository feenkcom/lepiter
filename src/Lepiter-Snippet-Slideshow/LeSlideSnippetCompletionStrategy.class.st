Class {
	#name : #LeSlideSnippetCompletionStrategy,
	#superclass : #GtPharoCompletionStrategy,
	#instVars : [
		'snippetVariables'
	],
	#category : 'Lepiter-Snippet-Slideshow-Slide'
}

{ #category : #'initialize-release' }
LeSlideSnippetCompletionStrategy >> initialize [
	super initialize.
	self isMethod: false.
	self hasImplicitVariables: true.
	snippetVariables := GtPrefixTree new
]

{ #category : #'private-variables' }
LeSlideSnippetCompletionStrategy >> localVariablesFor: aVariableNode [
	| vars |
	vars := super localVariablesFor: aVariableNode.
	snippetVariables
		weightedDo: [ :each :weight | vars add: each weight: weight ].
	vars remove: aVariableNode source ifAbsent: [  ].
	^ vars
]

{ #category : #accessing }
LeSlideSnippetCompletionStrategy >> snippetVariables [
	^ snippetVariables
]

{ #category : #accessing }
LeSlideSnippetCompletionStrategy >> snippetVariables: anObject [
	snippetVariables := anObject
]
