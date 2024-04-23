Class {
	#name : #LeShellCommandPane,
	#superclass : #Object,
	#instVars : [
		'command',
		'arguments',
		'bindingName',
		'acceptAction',
		'inspectAction'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #accessing }
LeShellCommandPane >> acceptAction [ 
	^ acceptAction ifNil: [ 
		[ :aModel :aButton :aMemento :aDescription |
			aButton phlow spawnObject: self bindingName -> { self command . self arguments } ] ]
]

{ #category : #accessing }
LeShellCommandPane >> acceptAction: anAction [
	acceptAction := anAction
]

{ #category : #accessing }
LeShellCommandPane >> argumentStrings [
	^ self arguments collect: #string
]

{ #category : #accessing }
LeShellCommandPane >> argumentStrings: aStringCollection [
	^ self arguments: (aStringCollection collect: [ :string | LeShellCommandArgument new string: string ])
]

{ #category : #accessing }
LeShellCommandPane >> arguments [
	^ arguments ifNil: [ #() ]
]

{ #category : #accessing }
LeShellCommandPane >> arguments: aCollection [
	arguments := aCollection
]

{ #category : #accessing }
LeShellCommandPane >> asElement [
	^ self asGtMagritteViewModel asElement padding: (BlInsets all: 10)
]

{ #category : #magritte }
LeShellCommandPane >> bindingDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 3;
		label: 'Binding';
		accessor: #bindingName;
		default: ''
]

{ #category : #accessing }
LeShellCommandPane >> bindingName [
	^ bindingName
]

{ #category : #accessing }
LeShellCommandPane >> bindingName: aString [
	bindingName := aString
]

{ #category : #accessing }
LeShellCommandPane >> combinedArguments [
	^ ' ' join: self argumentStrings
]

{ #category : #accessing }
LeShellCommandPane >> combinedArguments: string [
	| parts |
	parts := string findTokens: Character separators.
	self argumentStrings: parts
]

{ #category : #magritte }
LeShellCommandPane >> combinedArgumentsDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Arguments';
		priority: 2;
		accessor: #combinedArguments;
		default: ''
]

{ #category : #accessing }
LeShellCommandPane >> command [
	^ command
]

{ #category : #accessing }
LeShellCommandPane >> command: anObject [
	command := anObject
]

{ #category : #magritte }
LeShellCommandPane >> commandDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 1;
		label: 'Command';
		accessor: #command;
		default: ''
]

{ #category : #accessing }
LeShellCommandPane >> execute [
	| subProcess |
	subProcess := GtSubprocessWithInMemoryOutput new
			command: self command;
			arguments: (self arguments collect: #string);
			terminateOnShutdown;
			runAndWait.
	^ subProcess stdout
]

{ #category : #accessing }
LeShellCommandPane >> executeUsingBindings: bindings [
	| subProcess processedArguments|
	processedArguments := self arguments collect: [ :each | 
		bindings
			at: each string
			ifPresent: [ :binding | binding value asString ]
			ifAbsent: [ each string ] ].
	subProcess := GtSubprocessWithInMemoryOutput new
			command: self command;
			arguments: processedArguments;
			terminateOnShutdown;
			runAndWait.
	"subProcess isSuccess ifFalse: [ subProcess inspect ]."
	^ subProcess stdout trimBoth
]

{ #category : #accessing }
LeShellCommandPane >> fullCommand [
	^ self arguments
		ifEmpty: [ self command ]
		ifNotEmpty: [ self command , ' ' , self combinedArguments ]
]

{ #category : #magritte }
LeShellCommandPane >> individualArgumentsDescription [
	"<magritteDescription>"
	^ MAToManyRelationDescription new
		label: 'Arguments';
		priority: 2;
		accessor: #arguments;
		classes: { LeShellCommandArgument };
		blocItemStencil: [ :anItemViewModel :anItemIndex | 
			anItemViewModel asElement
				fitContent;
				border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1);
				margin: (BlInsets top: 0 right: 5 bottom: 5 left: 0);
				padding: (BlInsets all: 5);
				background: Color white ];
		newItemStencil: [ LeShellCommandArgument new ]
]

{ #category : #accessing }
LeShellCommandPane >> inspectAction [
	^ inspectAction ifNil: [ 
		[ :aModel :aButton :aMemento :aDescription |
			aButton phlow spawnObject: self bindingName -> { self command . self arguments } ] ]
]

{ #category : #accessing }
LeShellCommandPane >> inspectAction: anAction [
	inspectAction := anAction
]

{ #category : #magritte }
LeShellCommandPane >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		priority: 10;
		beAlwaysEnabled;
		label: 'Accept the changes and execute the shell command';
		isLabelVisible: false;
		blocIcon: BrGlamorousVectorIcons play;
		onSuccessCallback: (GtMagritteCallback new action: self acceptAction)
]

{ #category : #magritte }
LeShellCommandPane >> magritteCancelAction [
	<magritteActionDescription>
	^ nil
]

{ #category : #magritte }
LeShellCommandPane >> magritteInspectAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		priority: 20;
		beAlwaysEnabled;
		label: 'Accept the changes, execute the shell command and inspect the result';
		isLabelVisible: false;
		blocIcon: BrGlamorousVectorIcons playinspect;
		onSuccessCallback: (GtMagritteCallback new action: self inspectAction)
]
