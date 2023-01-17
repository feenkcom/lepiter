Class {
	#name : #LeCompositeCommandExecutionResult,
	#superclass : #LeCommandExecutionResult,
	#instVars : [
		'subcommandResults'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeCompositeCommandExecutionResult >> subcommandResults [
	^ subcommandResults
]

{ #category : #accessing }
LeCompositeCommandExecutionResult >> subcommandResults: aCollectionOfResults [
	subcommandResults := aCollectionOfResults
]

{ #category : #'updating - view model' }
LeCompositeCommandExecutionResult >> updateSnippetsViewModelFor: aSnippetsViewModel [
	self subcommandResults first 
		updateSnippetsViewModelFor: aSnippetsViewModel
]
