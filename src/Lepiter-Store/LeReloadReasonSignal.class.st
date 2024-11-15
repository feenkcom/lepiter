Class {
	#name : #LeReloadReasonSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'reason'
	],
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #'gt - extensions' }
LeReloadReasonSignal >> gtOverviewFor: aView [
	<gtView>
	^ aView forward
		title: 'Overview';
		priority: 0;
		object: [ self reason ];
		view: #gtOverviewFor:
]

{ #category : #printing }
LeReloadReasonSignal >> printOneLineContentsOn: aStream [
	self reason gtDisplayOn: aStream
]

{ #category : #accessing }
LeReloadReasonSignal >> reason [
	<return: #LeReloadReason>
	^ reason
]

{ #category : #accessing }
LeReloadReasonSignal >> reason: aReason [
	reason := aReason
]
