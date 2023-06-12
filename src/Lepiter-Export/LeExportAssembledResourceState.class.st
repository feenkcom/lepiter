Class {
	#name : #LeExportAssembledResourceState,
	#superclass : #Object,
	#traits : 'TLeExportResourceState',
	#classTraits : 'TLeExportResourceState classTrait',
	#instVars : [
		'duration'
	],
	#category : #'Lepiter-Export-Resources - State'
}

{ #category : #accessing }
LeExportAssembledResourceState >> color [
	^ BrGlamorousColors successBackgroundColor
]

{ #category : #'api - duration' }
LeExportAssembledResourceState >> duration [
	^ duration
]

{ #category : #accessing }
LeExportAssembledResourceState >> duration: anObject [
	duration := anObject
]

{ #category : #initialization }
LeExportAssembledResourceState >> initialize [
	super initialize.
	duration := 0 seconds.
]

{ #category : #testing }
LeExportAssembledResourceState >> isAssembledState [
	"Return true if the resource was assembled (and therefore it nows the assembling duration)"

	^ true
]

{ #category : #testing }
LeExportAssembledResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ false
]

{ #category : #testing }
LeExportAssembledResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ true
]

{ #category : #accessing }
LeExportAssembledResourceState >> label [
	| aText aDuration |
	aText := 'ready' asRopedText foreground: self color.
	aDuration := ' ({1})' format: { self duration gtShortPrintString }.
	aText append: (aDuration asRopedText 
		foreground: BrGlamorousColors disabledButtonTextColor).

	^ aText
]

{ #category : #'api - duration' }
LeExportAssembledResourceState >> minutes [
	^ self duration asMinutes
]

{ #category : #accessing }
LeExportAssembledResourceState >> name [
	^ 'ready ({1})' format: { self duration gtShortPrintString }
]
