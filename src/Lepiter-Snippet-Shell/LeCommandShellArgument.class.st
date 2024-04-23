Class {
	#name : #LeCommandShellArgument,
	#superclass : #Object,
	#instVars : [
		'string'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #printing }
LeCommandShellArgument >> printOn: stream [
	stream nextPutAll: string
]

{ #category : #accessing }
LeCommandShellArgument >> string [
	^ string
]

{ #category : #accessing }
LeCommandShellArgument >> string: anObject [
	string := anObject
]

{ #category : #magritte }
LeCommandShellArgument >> stringDescription [
	<magritteDescription>
	^ MAStringDescription new
		priority: 1;
		label: '';
		accessor: #string;
		default: ''
]
