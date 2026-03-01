"
Styler for gtPragma annotations.
"
Class {
	#name : #LePragmaAnnotationStyler,
	#superclass : #LeComponentStyler,
	#traits : 'TLePragmaParseNodeVisitor',
	#classTraits : 'TLePragmaParseNodeVisitor classTrait',
	#instVars : [
		'elements',
		'expanded'
	],
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #initialization }
LePragmaAnnotationStyler class >> initialize [
	LeSnippetStylerVisitor additionalStylers add: self
]

{ #category : #initialization }
LePragmaAnnotationStyler class >> obsolete [
	LeSnippetStylerVisitor additionalStylers remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #accessing }
LePragmaAnnotationStyler >> elements [
	^ self composite elements
]

{ #category : #accessing }
LePragmaAnnotationStyler >> expanded [
	^ self composite expanded
]

{ #category : #testing }
LePragmaAnnotationStyler >> pragmaExists: aPragmaAnnotation [
	| pragmaName |
	pragmaName := aPragmaAnnotation pragmaName.
	pragmaName ifNil: [ ^ false ].
	^ (Pragma allNamed: pragmaName asSymbol) notEmpty
]

{ #category : #accessing }
LePragmaAnnotationStyler >> snippetViewModel [
	^ self composite snippetViewModel
]

{ #category : #styling }
LePragmaAnnotationStyler >> styleAnnotation: aPragmaAnnotation [
	| aLinkColor |
	aLinkColor := (self pragmaExists: aPragmaAnnotation)
		ifTrue: [ BrGlamorousColors textMarkupColor ]
		ifFalse: [ BrGlamorousColors linkWithErrorColor ].
	(self text from: aPragmaAnnotation parent startPosition to: aPragmaAnnotation parent stopPosition)
		foreground: aLinkColor
]

{ #category : #styling }
LePragmaAnnotationStyler >> styleExpandingObject: aPragmaAnnotation [
	| pragmaName cacheKey attribute pragmas |
	pragmaName := aPragmaAnnotation pragmaName.
	pragmaName ifNil: [ ^ self ].
	pragmas := Pragma allNamed: pragmaName asSymbol.
	pragmas ifEmpty: [ ^ self ].
	cacheKey := aPragmaAnnotation source.
	attribute := (GtCachedTextExpandButtonAttribute new)
		isExpanded: (self expanded at: cacheKey ifAbsentPut: [ false ]);
		attributesCreatingBlock: [
			(GtResizablePreviewAttribute new)
				withCache: self elements key: cacheKey;
				result: pragmas;
				showSelector: #gtLiveFor:;
				height: 200 ];
		onCachingDo: [ :aBoolean :theAttribute | self expanded at: cacheKey put: aBoolean ].
	self text
		attribute: attribute
		from: aPragmaAnnotation parent startPosition
		to: aPragmaAnnotation parent stopPosition
]

{ #category : #styling }
LePragmaAnnotationStyler >> styleLinkButton: aPragmaAnnotation [
	| attribute pragmaName pragmaType |
	pragmaName := aPragmaAnnotation pragmaName.
	pragmaName ifNil: [ ^ self ].
	pragmaType := GtPragmaType new keyword: pragmaName asSymbol; yourself.
	attribute := GtButtonAttribute new
		beAppend;
		stencil: [
			| button |
			button := LeSnippetStylerVisitor
				textLinkButtonPadding: (BlInsets top: 2)
				margin: BlInsets empty
				valid: (self pragmaExists: aPragmaAnnotation).
			button
				beSmallSize;
				label: pragmaName;
				action: [ :aButton | aButton phlow spawnObject: pragmaType ].
			button ].
	self text
		attribute: attribute
		from: aPragmaAnnotation parent startPosition
		to: aPragmaAnnotation parent stopPosition
]

{ #category : #accessing }
LePragmaAnnotationStyler >> text [
	^ self composite text
]

{ #category : #visiting }
LePragmaAnnotationStyler >> visitPragmaAnnotation: aPragmaAnnotation [
	self styleAnnotation: aPragmaAnnotation.
	aPragmaAnnotation hasPragmaNameSpecified
		ifTrue: [ self styleAutoHidingAnnotation: aPragmaAnnotation ].
	self styleLinkButton: aPragmaAnnotation.
	self styleExpandingObject: aPragmaAnnotation
]
