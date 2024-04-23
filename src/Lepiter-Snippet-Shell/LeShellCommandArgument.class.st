Class {
	#name : #LeShellCommandArgument,
	#superclass : #Object,
	#instVars : [
		'string'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #printing }
LeShellCommandArgument >> printOn: stream [
	stream nextPutAll: string
]

{ #category : #accessing }
LeShellCommandArgument >> string [
	^ string
]

{ #category : #accessing }
LeShellCommandArgument >> string: anObject [
	string := anObject
]

{ #category : #magritte }
LeShellCommandArgument >> stringDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 1;
		label: '';
		accessor: #string;
		default: ''
]
