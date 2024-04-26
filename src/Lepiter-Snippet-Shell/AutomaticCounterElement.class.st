"
I am AutomaticCounterElement.
I am a BlElement.

I display a {{gtClass:AutomaticCounter}}'s value.
I show a button to start/stop the automatic incrementing process.
The button changes to show the state (running/paused).

I listen to announcements from my counter to update.
"
Class {
	#name : #AutomaticCounterElement,
	#superclass : #BlElement,
	#instVars : [
		'counter',
		'button',
		'label'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #accessing }
AutomaticCounterElement >> counter [
	^ counter
]

{ #category : #accessing }
AutomaticCounterElement >> counter: anAutomaticCounter [
	counter := anAutomaticCounter
]

{ #category : #initialization }
AutomaticCounterElement >> initialize [
	super initialize.

	self layout: (BlLinearLayout horizontal cellSpacing: 5).
	
	self constraintsDo: [ :c |
		c padding: (BlInsets all: 10).
		c horizontal matchParent.
		c vertical matchParent ].
		
	button := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		action: [ 
			self counter isRunning 
				ifTrue: [ self counter stop ] 
				ifFalse: [ self counter start ] ].
	
	label := BrLabel new
		aptitude: BrGlamorousLabelAptitude.


	self addChildren: { button . label }
]

{ #category : #'hooks - children' }
AutomaticCounterElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self counter announcer
		unsubscribe: self.
	
	self counter announcer
		when: Announcement
		send: #updateFromAnnouncement:
		to: self.
			
	self updateButtonAndLabel
]

{ #category : #'hooks - children' }
AutomaticCounterElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	
	self counter announcer unsubscribe: self
]

{ #category : #private }
AutomaticCounterElement >> updateButtonAndLabel [
	label text: (self counter value asRopedText fontSize: 18).

	self counter isRunning
		ifTrue: [ button icon: BrGlamorousVectorIcons pause; label: 'Stop' ]
		ifFalse: [ button icon: BrGlamorousVectorIcons play; label: 'Start' ]
]

{ #category : #private }
AutomaticCounterElement >> updateFromAnnouncement: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ self updateButtonAndLabel ])
]
