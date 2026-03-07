"
Preview attribute for gtSymbol annotations that can mark missing symbols.
"
Class {
	#name : #LeSymbolPreviewAttribute,
	#superclass : #GtResizablePreviewAttribute,
	#instVars : [
		'isDefined'
	],
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #initialization }
LeSymbolPreviewAttribute >> initialize [
	super initialize.
	isDefined := true
]

{ #category : #accessing }
LeSymbolPreviewAttribute >> isDefined [
	^ isDefined
]

{ #category : #accessing }
LeSymbolPreviewAttribute >> isDefined: aBoolean [
	isDefined := aBoolean
]
