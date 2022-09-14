Class {
	#name : #LePageLinkVisitor,
	#superclass : #LeContentNodeVisitor,
	#traits : 'TLeExtensibleContentNodeVisitor',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait',
	#instVars : [
		'linkedPages'
	],
	#category : #'Lepiter-Utilities-Utilities'
}

{ #category : #initialization }
LePageLinkVisitor >> initialize [

	super initialize.
	linkedPages := OrderedCollection new.
]

{ #category : #accessing }
LePageLinkVisitor >> linkedPages [
	^ linkedPages
]

{ #category : #visitor }
LePageLinkVisitor >> visitPageLink: aPageLink [

	linkedPages add: aPageLink linkUID.
	self visitSmaCCParseNode: aPageLink
]
