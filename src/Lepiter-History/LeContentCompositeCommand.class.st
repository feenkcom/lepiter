Class {
	#name : #LeContentCompositeCommand,
	#superclass : #LeContentCommand,
	#instVars : [
		'label'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeContentCompositeCommand >> basicExecute [ 
	| subcommandResults |
	
	subcommandResults := self executeSubcommands.
	
	^ self createCommandResult
		subcommandResults: subcommandResults;
		yourself
]

{ #category : #'execution - utils' }
LeContentCompositeCommand >> createCommandResult [
	^ LeContentCompositeCommandExecutionResult forCommand: self
]

{ #category : #converting }
LeContentCompositeCommand >> createCommandSpecification [
	| specification | 
	specification := LeContentCompositeCommandSpecification new 
		contentUid: self targetContent uid;
		commandTypeName: self className;
		label: self label.
	
	self subcommands do: [ :aSubcommand |
		 specification addSubcommandSpecification: aSubcommand createCommandSpecification ].
	
	^ specification
]

{ #category : #printing }
LeContentCompositeCommand >> descriptionOn: aStream [
	aStream 
		<< self label
]

{ #category : #accessing }
LeContentCompositeCommand >> gtViewSubcommandsFor: aView [ 
	<gtView>
	
	^ aView tree
		title: 'Subcommands';
		items: [ { self } ];
		children: [ :aCommand | aCommand subcommands ];
		expandAll
]

{ #category : #initialization }
LeContentCompositeCommand >> initializeFromSpecification: aCommandSpecification withBuilder: aBuilder [
	super initializeFromSpecification: aCommandSpecification withBuilder: aBuilder.
	
	self label: aCommandSpecification label
]

{ #category : #accessing }
LeContentCompositeCommand >> label [

	^ label
]

{ #category : #accessing }
LeContentCompositeCommand >> label: aString [

	label := aString
]

{ #category : #printing }
LeContentCompositeCommand >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [ 
		self descriptionOn: aStream ]
]
