"
Styler for gtSymbol annotations.
"
Class {
	#name : #LeSymbolAnnotationStyler,
	#superclass : #LeComponentStyler,
	#traits : 'TLeSymbolParseNodeVisitor',
	#classTraits : 'TLeSymbolParseNodeVisitor classTrait',
	#instVars : [
		'elements',
		'expanded'
	],
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #initialization }
LeSymbolAnnotationStyler class >> initialize [
	LeSnippetStylerVisitor additionalStylers add: self
]

{ #category : #initialization }
LeSymbolAnnotationStyler class >> obsolete [
	LeSnippetStylerVisitor additionalStylers remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #accessing }
LeSymbolAnnotationStyler >> expanded [
	^ self composite expanded
]

{ #category : #initialization }
LeSymbolAnnotationStyler >> initialize [
	super initialize.
	elements := nil.
	expanded := nil
]

{ #category : #accessing }
LeSymbolAnnotationStyler >> snippetViewModel [
	^ self composite snippetViewModel
]

{ #category : #private }
LeSymbolAnnotationStyler >> styleAnnotation: aSymbolAnnotation [
	(self text
		from: aSymbolAnnotation parent startPosition
		to: aSymbolAnnotation parent stopPosition)
		foreground: BrGlamorousColors textMarkupColor
]

{ #category : #private }
LeSymbolAnnotationStyler >> styleButton: aSymbolAnnotation [
	| attribute label symbolValue isDefined |
	aSymbolAnnotation hasSymbolNameSpecified ifFalse: [ ^ self ].
	isDefined := aSymbolAnnotation isDefined.
	symbolValue := aSymbolAnnotation symbolValue.
	symbolValue ifNil: [ ^ self ].
	attribute := GtButtonAttribute new
		beAppend;
		stencil: [ | button |
			label := '#', aSymbolAnnotation symbolName.
			button := LeSnippetStylerVisitor
				textLinkButtonPadding: (BlInsets top: 2)
				margin: BlInsets empty
				valid: true.
			button aptitude glamorousCodeFont.
			button
				beSmallSize;
				label: label;
				action: [ :aButton | aButton phlow spawnObject: symbolValue gtReferences ].
			button ].
	self text
		attribute: attribute
		from: aSymbolAnnotation parent startPosition
		to: aSymbolAnnotation parent stopPosition
]

{ #category : #private }
LeSymbolAnnotationStyler >> styleExpandingObject: aSymbolAnnotation [
	| symbolValue cacheKey attribute isDefined |
	aSymbolAnnotation hasSymbolNameSpecified ifFalse: [ ^ self ].
	isDefined := aSymbolAnnotation isDefined.
	symbolValue := aSymbolAnnotation symbolValue.
	symbolValue ifNil: [ ^ self ].
	cacheKey := aSymbolAnnotation source.
	attribute := GtCachedTextExpandButtonAttribute new
			isExpanded: (self expanded at: cacheKey ifAbsentPut: [ false ]);
			attributesCreatingBlock: [ LeSymbolPreviewAttribute new
					isDefined: isDefined;
					withCache: self composite elements key: cacheKey;
					result: symbolValue gtReferences;
					showSelector: #gtViewsFor:;
					height: 200 ];
			onCachingDo: [ :aBoolean :theAttribute | self expanded at: cacheKey put: aBoolean ].
	self text
		attribute: attribute
		from: aSymbolAnnotation parent startPosition
		to: aSymbolAnnotation parent stopPosition
]

{ #category : #accessing }
LeSymbolAnnotationStyler >> text [
	^ self composite text
]

{ #category : #visiting }
LeSymbolAnnotationStyler >> visitSymbolAnnotation: aSymbolAnnotation [
	self styleAnnotation: aSymbolAnnotation.
	(aSymbolAnnotation hasSymbolNameSpecified and: [ aSymbolAnnotation isDefined ])
		ifTrue: [ self styleAutoHidingAnnotation: aSymbolAnnotation ].
	self styleButton: aSymbolAnnotation.
	self styleExpandingObject: aSymbolAnnotation
]

{ #category : #visiting }
LeSymbolAnnotationStyler >> visitSymbolArgument: aSymbolArgument [
	^ self visitSymbolParse: aSymbolArgument
]

{ #category : #visiting }
LeSymbolAnnotationStyler >> visitSymbolName: aSymbolName [
	^ self visitSymbolParse: aSymbolName
]

{ #category : #visiting }
LeSymbolAnnotationStyler >> visitSymbolParse: aSymbolParse [
	^ self visitSmaCCParseNode: aSymbolParse
]
