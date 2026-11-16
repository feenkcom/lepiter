"
I write `gtObject` annotations ({{gtClass:LeObjectReferenceAnnotationNode}}) to HTML as a code label.
Exported pages have no object registry (see {{gtMethod:LeObjectReferenceAnnotationStyler>>#resolveObjectRegistry}}), so I write the label the editor shows for a missing object: the fallback label, or the object id if there is none. Without a fallback label I also log a {{gtClass:LeExportUnresolvedAnnotationLogItem}}.
I am a component visitor of {{gtClass:LeHtmlTextSnippetVisitor}}: I register myself in {{gtMethod:LeObjectReferenceAnnotationHtmlVisitor class>>#initialize}} and deregister in {{gtMethod:LeObjectReferenceAnnotationHtmlVisitor class>>#obsolete}}, so the core {{gtPackage:Lepiter-HTML}} package does not depend on {{gtPackage:Lepiter-Snippet-ObjectReference}}.
See {{gtExample:LeObjectReferenceAnnotationExportExamples>>#htmlTextSnippetWithLabeledObjectAnnotation}} and {{gtExample:LeObjectReferenceAnnotationExportExamples>>#htmlTextSnippetWithObjectAnnotation}}.
"
Class {
	#name : #LeObjectReferenceAnnotationHtmlVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TLeObjectReferenceParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeObjectReferenceParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #initialization }
LeObjectReferenceAnnotationHtmlVisitor class >> initialize [
	LeHtmlTextSnippetVisitor addComponentVisitorClass: self

]

{ #category : #initialization }
LeObjectReferenceAnnotationHtmlVisitor class >> obsolete [
	LeHtmlTextSnippetVisitor removeComponentVisitorClass: self.
	^ super obsolete

]

{ #category : #accessing }
LeObjectReferenceAnnotationHtmlVisitor >> context [
	^ self composite context

]

{ #category : #private }
LeObjectReferenceAnnotationHtmlVisitor >> logObjectAnnotationWithoutLabel: anObjectAnnotation [
	^ self context log
		addItem: (LeExportUnresolvedAnnotationLogItem new
				snippet: self composite snippet;
				annotation: anObjectAnnotation;
				reason: ('Object reference without a label: {1}'
						format: {anObjectAnnotation uuid ifNil: [ '' ]}))

]

{ #category : #visiting }
LeObjectReferenceAnnotationHtmlVisitor >> visitObjectReferenceAnnotation: anObjectAnnotation [
	| aLabel |
	aLabel := anObjectAnnotation fallbackLabelString.
	aLabel
		ifNil: [ self logObjectAnnotationWithoutLabel: anObjectAnnotation.
			aLabel := anObjectAnnotation uuid ].
	aLabel ifNil: [ ^ self ].

	self context html
		inlineTag: 'code'
		attributes: #('class' 'annotation annotation-label annotation-label-object')
		with: aLabel

]
