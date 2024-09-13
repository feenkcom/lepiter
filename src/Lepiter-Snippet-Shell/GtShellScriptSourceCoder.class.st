Class {
	#name : #GtShellScriptSourceCoder,
	#superclass : #GtSourceCoder,
	#instVars : [
		'pharoBindings',
		'bindingName'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #accessing }
GtShellScriptSourceCoder >> asCoderViewModel [
	^ GtSourceCoderViewModel new coder: self
]

{ #category : #accessing }
GtShellScriptSourceCoder >> bindingName [
	^ bindingName ifNil: [ 'shellOutput' ]
]

{ #category : #accessing }
GtShellScriptSourceCoder >> bindingName: aNameString [
	bindingName := aNameString
]

{ #category : #'api - ast' }
GtShellScriptSourceCoder >> computeAst: theSourceString [
	^ theSourceString
]

{ #category : #private }
GtShellScriptSourceCoder >> convertPrimitiveValue: anObject [
	anObject isBoolean ifTrue: [ ^ anObject asBit asString ].
	^ anObject asString
]

{ #category : #'private - actions' }
GtShellScriptSourceCoder >> executeShellScript: script [
	| shellScriptProcess |

	shellScriptProcess := GtShellScriptProcess new script: script.

	self pharoBindings asDictionary keysAndValuesDo: [ :key :value |
		((self isPrimitiveValue: value value) 
				and: [ script includesSubstring: key caseSensitive: true ]) ifTrue: [
			shellScriptProcess 
				env: key 
				value: (self convertPrimitiveValue: value value) ] ].

	shellScriptProcess onSuccess: [ :output |
		(self pharoBindings bindingOf: self bindingName asSymbol) value: output ].

	shellScriptProcess announcer weak
		when: GtShellScriptAnnouncement send: #announce: to: self.
	
	shellScriptProcess start.

	^ shellScriptProcess
]

{ #category : #accessing }
GtShellScriptSourceCoder >> initializeAddOns: addOns [
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
GtShellScriptSourceCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderDoItShortcut new;
		addShortcut: GtSourceCoderDoItAndInspectShortcut new
]

{ #category : #private }
GtShellScriptSourceCoder >> isPrimitiveValue: anObject [
	^ #(isString isNumber isBoolean) anySatisfy: [ :each | anObject perform: each ]
]

{ #category : #accessing }
GtShellScriptSourceCoder >> pharoBindings [
	^ pharoBindings
]

{ #category : #accessing }
GtShellScriptSourceCoder >> pharoBindings: gtSharedVariablesBindings [
	"gtSharedVariablesBindings bindingNames isEmpty ifTrue: [ self haltOne ]."
	pharoBindings := gtSharedVariablesBindings
]

{ #category : #'private - actions' }
GtShellScriptSourceCoder >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	^ self executeShellScript: aSourceString
]
