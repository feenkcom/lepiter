Class {
	#name : #LeLocalMonitorElementHandler,
	#superclass : #Object,
	#instVars : [
		'element',
		'monitor'
	],
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #'instance creation' }
LeLocalMonitorElementHandler class >> forElement: anElement monitor: aMonitor [

	| aHandler |
	aHandler := self new
		            element: anElement;
		            monitor: aMonitor.

	aMonitor weak
		when: LeLocalStoreMonitorStarted
		send: #onChange
		to: aHandler.
	aMonitor weak
		when: LeLocalStoreMonitorStopped
		send: #onChange
		to: aHandler.

	anElement userData at: self put: aHandler.
	
	aHandler update.
	
	^ aHandler
]

{ #category : #accessing }
LeLocalMonitorElementHandler >> element [

	^ element
]

{ #category : #accessing }
LeLocalMonitorElementHandler >> element: anObject [

	element := anObject
]

{ #category : #accessing }
LeLocalMonitorElementHandler >> monitor [

	^ monitor
]

{ #category : #accessing }
LeLocalMonitorElementHandler >> monitor: anObject [

	monitor := anObject
]

{ #category : #'private - announcement handling' }
LeLocalMonitorElementHandler >> onChange [

	self element ifNil: [ ^ self ].
	self monitor ifNil: [ ^ self ].

	self element enqueueTask: (BlTaskAction new action: [ self update ])
]

{ #category : #updating }
LeLocalMonitorElementHandler >> update [

	self element ifNil: [ ^ self ].
	self monitor ifNil: [ ^ self ].

	self monitor isRunning
		ifTrue: [ 
			self element visibility: BlVisibility hidden.
			self element disable ]
		ifFalse: [ 
			self element visibility: BlVisibility visible.
			self element enable ]
]
