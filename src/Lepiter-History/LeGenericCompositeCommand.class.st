Class {
	#name : #LeGenericCompositeCommand,
	#superclass : #LeContentCommand,
	#instVars : [
		'label'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeGenericCompositeCommand >> basicExecute [ 
	| subcommandResults |
	
	subcommandResults := self executeSubcommands.
	
	^ self createCommandResult
		subcommandResults: subcommandResults;
		yourself
]

{ #category : #'execution - utils' }
LeGenericCompositeCommand >> createCommandResult [
	^ LeCompositeCommandExecutionResult forCommand: self
]

{ #category : #converting }
LeGenericCompositeCommand >> createCommandSpecification [
	| specification | 
	specification := LeCompositeCommandSpecification new 
		contentUid: self targetContent uid;
		commandTypeName: self className;
		label: self label.
	
	self subcommands do: [ :aSubcommand |
		 specification addSubcommandSpecification: aSubcommand createCommandSpecification ].
	
	^ specification
]

{ #category : #printing }
LeGenericCompositeCommand >> descriptionOn: aStream [
	aStream 
		<< self label
]

{ #category : #accessing }
LeGenericCompositeCommand >> gtViewSubcommandsFor: aView [ 
	<gtView>
	
	^ aView tree
		title: 'Subcommands';
		items: [ { self } ];
		children: [ :aCommand | aCommand subcommands ];
		expandAll
]

{ #category : #initialization }
LeGenericCompositeCommand >> initializeFromSpecification: aCommandSpecification withBuilder: aBuilder [
	super initializeFromSpecification: aCommandSpecification withBuilder: aBuilder.
	
	self label: aCommandSpecification label
]

{ #category : #accessing }
LeGenericCompositeCommand >> label [

	^ label
]

{ #category : #accessing }
LeGenericCompositeCommand >> label: aString [

	label := aString
]

{ #category : #printing }
LeGenericCompositeCommand >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [ 
		self descriptionOn: aStream ]
]
