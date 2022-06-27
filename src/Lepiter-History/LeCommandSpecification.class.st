Class {
	#name : #LeCommandSpecification,
	#superclass : #Object,
	#instVars : [
		'commandUid',
		'contentUid',
		'commandTypeName',
		'subcommandSpecifications'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #adding }
LeCommandSpecification >> addSubcommandSpecification: aCommandSpecification [ 
	self subcommandSpecifications add: aCommandSpecification
]

{ #category : #accessing }
LeCommandSpecification >> commandType [
	self assert: [ self commandTypeName notNil ].
	
	^ self class environment at: self commandTypeName asSymbol
]

{ #category : #accessing }
LeCommandSpecification >> commandTypeName [

	^ commandTypeName
]

{ #category : #accessing }
LeCommandSpecification >> commandTypeName: aTypeName [

	commandTypeName := aTypeName
]

{ #category : #accessing }
LeCommandSpecification >> commandUid [

	^ commandUid
]

{ #category : #accessing }
LeCommandSpecification >> commandUid: anUid [

	commandUid := anUid
]

{ #category : #accessing }
LeCommandSpecification >> contentUid [

	^ contentUid
]

{ #category : #accessing }
LeCommandSpecification >> contentUid: anUid [

	contentUid := anUid
]

{ #category : #'command creation' }
LeCommandSpecification >> createCommandForPage: aPage [
	^ (LeCommandFromSpecificationBuilder new 
		commandSpecification: self;
		targetPage: aPage) createCommand
]

{ #category : #'gt - extensions' }
LeCommandSpecification >> gtViewSpecificationAttributesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Command Attributes';
		priority: 10;
		items: [ 
			| variableNodes |
			variableNodes := OrderedCollection new.
			self  gtInspectorVariableNodesIn: variableNodes.
			variableNodes ];
		column: 'Variable' text: [ :aNode | aNode label ];
		column: 'Value' text: [ :aNode | aNode rawValue ];
		send: #value
]

{ #category : #'gt - extensions' }
LeCommandSpecification >> gtViewSubcommandsFor: aView [ 
	<gtView>
	
	^ aView tree
		title: 'Subcommands';
		priority: 15;
		items: [ { self } ];
		children: [ :aCommand | aCommand subcommandSpecifications ];
		expandAll
]

{ #category : #accessing }
LeCommandSpecification >> subcommandSpecifications [
	^ subcommandSpecifications ifNil: [ 
		subcommandSpecifications := OrderedCollection new ]
]
