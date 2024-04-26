"
I am AutomaticCounter.

I model a monotonously increasing counter (#value and #increment).
I can function autonomously, incrementing each second in a separate process (#start and #stop).
I send generic announcements to my announcer when I change (#announcer and #announceChange).

My GT views update automatically.
My GT actions control my incrementing process (start/stop) or allow manual incrementing.

{{gtExample:AutomaticCounter>>#example}}
"
Class {
	#name : #AutomaticCounter,
	#superclass : #Object,
	#instVars : [
		'counter',
		'announcer',
		'process'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #private }
AutomaticCounter >> announceChange [
	self announcer announce: Announcement new
]

{ #category : #accessing }
AutomaticCounter >> announcer [
	^ announcer 
]

{ #category : #converting }
AutomaticCounter >> asElement [
	^ AutomaticCounterElement new counter: self
]

{ #category : #examples }
AutomaticCounter >> example [
	<gtExample>
	self assert: self value isZero.
	self assert: self isRunning not
]

{ #category : #'gt extensions' }
AutomaticCounter >> gtElementFor: composite [
	<gtView>
	^ composite explicit
		title: 'Element';
		priority: 20;
		stencil: [ self asElement ]
]

{ #category : #'gt extensions' }
AutomaticCounter >> gtIncrementActionFor: composite [
	<gtAction>
	^ composite button
		icon: BrGlamorousVectorIcons add;
		tooltip: 'Increment';
		priority: 10;
		action: [ self increment ]
]

{ #category : #'gt extensions' }
AutomaticCounter >> gtPreviewFor: composite [
	<gtView>
	^ composite textEditor
		title: 'Live';
		priority: 10;
		text: [ self value asRopedText fontSize: 64 ];
		updateWhen: Announcement in: [ self announcer ];
		actionUpdateButton
]

{ #category : #'gt extensions' }
AutomaticCounter >> gtStartActionFor: composite [
	<gtAction>
	^ composite button
		icon: BrGlamorousVectorIcons play;
		tooltip: 'Start';
		priority: 20;
		action: [ self start ]
]

{ #category : #'gt extensions' }
AutomaticCounter >> gtStopActionFor: composite [
	<gtAction>
	^ composite button
		icon: BrGlamorousVectorIcons pause;
		tooltip: 'Stop';
		priority: 30;
		action: [ self stop ]
]

{ #category : #running }
AutomaticCounter >> increment [
	counter := counter + 1.
	self announceChange
]

{ #category : #initialization }
AutomaticCounter >> initialize [
	super initialize.
	counter := 0.
	announcer := Announcer new
]

{ #category : #testing }
AutomaticCounter >> isRunning [
	^ process notNil
]

{ #category : #running }
AutomaticCounter >> start [
	self isRunning ifTrue: [ ^ self ].
	
	process := [ 
			[ 
				self increment.
				1 second wait ] repeat ] 
		forkAt: Processor userBackgroundPriority 
		named: self class name.
		
	self announceChange
]

{ #category : #running }
AutomaticCounter >> stop [
	process ifNotNil: [
		process terminate.
		process := nil.
		self announceChange ]
]

{ #category : #accessing }
AutomaticCounter >> value [
	^ counter
]
