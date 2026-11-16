"
I exemplify how `gtObject` annotations ({{gtClass:LeObjectReferenceAnnotationNode}}) are processed by the text export, the HTML export and the HTML post-abstract visitors.
Exported pages have no object registry, so the HTML export writes the fallback label as a code label, see {{gtExample:LeObjectReferenceAnnotationExportExamples>>#htmlTextSnippetWithLabeledObjectAnnotation}}.
Without a fallback label it writes the object id and logs the annotation, see {{gtExample:LeObjectReferenceAnnotationExportExamples>>#htmlTextSnippetWithObjectAnnotation}}.
"
Class {
	#name : #LeObjectReferenceAnnotationExportExamples,
	#superclass : #Object,
	#traits : 'TLeHtmlContentAssertions',
	#classTraits : 'TLeHtmlContentAssertions classTrait',
	#category : #'Lepiter-Snippet-ObjectReference-Examples'
}

{ #category : #examples }
LeObjectReferenceAnnotationExportExamples >> exportTextSnippetWithObjectAnnotation [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor |
	snippet := self textSnippetWithObjectAnnotation.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: LeExportMemoryStore new).

	snippet acceptVisitor: visitor.

	self assert: resources size equals: 0.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #'examples - labeled' }
LeObjectReferenceAnnotationExportExamples >> htmlTextSnippetWithLabeledObjectAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet resources context visitor html |
	snippet := self textSnippetWithLabeledObjectAnnotation.
	snippet
		acceptVisitor: (LeExportVisitor new
				context: (LeExportContext new
						resources: (resources := LeExportResources new);
						fileStore: LeExportMemoryStore new)).
	self assert: resources size equals: 0.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).
	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		includes: 'See <code class="annotation annotation-label annotation-label-object">My object</code> here'.
	self assert: context log asArray size equals: 0.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #examples }
LeObjectReferenceAnnotationExportExamples >> htmlTextSnippetWithObjectAnnotation [
	"The annotation has no fallback label: the object id is written and the export logs it"

	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| holder snippet context visitor html aLogItem |
	holder := self exportTextSnippetWithObjectAnnotation.
	snippet := holder snippet.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: holder resources).
	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		includes: 'See <code class="annotation annotation-label annotation-label-object">eehjmwhvkh4de3o55fyirb3fo</code> here'.
	self assert: context log asArray size equals: 1.
	aLogItem := context log asArray first.
	self assert: aLogItem class equals: LeExportUnresolvedAnnotationLogItem.
	self assert: aLogItem snippet equals: snippet.
	self assert: aLogItem annotation class equals: LeObjectReferenceAnnotationNode.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #'examples - labeled' }
LeObjectReferenceAnnotationExportExamples >> postAbstractTextSnippetWithLabeledObjectAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor html |
	snippet := self textSnippetWithLabeledObjectAnnotation.

	visitor := LeHtmlTextSnippetPostAbstractVisitor new
			context: LeHtmlContext new;
			snippet: snippet.
	html := visitor contentsFor: snippet.

	self assertHtml: html equals: 'See My object here'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #examples }
LeObjectReferenceAnnotationExportExamples >> postAbstractTextSnippetWithObjectAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor html |
	snippet := self textSnippetWithObjectAnnotation.

	visitor := LeHtmlTextSnippetPostAbstractVisitor new
			context: LeHtmlContext new;
			snippet: snippet.
	html := visitor contentsFor: snippet.

	self assertHtml: html equals: 'See eehjmwhvkh4de3o55fyirb3fo here'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #examples }
LeObjectReferenceAnnotationExportExamples >> registrationIsIdempotent [
	<gtExample>
	<return: #Array>
	| registries before |
	registries := {
		LeHtmlTextSnippetVisitor componentVisitorClasses -> LeObjectReferenceAnnotationHtmlVisitor.
		LeHtmlTextSnippetPostAbstractVisitor componentVisitorClasses -> LeObjectReferenceAnnotationHtmlPostAbstractVisitor }.
	before := registries collect: [ :each | each key copy ].
	[ LeObjectReferenceAnnotationHtmlVisitor
		initialize;
		initialize.
	LeObjectReferenceAnnotationHtmlPostAbstractVisitor
		initialize;
		initialize.
	registries
		do: [ :each | self assert: (each key occurrencesOf: each value) equals: 1 ] ]
		ensure: [ registries
				with: before
				do: [ :each :classes |
					each key
						removeAll;
						addAll: classes ] ].
	^ registries

]

{ #category : #'examples - labeled' }
LeObjectReferenceAnnotationExportExamples >> textSnippetWithLabeledObjectAnnotation [
	<gtExample>
	<return: #LeTextSnippet>
	^ LeTextSnippet
		string: 'See {{gtObject:id=eehjmwhvkh4de3o55fyirb3fo|fallbackLabelString=''My object''}} here'

]

{ #category : #examples }
LeObjectReferenceAnnotationExportExamples >> textSnippetWithObjectAnnotation [
	<gtExample>
	<return: #LeTextSnippet>
	^ LeTextSnippet string: 'See {{gtObject:id=eehjmwhvkh4de3o55fyirb3fo|label=#gtDisplayString}} here'

]
