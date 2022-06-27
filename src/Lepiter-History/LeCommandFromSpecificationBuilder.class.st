Class {
	#name : #LeCommandFromSpecificationBuilder,
	#superclass : #Object,
	#instVars : [
		'commandSpecification',
		'targetPage'
	],
	#category : #'Lepiter-History-Builders'
}

{ #category : #accessing }
LeCommandFromSpecificationBuilder >> commandSpecification [

	^ commandSpecification
]

{ #category : #accessing }
LeCommandFromSpecificationBuilder >> commandSpecification: anObject [

	commandSpecification := anObject
]

{ #category : #'as yet unclassified' }
LeCommandFromSpecificationBuilder >> createCommand [
	| newCommand |
	newCommand := self commandSpecification commandType new.
	newCommand targetContent: self targetContentFromSpecification.
	newCommand 
		initializeFromSpecification: self commandSpecification 
		withBuilder: self.
	
	self createSubcommandsFor: newCommand.
	
	^ newCommand
]

{ #category : #accessing }
LeCommandFromSpecificationBuilder >> createSubcommandsFor: aCommand [
	self commandSpecification subcommandSpecifications 
		do: [ :aSubcommandSpecification |
			| subcommand |
			subcommand := aSubcommandSpecification createCommandForPage: self targetPage.
			aCommand addSubcommand: subcommand ]. 
]

{ #category : #'as yet unclassified' }
LeCommandFromSpecificationBuilder >> locateContentWithUid: anUid [
	self targetPage withAllChildrenBreadthFirstDo: [ :aContent |
		aContent uid = anUid ifTrue: [ ^ aContent ] ].
	
	Error signal: 'Could not find content with uid ', anUid printString.
]

{ #category : #'as yet unclassified' }
LeCommandFromSpecificationBuilder >> targetContentFromSpecification [
	^ self locateContentWithUid: self commandSpecification contentUid
]

{ #category : #accessing }
LeCommandFromSpecificationBuilder >> targetPage [

	^ targetPage
]

{ #category : #accessing }
LeCommandFromSpecificationBuilder >> targetPage: anObject [

	targetPage := anObject
]
