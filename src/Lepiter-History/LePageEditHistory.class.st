Class {
	#name : #LePageEditHistory,
	#superclass : #Object,
	#instVars : [
		'editCommands'
	],
	#category : #'Lepiter-History'
}

{ #category : #adding }
LePageEditHistory >> addCommand: anEditCommand [
	self editCommands add: anEditCommand
]

{ #category : #accessing }
LePageEditHistory >> editCommands [
	^ editCommands ifNil: [ 
		editCommands := OrderedCollection new ]
]

{ #category : #'gt - extensions' }
LePageEditHistory >> gtViewCommandsListFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Log';
		items: [ self editCommands ];
		column: 'Command' text: [ :aCommand | aCommand class commandDescription ];
		column: 'Target' text: [ :aCommand | aCommand targetSnippetUid ]
]

{ #category : #recording }
LePageEditHistory >> recordMoveUpForSnippet: aSnippet [
	self addCommand: (LePageMoveUpSnippetCommand new
		targetSnippetUid: aSnippet uid)
]
