Class {
	#name : #LeContentCompositeCommandExecutionResult,
	#superclass : #LeCommandExecutionResult,
	#instVars : [
		'subcommandResults'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeContentCompositeCommandExecutionResult >> subcommandResults [
	^ subcommandResults
]

{ #category : #accessing }
LeContentCompositeCommandExecutionResult >> subcommandResults: aCollectionOfResults [
	subcommandResults := aCollectionOfResults
]

{ #category : #'updating - view model' }
LeContentCompositeCommandExecutionResult >> updateSnippetsViewModelFor: aSnippetsViewModel [
	self subcommandResults first 
		updateSnippetsViewModelFor: aSnippetsViewModel
]
