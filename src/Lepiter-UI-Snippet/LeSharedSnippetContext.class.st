Class {
	#name : #LeSharedSnippetContext,
	#superclass : #Object,
	#traits : 'TGtCoderWithSelfObjectHolder',
	#classTraits : 'TGtCoderWithSelfObjectHolder classTrait',
	#instVars : [
		'announcer',
		'sharedBindings',
		'selfObject',
		'variablePreviewToggle',
		'externalSnippetContext',
		'pharoRuntimeContext'
	],
	#category : #'Lepiter-UI-Snippet-! View Models'
}

{ #category : #accessing }
LeSharedSnippetContext >> externalSnippetContext [
	<return: #LeExternalSnippetContext>
	
	^ externalSnippetContext ifNil: [
		externalSnippetContext := LeExternalSnippetContext new ]
]

{ #category : #accessing }
LeSharedSnippetContext >> externalSnippetContext: anExternalSnippetContext [
	self assert: [ externalSnippetContext isNil ].
	
	externalSnippetContext := anExternalSnippetContext
]

{ #category : #'gt - extensions' }
LeSharedSnippetContext >> gtViewSharedBindingsFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Shared bindings';
		object: [ self sharedBindings ];
		view: #gtBindingsFor:
]

{ #category : #initialization }
LeSharedSnippetContext >> initialize [
	super initialize.
	
	sharedBindings := GtSharedVariablesBindings new.
	variablePreviewToggle := BrToggleModel new.
]

{ #category : #'api - self object' }
LeSharedSnippetContext >> onSelfObjectHolderChanged [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: #selfObject ]
]

{ #category : #accessing }
LeSharedSnippetContext >> pharoRuntimeContext [
	<return: #Context>

	^ pharoRuntimeContext
]

{ #category : #accessing }
LeSharedSnippetContext >> pharoRuntimeContext: aContext [
	"Assign an optional Pharo runtime context.
	Should be used when evaluating Pharo code in a presence of a running system (live debugger, code snippets in debugger)"

	pharoRuntimeContext := aContext
]

{ #category : #accessing }
LeSharedSnippetContext >> sharedBindings [

	^ sharedBindings
]

{ #category : #accessing }
LeSharedSnippetContext >> sharedBindings: anObject [

	sharedBindings := anObject
]

{ #category : #'announcer - subscription' }
LeSharedSnippetContext >> unsubscribe: anObject [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #initialization }
LeSharedSnippetContext >> variablePreviewToggle [
	^variablePreviewToggle
]

{ #category : #'announcer - subscription' }
LeSharedSnippetContext >> whenSelfObjectChangedSend: aSymbol to: anObject [
	announcer ifNil: [ announcer := Announcer new ].
	announcer weak
		when: #selfObject
		send: aSymbol
		to: anObject
]
