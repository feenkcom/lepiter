Class {
	#name : #GtShellSourceCoder,
	#superclass : #GtSourceCoder,
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #accessing }
GtShellSourceCoder >> asCoderViewModel [
	^ GtSourceCoderViewModel new coder: self
]

{ #category : #'api - ast' }
GtShellSourceCoder >> computeAst: theSourceString [
	^ theSourceString
]

{ #category : #'private - actions' }
GtShellSourceCoder >> executeShellScript: script [
	"this is synchroneous, not snippet variable binding in or out"
	
	| builder childProcess output |

	builder := GtExternalProcessBuilder new
		command: '/bin/sh';
		arg: '-c';
		arg: (String lf join: script lines).

	childProcess := builder
		pipeStdout;
		spawn.

	output := childProcess waitWithOutput stdoutString.

	^ output trimBoth
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

{ #category : #'private - actions' }
GtShellSourceCoder >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	^ self executeShellScript: aSourceString
]
