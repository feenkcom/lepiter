Class {
	#name : #LesPageResourceVisitor,
	#superclass : #LeResourcesVisitor,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'page'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #building }
LesPageResourceVisitor >> compute [
	self page acceptVisitor: self.
	^ self resources
]

{ #category : #accessing }
LesPageResourceVisitor >> page [
	^ page
]

{ #category : #accessing }
LesPageResourceVisitor >> page: anObject [
	page := anObject
]

{ #category : #visiting }
LesPageResourceVisitor >> visitTextSnippet: aLeTextSnippet [
	| snippetVisitor |
	snippetVisitor := LeTextSnippetResourcesVisitor new
		textSnippet: aLeTextSnippet.
	snippetVisitor compute.
	self addResources: snippetVisitor resources.
	
	^ self visitTextualSnippet: aLeTextSnippet
]
