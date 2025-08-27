"
I provide a registry of topic maps for Lepiter databases.

The actual registry is a a Dictionary that maps the names of databases to the path (String) of the topicMap file relative to `FileLocator gtResource``.

By default there is just a topic map for the GT book. More entries can be added by accessing the `registry` slot.

To enable views and actions, evaluate:
```
TMRegistry uniqueInstance enableActions
```

"
Class {
	#name : #TMRegistry,
	#superclass : #Object,
	#instVars : [
		'registry',
		'actionsEnabled'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #accessing }
TMRegistry class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
TMRegistry class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
TMRegistry >> actionsEnabled [
	^ actionsEnabled
]

{ #category : #initialization }
TMRegistry >> defaultRegistry [
	^ {'Glamorous Toolkit Book' -> 'feenkcom/lepiter/data/gtbookTopicMap.json'}
		asDictionary
]

{ #category : #testing }
TMRegistry >> disableActions [
	actionsEnabled := false
]

{ #category : #testing }
TMRegistry >> enableActions [
	actionsEnabled := true
]

{ #category : #views }
TMRegistry >> gtRegistryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Topic Map Registry';
		priority: 20;
		items: [ [ self registry ] value associations ];
		column: 'Database' text: [ :each | each key gtDisplayString ];
		column: 'Topic Map File' text: [ :each | each value gtDisplayString ];
		send: [ :each | FileLocator gtResource / each value ];
		actionUpdateButton
]

{ #category : #testing }
TMRegistry >> hasTopicMapFor: aDatabaseName [
	^ self registry includesKey: aDatabaseName
]

{ #category : #initialization }
TMRegistry >> initialize [
	super initialize.
	registry := self defaultRegistry.
	self disableActions
]

{ #category : #accessing }
TMRegistry >> registry [
	^ registry
]

{ #category : #accessing }
TMRegistry >> registry: anObject [
	registry := anObject
]

{ #category : #accessing }
TMRegistry >> topicMapFor: aDatabaseName [
	^ TopicMap forJson: FileLocator gtResource / (self registry at: aDatabaseName)
]
