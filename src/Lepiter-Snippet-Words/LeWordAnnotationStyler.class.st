Class {
	#name : #LeWordAnnotationStyler,
	#superclass : #LeComponentStyler,
	#traits : 'TLeWordParseNodeVisitor - {#acceptNode:}',
	#classTraits : 'TLeWordParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #initialization }
LeWordAnnotationStyler class >> initialize [
	LeSnippetStylerVisitor additionalStylers add: self
]

{ #category : #initialization }
LeWordAnnotationStyler class >> obsolete [
	LeSnippetStylerVisitor additionalStylers remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #styling }
LeWordAnnotationStyler >> beginStyling [
	self dictionary emptyRequests
]

{ #category : #private }
LeWordAnnotationStyler >> dictionary [
	^ self snippetViewModel optionAt: #wordDictionary ifAbsentPut: [ LeWordDictionary new ]
]

{ #category : #private }
LeWordAnnotationStyler >> elements [
	^ self composite elements
]

{ #category : #private }
LeWordAnnotationStyler >> expanded [
	^ self composite expanded
]

{ #category : #private }
LeWordAnnotationStyler >> explanationFor: aString [
	| element |
	element := LeWordViewElement new.
	self dictionary
		lookup: aString
		do:
			[ :response | response isSuccess ifTrue: [ element enqueueTask: (BlTaskAction new action: [ element explanation: response explanation ]) ] ].
	^ element
]

{ #category : #accessing }
LeWordAnnotationStyler >> snippetViewModel [
	^ self composite snippetViewModel
]

{ #category : #private }
LeWordAnnotationStyler >> styleAnnotation: aWordAnnotation [
	| aLinkColor |
	aLinkColor := aWordAnnotation hasWordSpecified
		ifTrue: [ BrGlamorousColors textMarkupColor ]
		ifFalse: [ BrGlamorousColors linkWithErrorColor ].
	(self text from: aWordAnnotation parent startPosition to: aWordAnnotation parent stopPosition) foreground: aLinkColor
]

{ #category : #private }
LeWordAnnotationStyler >> styleAutoHidingAnnotation: anAnnotation [
	| first last range |
	anAnnotation hasWordSpecified ifFalse: [ ^ self ].
	first := anAnnotation parent startPosition max: 1.
	last := anAnnotation parent stopPosition min: self text size.
	range := first to: last.
	composite
		styleAutoHiding: range
		and: range
		whenOutside: anAnnotation parent sourceInterval
]

{ #category : #private }
LeWordAnnotationStyler >> styleButton: anAnnotation [
	| attribute |
	anAnnotation hasWordSpecified ifFalse: [ ^ self ].
	attribute := (GtButtonAttribute new)
		beAppend;
		stencil:
				[ | button label |
					label := anAnnotation word.
					button := LeSnippetStylerVisitor textLinkButtonPadding: (BlInsets top: 2) margin: BlInsets empty.
					button aptitude glamorousCodeFont.
					button
						beSmallSize;
						label: label;
						action: [ :aButton | aButton phlow spawnObject: (self dictionary lookup: label) ].
					button ].
	self text
		attribute: attribute
		from: anAnnotation parent startPosition
		to: anAnnotation parent stopPosition
]

{ #category : #private }
LeWordAnnotationStyler >> styleExpandingObject: anAnnotation [
	| cacheKey attribute |
	anAnnotation hasWordSpecified ifFalse: [ ^ self ].
	cacheKey := anAnnotation source.
	attribute := (GtCachedTextExpandButtonAttribute new)
		isExpanded: (self expanded at: cacheKey ifAbsentPut: [ anAnnotation isExpanded ]);
		attributesCreatingBlock:
				[ (GtResizablePreviewAttribute new)
						withCache: self elements key: cacheKey;
						result: (self explanationFor: anAnnotation word);
						showSelector: #gtLiveFor:;
						height: anAnnotation height ];
		onCachingDo: [ :aBoolean :theAttribute | self expanded at: cacheKey put: aBoolean ].
	self text
		attribute: attribute
		from: anAnnotation parent startPosition
		to: anAnnotation parent stopPosition
]

{ #category : #private }
LeWordAnnotationStyler >> text [
	^ self composite text
]

{ #category : #visiting }
LeWordAnnotationStyler >> visitWordAnnotation: aWordAnnotation [
	self styleAnnotation: aWordAnnotation.
	self styleAutoHidingAnnotation: aWordAnnotation.
	self styleButton: aWordAnnotation.
	self styleExpandingObject: aWordAnnotation
]
