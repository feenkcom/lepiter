"
Styler for gtFileReference annotation.
"
Class {
	#name : #LeFileReferenceAnnotationStyler,
	#superclass : #LeComponentStyler,
	#traits : 'TLeFileReferenceParseNodeVisitor',
	#classTraits : 'TLeFileReferenceParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #'class initialization' }
LeFileReferenceAnnotationStyler class >> initialize [
	LeSnippetStylerVisitor additionalStylers add: self
]

{ #category : #'class initialization' }
LeFileReferenceAnnotationStyler class >> obsolete [
	LeSnippetStylerVisitor additionalStylers remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #accessing }
LeFileReferenceAnnotationStyler >> composite [
	^ composite
]

{ #category : #private }
LeFileReferenceAnnotationStyler >> elements [
	^ self composite elements
]

{ #category : #private }
LeFileReferenceAnnotationStyler >> expanded [
	^ self composite expanded
]

{ #category : #accessing }
LeFileReferenceAnnotationStyler >> fileReferenceFor: anAnnotation [
	| pathString fileReference page |
	pathString := anAnnotation pathString ifNil: [ ^ nil ].
	fileReference := pathString asFileReference.
	fileReference isAbsolute ifTrue: [ ^ fileReference ].
	page := self snippetViewModel snippetModel page.
	page ifNil: [ ^ fileReference ].
	page pageFileReference ifNil: [ ^ fileReference ].
	^ page pageFileReference parent resolveReference: fileReference
]

{ #category : #accessing }
LeFileReferenceAnnotationStyler >> snippetViewModel [
	^ self composite snippetViewModel
]

{ #category : #styling }
LeFileReferenceAnnotationStyler >> styleAnnotation: anAnnotation [
	| aLinkColor |
	anAnnotation pathArgument ifNil: [
		aLinkColor := BrGlamorousColors linkWithErrorColor.
		(self text from: anAnnotation parent startPosition to: anAnnotation parent stopPosition) foreground: aLinkColor.
		^ self ].

	(self text from: anAnnotation parent startPosition to: anAnnotation parent stopPosition)
		foreground: BrGlamorousColors textMarkupColor
]

{ #category : #styling }
LeFileReferenceAnnotationStyler >> styleButton: anAnnotation [
	| attribute fileReference labelString isValid |
	anAnnotation pathArgument ifNil: [ ^ self ].
	fileReference := self fileReferenceFor: anAnnotation.
	fileReference ifNil: [ ^ self ].
	labelString := anAnnotation labelString ifNil: [ fileReference pathString ].
	isValid := fileReference exists.

	attribute := GtButtonAttribute new
		beAppend;
		stencil: [ | button |
			button := LeSnippetStylerVisitor
				textLinkButtonPadding: (BlInsets top: 2)
				margin: BlInsets empty
				valid: isValid.
			button aptitude glamorousRegularFont.
			button
				beSmallSize;
				label: labelString;
				action: [ :aButton | aButton phlow spawnObject: fileReference ].
			button ].

	self text
		attribute: attribute
		from: anAnnotation parent startPosition
		to: anAnnotation parent stopPosition
]

{ #category : #private }
LeFileReferenceAnnotationStyler >> styleExpandingObject: anAnnotation [
	| cacheKey attribute expandedObject |
	anAnnotation pathArgument ifNil: [ ^ self ].
	expandedObject := LeFileReference
		fromAnnotation: anAnnotation
		inPage: self snippetViewModel snippetModel page.
	expandedObject ifNil: [ ^ self ].
	cacheKey := anAnnotation source.
	attribute := (GtCachedTextExpandButtonAttribute new)
		isExpanded: (self expanded at: cacheKey ifAbsentPut: [ anAnnotation expandedValue ifNil: [ false ] ]);
		attributesCreatingBlock: [
			(GtResizablePreviewAttribute new)
				withCache: self elements key: cacheKey;
				result: expandedObject;
				showSelector: #gtLiveFor:;
				height: (anAnnotation heightValue ifNil: [ 200 ]) ];
		onCachingDo: [ :aBoolean :theAttribute | self expanded at: cacheKey put: aBoolean ].
	self text
		attribute: attribute
		from: anAnnotation parent startPosition
		to: anAnnotation parent stopPosition
]

{ #category : #accessing }
LeFileReferenceAnnotationStyler >> text [
	^ self composite text
]

{ #category : #visiting }
LeFileReferenceAnnotationStyler >> visitFileReferenceAnnotation: anAnnotation [
	self styleAnnotation: anAnnotation.
	anAnnotation pathArgument
		ifNotNil: [ self styleAutoHidingAnnotation: anAnnotation ].
	self styleButton: anAnnotation.
	self styleExpandingObject: anAnnotation
]
