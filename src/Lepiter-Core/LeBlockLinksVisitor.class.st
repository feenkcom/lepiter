Class {
	#name : #LeBlockLinksVisitor,
	#superclass : #LeContentNodeVisitor,
	#traits : 'TLeExtensibleContentNodeVisitor + TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait + TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'links'
	],
	#category : #'Lepiter-Core-Utility'
}

{ #category : #accessing }
LeBlockLinksVisitor class >> defaultComponentVisitorClasses [
	^ {LePageLinkAnnotationVisitor}
]

{ #category : #defaults }
LeBlockLinksVisitor >> defaultLinks [
	^ OrderedCollection new
]

{ #category : #initialization }
LeBlockLinksVisitor >> initialize [
	super initialize.
	links := self defaultLinks.
]

{ #category : #accessing }
LeBlockLinksVisitor >> links [
	<return: #Collection of: #LeTextualLink>
	^ links
]

{ #category : #accessing }
LeBlockLinksVisitor >> visitBlockLink: aLink [
	super visitBlockLink: aLink.
	links add: (LeTextualSnippetLink new 
		node: aLink; 
		targetSnippetUid: aLink linkUID).
]

{ #category : #accessing }
LeBlockLinksVisitor >> visitPageLink: aLink [
	super visitPageLink: aLink.
	links add: (LeTextualPageLink new 
		node: aLink; 
		targetPageTitle: aLink linkUID).
]
