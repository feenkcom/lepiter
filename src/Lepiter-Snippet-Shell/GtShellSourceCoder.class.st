Class {
	#name : #GtShellSourceCoder,
	#superclass : #GtSourceCoder,
	#instVars : [
		'pharoBindings',
		'bindingName'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #accessing }
GtShellSourceCoder >> asCoderViewModel [
	^ GtSourceCoderViewModel new coder: self
]

{ #category : #accessing }
GtShellSourceCoder >> bindingName [
	^ bindingName ifNil: [ 'shellOutput' ]
]

{ #category : #accessing }
GtShellSourceCoder >> bindingName: aNameString [
	bindingName := aNameString
]

{ #category : #'api - ast' }
GtShellSourceCoder >> computeAst: theSourceString [
	^ theSourceString
]

{ #category : #private }
GtShellSourceCoder >> convertPrimitiveValue: anObject [
	anObject isBoolean ifTrue: [ ^ anObject asBit asString ].
	^ anObject asString
]

{ #category : #'private - actions' }
GtShellSourceCoder >> executeShellScript: script [
	| shellScriptProcess |

	shellScriptProcess := GtShellScriptProcess new script: script.

	self pharoBindings asDictionary keysAndValuesDo: [ :key :value |
		((self isPrimitiveValue: value value) 
				and: [ script includesSubstring: '$' , key ]) ifTrue: [
			shellScriptProcess 
				env: key 
				value: (self convertPrimitiveValue: value value) ] ].

	shellScriptProcess onSuccess: [ :output |
		(self pharoBindings bindingOf: self bindingName asSymbol) value: output ].

	shellScriptProcess announcer weak
		when: GtShellScriptAnnouncement do: [ :announcement | self announce: announcement ].
	
	shellScriptProcess start.

	^ shellScriptProcess
]

{ #category : #accessing }
GtShellSourceCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	"addOns addStyler: (GtCoderAstSmaCCParserStyler new smaccStyler: PsqlParser gtStyler)."
	
	addOns
		addMainAction: 'Evaluate' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doIt
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItActionId.
	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doItAndGo
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.
]

{ #category : #initialization }
GtShellSourceCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderDoItShortcut new;
		addShortcut: GtSourceCoderDoItAndInspectShortcut new
]

{ #category : #private }
GtShellSourceCoder >> isPrimitiveValue: anObject [
	^ #(isString isNumber isBoolean) anySatisfy: [ :each | anObject perform: each ]
]

{ #category : #accessing }
GtShellSourceCoder >> pharoBindings [
	^ pharoBindings
]

{ #category : #accessing }
GtShellSourceCoder >> pharoBindings: gtSharedVariablesBindings [
	"gtSharedVariablesBindings bindingNames isEmpty ifTrue: [ self haltOne ]."
	pharoBindings := gtSharedVariablesBindings
]

{ #category : #'private - actions' }
GtShellSourceCoder >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	^ self executeShellScript: aSourceString
]
