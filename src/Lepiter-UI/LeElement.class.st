"
I am an abstract class.
I provide basic {{gtClass:TBrLayoutResizable}} methods.
See my {{gtClass:LeElement|expanded|show=#gtSubclassesFor:}} for concrete implementations:

"
Class {
	#name : #LeElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#category : 'Lepiter-UI-! Content Elements'
}

{ #category : #asserting }
LeElement >> assertUIProcess [
	"Make sure that I am executing in a UI process"
	| aCurrentProcess aUIProcess |
	
	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].
		
	self space isOpened
		ifFalse: [ ^ self ].

	aCurrentProcess := Processor activeProcess.	

	aUIProcess := nil.
	self space host uiProcessDo: [ :aProcess | aUIProcess := aProcess ].

	aUIProcess
		ifNil: [ ^ self ].
		
	(aUIProcess == aCurrentProcess)
		ifFalse: [ self error: ('I am running from a non-UI process ({1}) expected ({2})' format: { aCurrentProcess asString . aUIProcess asString }) ]
]

{ #category : #initialization }
LeElement >> initialize [
	super initialize.
	
	self matchParent
]
