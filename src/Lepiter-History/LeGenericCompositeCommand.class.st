Class {
	#name : #LeGenericCompositeCommand,
	#superclass : #LeContentCommand,
	#instVars : [
		'label'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #converting }
LeGenericCompositeCommand >> createCommandSpecification [
	| specification | 
	specification := LeCompositeCommandSpecification new 
		commandUid: self uid;
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

{ #category : #execution }
LeGenericCompositeCommand >> execute [ 
	self subcommands do: [ :aSubcommand | aSubcommand execute ]
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

{ #category : #accessing }
LeGenericCompositeCommand >> label [

	^ label
]

{ #category : #accessing }
LeGenericCompositeCommand >> label: aString [

	label := aString
]
