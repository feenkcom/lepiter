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

{ #category : #'private - actions' }
GtShellSourceCoder >> executeShellScript: script [
	| builder childProcess output |

	builder := GtExternalProcessBuilder new
		command: '/bin/sh';
		arg: '-c';
		arg: (String lf join: script lines).

	self pharoBindings asDictionary keysAndValuesDo: [ :key :value |
		(value value isString and: [ script includesSubstring: key ]) ifTrue: [
			builder env: key value: value value ] ].

	childProcess := builder
		pipeStdout;
		spawn.

	output := childProcess waitWithOutput stdoutString trimBoth.

	(self pharoBindings bindingOf: self bindingName asSymbol) value: output.
	
	^ output
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
