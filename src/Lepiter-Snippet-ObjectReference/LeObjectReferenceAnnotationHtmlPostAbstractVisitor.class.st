"
I write `gtObject` annotations ({{gtClass:LeObjectReferenceAnnotationNode}}) as plain text into page abstracts (e.g. HTML page descriptions): the fallback label, or the object id if there is none.
I am a component visitor of {{gtClass:LeHtmlTextSnippetPostAbstractVisitor}}: I register myself in {{gtMethod:LeObjectReferenceAnnotationHtmlPostAbstractVisitor class>>#initialize}} and deregister in {{gtMethod:LeObjectReferenceAnnotationHtmlPostAbstractVisitor class>>#obsolete}}.
See {{gtExample:LeObjectReferenceAnnotationExportExamples>>#postAbstractTextSnippetWithLabeledObjectAnnotation}}.
"
Class {
	#name : #LeObjectReferenceAnnotationHtmlPostAbstractVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TLeObjectReferenceParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeObjectReferenceParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #initialization }
LeObjectReferenceAnnotationHtmlPostAbstractVisitor class >> initialize [
	LeHtmlTextSnippetPostAbstractVisitor addComponentVisitorClass: self

]

{ #category : #initialization }
LeObjectReferenceAnnotationHtmlPostAbstractVisitor class >> obsolete [
	LeHtmlTextSnippetPostAbstractVisitor removeComponentVisitorClass: self.
	^ super obsolete

]

{ #category : #accessing }
LeObjectReferenceAnnotationHtmlPostAbstractVisitor >> context [
	^ self composite context

]

{ #category : #visiting }
LeObjectReferenceAnnotationHtmlPostAbstractVisitor >> visitObjectReferenceAnnotation: anObjectAnnotation [
	(anObjectAnnotation fallbackLabelString ifNil: [ anObjectAnnotation uuid ])
		ifNotNil: [ :aLabel | self context html escape: aLabel ]

]
