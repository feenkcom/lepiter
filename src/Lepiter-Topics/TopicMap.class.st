Class {
	#name : #TopicMap,
	#superclass : #Object,
	#instVars : [
		'jsonFile',
		'json'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TopicMap class >> forJson: aFileReference [
	^ self new
		jsonFile: aFileReference;
		yourself
]

{ #category : #accessing }
TopicMap >> database [
	^ self json at: 'database'
]

{ #category : #views }
TopicMap >> gtJsonFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON';
		priority: 10;
		object: [ self json ];
		view: #gtTreeFor:context:
]

{ #category : #accessing }
TopicMap >> json [
	^ json ifNil: [ json := STONJSON fromString: self jsonFile contents ]
]

{ #category : #accessing }
TopicMap >> jsonFile [
	^ jsonFile
]

{ #category : #accessing }
TopicMap >> jsonFile: aFileReference [
	jsonFile := aFileReference
]
