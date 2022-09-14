Class {
	#name : #LeTextSnippetResourcesVisitor,
	#superclass : #LeResourcesVisitor,
	#traits : 'TLeExtensibleContentNodeVisitor',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait',
	#instVars : [
		'textSnippet'
	],
	#category : #'Lepiter-HTML-Exporter'
}

{ #category : #building }
LeTextSnippetResourcesVisitor >> compute [
	self textSnippet ast acceptVisitor: self.
	^ self resources
]

{ #category : #testing }
LeTextSnippetResourcesVisitor >> isLocalAttachmentUrl: aUrlLink [
	^ aUrlLink beginsWith: 'file://'
]

{ #category : #accessing }
LeTextSnippetResourcesVisitor >> textSnippet [
	^ textSnippet
]

{ #category : #accessing }
LeTextSnippetResourcesVisitor >> textSnippet: anObject [
	textSnippet := anObject
]

{ #category : #generated }
LeTextSnippetResourcesVisitor >> visitExternalLink: anExternalLink [
	| linkUrl fileName |
	linkUrl := anExternalLink url.
	(self isLocalAttachmentUrl: linkUrl) ifFalse: [ 
		^ self ].
	
	fileName := GtFileUtility fileNameOfUri: linkUrl.
	self addResource: (LeLocalAttachmentResource new
		source: self textSnippet;
		name: fileName;
		fileReference: self textSnippet 
			database monitor localRoot asFileReference / fileName)
]
