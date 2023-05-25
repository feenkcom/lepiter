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
  <p>
<i>italic</i> <b>bold</b> <code>mono</code>
  </p>
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
	self assert: (html includesSubstring: '<code class="class_annotation">').
	self assert: (html includesSubstring: 'LeHtmlFragmentExporterExamples').
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
  <p>
    <div class="code_block">
      <pre>
        <code class="smalltalk">
answer:=42.
        </code>
      </pre>
    </div>
  </p>
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
		externalPicturesWriter: LeResourcesExporter new)
		stream: stream) ].
	self assert: (html includesSubstring:'<div>
  <div class="snippet textual-snippet code-snippet pharo-snippet documentWidth">
    <pre class="no_bottom_margin">
pictureSnippet
	<gtExample>').
	self assert: (html includesSubstring:'  <div class="height-one-em">
  </div>').
	self assert: (html includesSubstring:'<figure class="documentWidth">
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
	self assert: (html includesSubstring: 'method_annotation expandable_annotation_label').
	self assert: (html includesSubstring: 'LeHtmlFragmentExporterExamples&gt;&gt;#basicMarkdown').
	self assert: (html includesSubstring: 'textual-snippet code-snippet pharo-method-snippet expandable_annotation_body hidden_annotation').
	^ html
]

{ #category : #examples }
LeHtmlFragmentExporterExamples >> methodAnnotation_withInexistentClassAndNameParameter [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '{{gtMethod:name=LeHtmlInexistentClass>>#inexistentMethod}}'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].

	self 
		assert: (html includesSubstring: 'name=LeHtmlInexistentClass>>#inexistentMethod') not 
		description: [ 'The `name=` part must not be included' ].
	self assert: (html includesSubstring: 'method_annotation expandable_annotation_label').
	self assert: (html includesSubstring: 'LeHtmlInexistentClass&gt;&gt;#inexistentMethod').
	self assert: (html includesSubstring: 'textual-snippet code-snippet pharo-method-snippet expandable_annotation_body hidden_annotation').
	^ html
]

{ #category : #examples }
LeHtmlFragmentExporterExamples >> methodAnnotation_withNameParameter [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '{{gtMethod:name=LeHtmlFragmentExporterExamples>>#basicMarkdown}}'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].

	self 
		assert: (html includesSubstring: 'name=LeHtmlFragmentExporterExamples') not 
		description: [ 'The `name=` part must not be included' ].
	self assert: (html includesSubstring: 'method_annotation expandable_annotation_label').
	self assert: (html includesSubstring: 'LeHtmlFragmentExporterExamples&gt;&gt;#basicMarkdown').
	self assert: (html includesSubstring: 'textual-snippet code-snippet pharo-method-snippet expandable_annotation_body hidden_annotation').
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
	self assert: (html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"').
	self assert: (html includesSubstring: 'feenkcom/gtoolkit-demos/data/faceapi/1280px-Einstein-with-habicht-and-solovine.jpg"/>').
	^ html
]
