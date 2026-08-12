Class {
	#name : #LeObjectReferenceExampleStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'objectRegistry',
		'elements',
		'expanded'
	],
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #accessing }
LeObjectReferenceExampleStyler >> elements [
	^elements
]

{ #category : #accessing }
LeObjectReferenceExampleStyler >> expanded [
	^expanded
]

{ #category : #accessing }
LeObjectReferenceExampleStyler >> initialize [
	super initialize.
	elements := Dictionary new.
	expanded := Dictionary new
]

{ #category : #private }
LeObjectReferenceExampleStyler >> labelFor: anObjectAnnotation object: anObject [
	| selector |
	selector := anObjectAnnotation labelSelector ifNil: ['gtDisplayString'].
	^[anObject perform: selector asSymbol] on: Error do: [:e | e printString]
]

{ #category : #testing }
LeObjectReferenceExampleStyler >> objectExists: anObjectAnnotation [
	| uuid |
	uuid := anObjectAnnotation uuid.
	uuid ifNil: [^false].
	^(self objectForId: uuid) notNil
]

{ #category : #accessing }
LeObjectReferenceExampleStyler >> objectForId: anIdString [
	| key |
	objectRegistry ifNil: [^nil].
	key := (anIdString includes: $-)
				ifTrue: [(UUID fromString: anIdString) asString36]
				ifFalse: [anIdString].
	^objectRegistry at: key ifAbsent: [nil]
]

{ #category : #accessing }
LeObjectReferenceExampleStyler >> objectRegistry [
	^objectRegistry
]

{ #category : #accessing }
LeObjectReferenceExampleStyler >> objectRegistry: aDictionary [
	objectRegistry := aDictionary
]

{ #category : #styling }
LeObjectReferenceExampleStyler >> privateStyle: aText [
	<return: #BlText>
	| ast |
	text := aText.
	ast := LeParser parseWithErrors: aText asString.
	ast allNodesDo: 
			[:node |
			(node isKindOf: LeObjectReferenceAnnotationNode)
				ifTrue: [node acceptVisitor: self]].
	^aText
]

{ #category : #styling }
LeObjectReferenceExampleStyler >> styleAnnotation: anObjectAnnotation [
	| aLinkColor |
	aLinkColor := (self objectExists: anObjectAnnotation)
				ifTrue: [BrGlamorousColors textMarkupColor]
				ifFalse: [BrGlamorousColors linkWithErrorColor].
	(self text from: anObjectAnnotation parent startPosition
		to: anObjectAnnotation parent stopPosition) foreground: aLinkColor
]

{ #category : #private }
LeObjectReferenceExampleStyler >> styleExpandingObject: anObjectAnnotation [
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
LeObjectReferenceExampleStyler >> styleLinkButton: anObjectAnnotation [
	| attribute uuid object label |
	uuid := anObjectAnnotation uuid.
	uuid ifNil: [^self].
	object := self objectForUuid: uuid.
	label := object
				ifNotNil: [self labelFor: anObjectAnnotation object: object]
				ifNil: [anObjectAnnotation fallbackLabelString ifNil: [uuid]].
	attribute := (GtButtonAttribute new)
				beAppend;
				stencil: 
						[| button |
						button := GtLMessageStyler
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
LeObjectReferenceExampleStyler >> text [
	^text
]

{ #category : #visiting }
LeObjectReferenceExampleStyler >> visitObjectReferenceAnnotation: anObjectAnnotation [
	self styleAnnotation: anObjectAnnotation.
	self styleLinkButton: anObjectAnnotation.
	self styleExpandingObject: anObjectAnnotation
]
