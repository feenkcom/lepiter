Class {
	#name : #LeObjectReferenceAnnotationStyler,
	#superclass : #LeComponentStyler,
	#traits : 'TLeObjectReferenceParseNodeVisitor',
	#classTraits : 'TLeObjectReferenceParseNodeVisitor classTrait',
	#instVars : [
		'objectRegistry'
	],
	#classVars : [
		'TestRegistry'
	],
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #initialization }
LeObjectReferenceAnnotationStyler class >> initialize [
	LeSnippetStylerVisitor additionalStylers add: self
]

{ #category : #initialization }
LeObjectReferenceAnnotationStyler class >> obsolete [
	LeSnippetStylerVisitor additionalStylers remove: self ifAbsent: [].
	^super obsolete
]

{ #category : #visiting }
LeObjectReferenceAnnotationStyler >> accept: anObject [
	(anObject isKindOf: SmaCCParseNode) ifTrue: [^self acceptNode: anObject].
	(anObject isKindOf: Collection) ifTrue: [^self acceptNodes: anObject].
	^anObject
]

{ #category : #visiting }
LeObjectReferenceAnnotationStyler >> acceptNode: aSmaCCParseNode [
	aSmaCCParseNode isNil ifTrue: [^nil].
	^aSmaCCParseNode acceptVisitor: self
]

{ #category : #visiting }
LeObjectReferenceAnnotationStyler >> acceptNodes: aCollection [
	aCollection do: [:each | self acceptNode: each].
	^aCollection
]

{ #category : #private }
LeObjectReferenceAnnotationStyler >> effectiveObjectRegistry [
	^objectRegistry ifNil: [self resolveObjectRegistry]
]

{ #category : #accessing }
LeObjectReferenceAnnotationStyler >> elements [
	^self composite elements
]

{ #category : #accessing }
LeObjectReferenceAnnotationStyler >> expanded [
	^self composite expanded
]

{ #category : #private }
LeObjectReferenceAnnotationStyler >> labelFor: anObjectAnnotation object: anObject [
	| selector |
	selector := anObjectAnnotation labelSelector ifNil: ['gtDisplayString'].
	^[anObject perform: selector asSymbol] on: Error do: [:e | e printString]
]

{ #category : #testing }
LeObjectReferenceAnnotationStyler >> objectExists: anObjectAnnotation [
	| uuid |
	uuid := anObjectAnnotation uuid.
	uuid ifNil: [^false].
	^(self objectForId: uuid) notNil
]

{ #category : #private }
LeObjectReferenceAnnotationStyler >> objectForId: aUuidString [
	^self effectiveObjectRegistry
		ifNotNil: [:registry | registry at: aUuidString ifAbsent: [nil]]
		ifNil: [nil]
]

{ #category : #accessing }
LeObjectReferenceAnnotationStyler >> objectRegistry [
	^objectRegistry
]

{ #category : #accessing }
LeObjectReferenceAnnotationStyler >> objectRegistry: aDictionary [
	objectRegistry := aDictionary
]

{ #category : #private }
LeObjectReferenceAnnotationStyler >> resolveObjectRegistry [
	^nil
]

{ #category : #accessing }
LeObjectReferenceAnnotationStyler >> snippetViewModel [
	^self composite snippetViewModel
]

{ #category : #styling }
LeObjectReferenceAnnotationStyler >> styleAnnotation: anObjectAnnotation [
	| aLinkColor |
	aLinkColor := (self objectExists: anObjectAnnotation)
				ifTrue: [BrGlamorousColors textMarkupColor]
				ifFalse: [BrGlamorousColors linkWithErrorColor].
	(self text from: anObjectAnnotation parent startPosition
		to: anObjectAnnotation parent stopPosition) foreground: aLinkColor
]

{ #category : #private }
LeObjectReferenceAnnotationStyler >> styleExpandingObject: anObjectAnnotation [
	| uuid object cacheKey attribute isExpanded showSelector height |
	uuid := anObjectAnnotation uuid.
	uuid ifNil: [^self].
	object := self objectForId: uuid.
	object ifNil: [^self].
	cacheKey := anObjectAnnotation source.
	isExpanded := anObjectAnnotation expandedValue ifNil: [false].
	showSelector := (anObjectAnnotation showSelector ifNil: ['gtViewsFor:'])
				asSymbol.
	height := anObjectAnnotation heightValue ifNil: [200].
	attribute := (GtCachedTextExpandButtonAttribute new)
				isExpanded: (self expanded at: cacheKey ifAbsentPut: [isExpanded]);
				attributesCreatingBlock: 
						[(GtResizablePreviewAttribute new)
							withCache: self elements key: cacheKey;
							result: object;
							showSelector: showSelector;
							height: height];
				onCachingDo: [:aBoolean :theAttribute | self expanded at: cacheKey put: aBoolean].
	self text
		attribute: attribute
		from: anObjectAnnotation parent startPosition
		to: anObjectAnnotation parent stopPosition
]

{ #category : #'private - styling' }
LeObjectReferenceAnnotationStyler >> styleLinkButton: anObjectAnnotation [
	| attribute uuid object label |
	uuid := anObjectAnnotation uuid.
	uuid ifNil: [^self].
	object := self objectForId: uuid.
	label := object
				ifNotNil: [self labelFor: anObjectAnnotation object: object]
				ifNil: [anObjectAnnotation fallbackLabelString ifNil: [uuid]].
	attribute := (GtButtonAttribute new)
				beAppend;
				stencil: 
						[| button |
						button := LeSnippetStylerVisitor
									textLinkButtonPadding: (BlInsets top: 2)
									margin: BlInsets empty
									valid: (self objectExists: anObjectAnnotation).
						button aptitude glamorousCodeFont.
						button
							beSmallSize;
							label: label;
							action: [:aButton | object ifNotNil: [aButton phlow spawnObject: object]].
						button].
	self text
		attribute: attribute
		from: anObjectAnnotation parent startPosition
		to: anObjectAnnotation parent stopPosition
]

{ #category : #accessing }
LeObjectReferenceAnnotationStyler >> text [
	^self composite text
]

{ #category : #visiting }
LeObjectReferenceAnnotationStyler >> visitObjectReferenceAnnotation: anObjectAnnotation [
	self styleAnnotation: anObjectAnnotation.
	anObjectAnnotation hasUuidSpecified
		ifTrue: [self styleAutoHidingAnnotation: anObjectAnnotation].
	self styleLinkButton: anObjectAnnotation.
	self styleExpandingObject: anObjectAnnotation
]

{ #category : #visiting }
LeObjectReferenceAnnotationStyler >> visitSmaCCError: anError [
	^anError
]

{ #category : #visiting }
LeObjectReferenceAnnotationStyler >> visitSmaCCParseNode: aSmaCCParseNode [
	self acceptNodes: aSmaCCParseNode sortedChildren.
	^aSmaCCParseNode
]
