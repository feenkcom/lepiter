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
		equals: '<div class="snippet textual-snippet text-snippet">
<i>italic</i> <b>bold</b> <code>mono</code></div>'.
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
		equals: '<div class="snippet textual-snippet text-snippet">
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
LeHtmlFragmentExporterExamples >> exampleSnippet [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeExampleSnippet new 
		exampleBehaviorName: 'LeHtmlFragmentExporterExamples';
		exampleSelector: 'pictureSnippet'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: ((LeHtmlFragmentExporterVisitor new 
		externalPicturesWriter: LeExternalPicturesWriter new)
		stream: stream) ].
	self assert: (html includesSubstring:'<div>
	<div class="snippet textual-snippet code-snippet pharo-snippet documentWidth">
		<pre class="no_bottom_margin">
pictureSnippet
	<gtExample>').
	self assert: (html includesSubstring:'</pre>
	</div>
	<div class="height-one-em">
	</div>
	<figure class="documentWidth">
		<img src="gt-figures/1000.png">
		</img>
	</figure>
</div>').
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
	self assert: html trimBoth
		equals: '<div class="snippet textual-snippet code-snippet pharo-snippet">
	<pre class="no_bottom_margin">
answer := 41.
</pre>
</div>'.
	^ html

]

{ #category : #accessing }
LeHtmlFragmentExporterExamples >> pictureFile [
	^ (GtResourcesUtility resourceAtPath: Path 
		* 'feenkcom'
		/ 'gtoolkit-demos' 
		/ 'data' 
		/ 'faceapi' 
		/ '1280px-Einstein-with-habicht-and-solovine.jpg') asUrl asString
]

{ #category : #accessing }
LeHtmlFragmentExporterExamples >> pictureSnippet [
	<gtExample>
	| markdown html |
	markdown := LePictureSnippet new urlString: self pictureFile.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	self assert: (html beginsWith: '<img class="snippet picture-snippet paragraphWidth" src=').
	self assert: (html includesSubstring: 'feenkcom/gtoolkit-demos/data/faceapi/1280px-Einstein-with-habicht-and-solovine.jpg"/>').
	^ html
]
