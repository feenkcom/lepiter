Class {
	#name : #LeCommandSpecification,
	#superclass : #Object,
	#instVars : [
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

{ #category : #transformation }
LeCommandSpecification >> asSpecificationForLogStorage [
	"Hook method to return a version of the specification for storing in the edit log.
	By default we return the current specification."
	
	^ self
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

{ #category : #printing }
LeCommandSpecification >> descriptionOn: aStream [ 
	
	aStream 
		<< self commandTypeName;
		<< ', ';
		print: self contentUid 
]

{ #category : #'gt - extensions' }
LeCommandSpecification >> gtCommonAttributes [
	| variableNodes |
	variableNodes := OrderedCollection new.
	self  gtInspectorVariableNodesIn: variableNodes.
	^ variableNodes collect: [ :aNode |
		aNode label -> aNode rawValue ]
]

{ #category : #'gt - extensions' }
LeCommandSpecification >> gtViewSpecificationAttributesFor: aView [
	<gtView>
	
	^ aView columnedList 
		title: 'Command attributes';
		priority: 10;
		items: [ 
			self gtCommonAttributes ];
		column: 'Variable' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ];
		send: #value
]

{ #category : #'gt - extensions' }
LeCommandSpecification >> gtViewSubcommandsFor: aView [ 
	<gtView>
	
	self subcommandSpecifications ifEmpty: [ ^ aView empty ].
	
	^ aView tree
		title: 'Subcommands';
		priority: 15;
		items: [ { self } ];
		children: [ :aCommand | aCommand subcommandSpecifications ];
		expandAll
]

{ #category : #printing }
LeCommandSpecification >> printOn: aStream [ 
	super printOn: aStream .
	
	aStream parenthesize: [
		self descriptionOn:  aStream ]
]

{ #category : #accessing }
LeCommandSpecification >> subcommandSpecifications [
	^ subcommandSpecifications ifNil: [ 
		subcommandSpecifications := OrderedCollection new ]
]
