"
Demonstrate the operation of {{gtClass:name=LeHtmlFragmentExporterVisitor}}.

Since there is no page or database present at this level, links to other pages, etc. can't be resolved and page related tags such as body, metadata, etc. are not included.  See {{gtClass:name=LeHtmlPageExporterVisitor}}.

"
Class {
	#name : #LeHtmlFragmentExporterExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #examples }
LeHtmlFragmentExporterExamples >> basicMarkdown [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |
	markdown := LeTextSnippet string: '*italic* **bold** `mono`'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	self assert: html trimBoth
		equals: '<div class="text_snippet">
	<i>
		italic
	</i>
	 
	<b>
		bold
	</b>
	 
	<code>
		mono
	</code>
</div>'.
	^ html
]

{ #category : #examples }
LeHtmlFragmentExporterExamples >> classAnnotation [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '{{gtClass:LeHtmlFragmentExporterExamples}}'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	^ html
]

{ #category : #examples }
LeHtmlFragmentExporterExamples >> codeBlock [
	"Confirm that a code block is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '```\answer:=42.\```' withCRs.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
		
	self assert: html trimBoth
		equals: '<div class="text_snippet">
	<div class="code_block">
		<pre>
			<code class="smalltalk">

answer:=42.

			</code>
		</pre>
	</div>
</div>'.
	^ html
]

{ #category : #examples }
LeHtmlFragmentExporterExamples >> methodAnnotation [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '{{gtMethod:LeHtmlFragmentExporterExamples>>#basicMarkdown}}'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	self assert: (html includesSubstring: 'method_annotation').
	self assert: (html includesSubstring: 'LeHtmlFragmentExporterExamples&gt;&gt;#basicMarkdown').
	self assert: (html includesSubstring: 'method_definition').
	^ html
]

{ #category : #accessing }
LeHtmlFragmentExporterExamples >> pharoSnippet [
	<gtExample>
	| markdown html |
	markdown := LePharoSnippet code: 'answer := 41.'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	^ html

]
