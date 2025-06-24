"
I am GtShellScriptProcess.

I represent a Shell script to be executed by /bin/sh on a Unix system (macOS or Linux).

When I run, I am executing asynchronously, updating myself when necessary. 
"
Class {
	#name : #GtShellScriptProcess,
	#superclass : #Object,
	#instVars : [
		'script',
		'childProcess',
		'stdout',
		'stderr',
		'poller',
		'announcer',
		'state',
		'bindings',
		'onSuccess'
	],
	#classVars : [
		'BashExecutable'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #accessing }
GtShellScriptProcess class >> bashExecutable [

	^ BashExecutable ifNil: [ BashExecutable := self findBashExecutable fullName ]
]

{ #category : #private }
GtShellScriptProcess class >> findBashExecutable [
	"Answer the path to the specified executable.
	Run this is a shell as some platforms, e.g. Mac, don't set up the same environment for processes started from the file explorer."

	^ GtOsSystemInfo current findExecutable: 'bash'.
]

{ #category : #initialization }
GtShellScriptProcess class >> initialize [

	SessionManager default registerSystemClassNamed: self name.
]

{ #category : #initialization }
GtShellScriptProcess class >> startUp: resuming [

	resuming ifTrue: [ BashExecutable := nil ]
]

{ #category : #private }
GtShellScriptProcess >> announce: announcement [
	self announcer announce: announcement
]

{ #category : #accessing }
GtShellScriptProcess >> announcer [
	^ announcer
]

{ #category : #testing }
GtShellScriptProcess >> didRun [
	^ state = #ran
]

{ #category : #accessing }
GtShellScriptProcess >> env: key value: value [
	bindings at: key put: value
]

{ #category : #examples }
GtShellScriptProcess >> example10stepsOf1Second [
	<gtExample>
	<return: #GtShellScriptProcess>
	self
		script: 'for ((i = 0 ; i < 10 ; i++)); do
  echo `date` @ $i
  sleep 1
done
echo `date` done'
]

{ #category : #examples }
GtShellScriptProcess >> exampleEmpty [
	<gtExample>
	<return: #GtShellScriptProcess>
	self assert: self isRunning not.
	self assert: self didRun not
]

{ #category : #examples }
GtShellScriptProcess >> exampleFailure [
	<gtExample>
	<return: #GtShellScriptProcess>
	self
		script: 'echo Something went wrong >&2
exit 1'
]

{ #category : #examples }
GtShellScriptProcess >> exampleListWorkingDirectory [
	<gtExample>
	<return: #GtShellScriptProcess>
	self script: 'ls -1'
]

{ #category : #examples }
GtShellScriptProcess >> examplePrintWorkingDirectory [
	<gtExample>
	<return: #GtShellScriptProcess>
	self script: 'pwd'
]

{ #category : #examples }
GtShellScriptProcess >> exampleStdoutVsStderr [
	<gtExample>
	<return: #GtShellScriptProcess>
	self
		script: 'echo 2001: A Space Odyssey
echo "I can''t do that, Dave" >&2'
]

{ #category : #private }
GtShellScriptProcess >> execute [
	| builder |
	builder := self newShellScriptBuilder
		arg: (OSPlatform current lineEnding join: self script lines).

	bindings keysAndValuesDo: [ :key :value | builder env: key value: value ].

	childProcess := builder
			pipeStdout;
			pipeStderr;
			spawn.

	self pollStdout.
	self pollStderr.
	self pollChildProcessCompletion
]

{ #category : #'gt extensions' }
GtShellScriptProcess >> gtBindingsFor: aView [
	<gtView>
	bindings ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Bindings';
		object: [ bindings ];
		view: #gtTreeFor:context:
]

{ #category : #'gt extensions' }
GtShellScriptProcess >> gtStartActionFor: composite [
	<gtAction>
	^ composite button
		icon: BrGlamorousVectorIcons play;
		tooltip: 'Start';
		priority: 20;
		action: [ self start ]
]

{ #category : #'gt extensions' }
GtShellScriptProcess >> gtStopActionFor: composite [
	<gtAction>
	^ composite button
		icon: BrGlamorousVectorIcons stop;
		tooltip: 'Stop';
		priority: 30;
		action: [ self stop ]
]

{ #category : #'gt extensions' }
GtShellScriptProcess >> gtViewOutputFor: composite [
	<gtView>
	^ composite textEditor
		title: 'Output';
		priority: 25;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self output ];
		updateWhen: GtShellScriptAnnouncement in: [ self announcer];
		actionUpdateButton
]

{ #category : #'gt extensions' }
GtShellScriptProcess >> gtViewScriptFor: composite [
	<gtView>
	self hasScript ifFalse: [ ^ composite empty ].
	^ composite textEditor
		title: 'Script';
		priority: 20;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self script ]
]

{ #category : #'gt extensions' }
GtShellScriptProcess >> gtViewStateFor: composite [
	<gtView>
	^ composite textEditor
		title: 'State';
		priority: 10;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self stateDescription ];
		updateWhen: GtShellScriptAnnouncement in: [ self announcer];
		actionUpdateButton
]

{ #category : #'gt extensions' }
GtShellScriptProcess >> gtViewStderrFor: composite [
	<gtView>
	stderr ifNil: [ ^ composite empty ].
	^ composite forward
		title: 'Stderr';
		priority: 35;
		object: [ stderr ];
		view: #gtLiveFor:;
		actionUpdateButton
]

{ #category : #'gt extensions' }
GtShellScriptProcess >> gtViewStdoutFor: composite [
	<gtView>
	stdout ifNil: [ ^ composite empty ].
	^ composite forward
		title: 'Stdout';
		priority: 1;
		object: [ stdout ];
		view: #gtLiveFor:;
		actionUpdateButton
]

{ #category : #testing }
GtShellScriptProcess >> hasScript [
	^ script isEmptyOrNil not
]

{ #category : #initialization }
GtShellScriptProcess >> initialize [
	super initialize.
	announcer := Announcer new.
	state := #new.
	stdout := GtTranscript new.
	stderr := GtTranscript new.
	bindings := Dictionary new
]

{ #category : #testing }
GtShellScriptProcess >> isFailure [
	^ self didRun
		and: [ childProcess isTerminated and: [ childProcess wait isSuccess not ] ]
]

{ #category : #testing }
GtShellScriptProcess >> isRunning [
	^ state = #running
]

{ #category : #testing }
GtShellScriptProcess >> isSuccess [
	^ self didRun
		and: [ childProcess isTerminated and: [ childProcess wait isSuccess ] ]
]

{ #category : #private }
GtShellScriptProcess >> newShellScriptBuilder [
	^ OSPlatform current isWindows
		ifTrue: [ 
			GtExternalProcessBuilder new
				command: 'powershell';
				arg: '-c' ]
		ifFalse: [ 
			GtExternalProcessBuilder new
				command: self class bashExecutable;
				arg: '-c' ]
]

{ #category : #accessing }
GtShellScriptProcess >> onSuccess: block [
	"Set block to be executed when the shell script process completes successfully.
	It will be called with the trimmed stdout string value."
	 
	onSuccess := block
]

{ #category : #accessing }
GtShellScriptProcess >> output [
	stdout textDo: [ :text | ^ text asString trimBoth ].
	^ String new
]

{ #category : #private }
GtShellScriptProcess >> pollChildProcessCompletion [
	poller := [ 
		[ childProcess isRunning ] whileTrue: [ 0.5 seconds wait ].
		state := #ran.
		onSuccess ifNotNil: [ onSuccess value: self output ].
		self announce: GtShellScriptStopped ]
			forkAt: Processor userBackgroundPriority
			named: 'poller'
]

{ #category : #private }
GtShellScriptProcess >> pollStderr [
	childProcess asynchronousStderr
		pollStringEvery: 0.5 seconds
		do: [ :aString | stderr show: aString ]
]

{ #category : #private }
GtShellScriptProcess >> pollStdout [
	childProcess asynchronousStdout
		pollStringEvery: 0.5 seconds
		do: [ :aString | stdout show: aString ]
]

{ #category : #printing }
GtShellScriptProcess >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self stateDescription asString;
		nextPut: $)
]

{ #category : #accessing }
GtShellScriptProcess >> script [
	^ script
]

{ #category : #accessing }
GtShellScriptProcess >> script: aString [
	script := aString
]

{ #category : #running }
GtShellScriptProcess >> start [
	self isRunning ifTrue: [ ^ self ].
	self hasScript ifFalse: [ ^ self ].
	self execute.
	state := #running.
	self announce: GtShellScriptStarted
]

{ #category : #accessing }
GtShellScriptProcess >> state [
	^ state
]

{ #category : #accessing }
GtShellScriptProcess >> stateDescription [
	| description |
	description := self state.
	self isSuccess
		ifTrue: [ description := description , ' successfully' ].
	self isFailure
		ifTrue: [ description := description , ' and failed' ].
	^ description
]

{ #category : #running }
GtShellScriptProcess >> stop [
	self isRunning ifFalse: [ ^ self ].
	poller terminate.
	childProcess terminate.
	state := #terminated.
	self announce: GtShellScriptStopped
]
