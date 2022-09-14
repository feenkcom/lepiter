"
LeUnlinkedReferenceTextSnippetVisitor extracts the text that should be used for unlinked reference matching.

Currently this is: 

- Plain text 
- Class and Method names

Explicitly excluded are internal links (double bracket links).

"
Class {
	#name : #LeUnlinkedReferenceTextSnippetVisitor,
	#superclass : #Object,
	#traits : 'TLeExtensibleContentNodeVisitor + TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TLeExtensibleContentNodeVisitor classTrait + TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'stream'
	],
	#category : #'Lepiter-Utilities-Utilities'
}

{ #category : #accessing }
LeUnlinkedReferenceTextSnippetVisitor class >> defaultComponentVisitorClasses [
	^ {LeUnlinkedReferenceAnnotationVisitor}
]

{ #category : #accessing }
LeUnlinkedReferenceTextSnippetVisitor >> stream [
	^ stream
]

{ #category : #accessing }
LeUnlinkedReferenceTextSnippetVisitor >> stream: anObject [
	stream := anObject.
	visitors := nil.
	self initializeComponentVisitors.
	visitors do: [ :each | each stream: stream ]
]

{ #category : #visiting }
LeUnlinkedReferenceTextSnippetVisitor >> visitText: aText [

	stream << aText content
]
