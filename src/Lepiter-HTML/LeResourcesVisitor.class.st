Class {
	#name : #LeResourcesVisitor,
	#superclass : #Object,
	#instVars : [
		'resources'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #adding }
LeResourcesVisitor >> addResource: aResource [
	self resources add: aResource
]

{ #category : #adding }
LeResourcesVisitor >> addResources: aCollection [
	self resources addAll: aCollection
]

{ #category : #initialization }
LeResourcesVisitor >> initialize [ 	
	super initialize.
	resources := OrderedCollection new.
]

{ #category : #accessing }
LeResourcesVisitor >> resources [
	^ resources
]
